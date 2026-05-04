package com.flarefitness.backend.service.analytics;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.flarefitness.backend.dto.analytics.AdminBehaviorAnalyticsResponse;
import com.flarefitness.backend.dto.analytics.BehaviorEventResponse;
import com.flarefitness.backend.dto.analytics.BehaviorEventType;
import com.flarefitness.backend.dto.analytics.NamedMetricResponse;
import com.flarefitness.backend.dto.analytics.TrackBehaviorEventRequest;
import com.flarefitness.backend.dto.analytics.UserBehaviorInsightResponse;
import com.flarefitness.backend.dto.product.ProductResponse;
import com.flarefitness.backend.entity.Order;
import com.flarefitness.backend.entity.Product;
import com.flarefitness.backend.entity.User;
import com.flarefitness.backend.entity.analytics.UserBehaviorEvent;
import com.flarefitness.backend.entity.analytics.UserBehaviorProfile;
import com.flarefitness.backend.exception.BadRequestException;
import com.flarefitness.backend.repository.OrderRepository;
import com.flarefitness.backend.repository.ProductRepository;
import com.flarefitness.backend.repository.UserRepository;
import com.flarefitness.backend.repository.analytics.UserBehaviorEventRepository;
import com.flarefitness.backend.repository.analytics.UserBehaviorProfileRepository;
import java.math.BigDecimal;
import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Comparator;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Objects;
import java.util.Optional;
import java.util.Set;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;
import java.util.function.Function;
import java.util.stream.Collectors;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class BehaviorAnalyticsService {

    private static final int PROFILE_EVENT_LOOKBACK = 300;
    private static final int POPULARITY_LOOKBACK_EVENTS = 1500;
    private static final int DEFAULT_RECOMMENDATION_LIMIT = 8;
    private static final int DEFAULT_TOP_ITEMS_LIMIT = 8;
    private static final int DEFAULT_PROFILE_TOP_LIMIT = 5;
    private static final Duration BEHAVIOR_RECALCULATION_INTERVAL = Duration.ofHours(2);

    private final UserBehaviorEventRepository eventRepository;
    private final UserBehaviorProfileRepository profileRepository;
    private final UserRepository userRepository;
    private final ProductRepository productRepository;
    private final OrderRepository orderRepository;
    private final ObjectMapper objectMapper;
    private final Map<String, RecommendationCacheEntry> recommendationCache = new ConcurrentHashMap<>();

    public BehaviorAnalyticsService(
            UserBehaviorEventRepository eventRepository,
            UserBehaviorProfileRepository profileRepository,
            UserRepository userRepository,
            ProductRepository productRepository,
            OrderRepository orderRepository,
            ObjectMapper objectMapper
    ) {
        this.eventRepository = eventRepository;
        this.profileRepository = profileRepository;
        this.userRepository = userRepository;
        this.productRepository = productRepository;
        this.orderRepository = orderRepository;
        this.objectMapper = objectMapper;
    }

    @Transactional
    public BehaviorEventResponse trackEvent(TrackBehaviorEventRequest request, Authentication authentication) {
        String userId = resolveUserId(authentication);
        Product product = resolveProduct(request.productId());
        String sessionId = trimToNull(request.sessionId());
        if (sessionId == null) {
            sessionId = "guest-" + UUID.randomUUID();
        }

        BigDecimal priceValue = request.priceValue() != null
                ? request.priceValue()
                : (product != null ? product.getGiaBan() : null);

        UserBehaviorEvent event = new UserBehaviorEvent();
        event.setId(UUID.randomUUID().toString());
        event.setCreatedAt(LocalDateTime.now());
        event.setUserId(userId);
        event.setSessionId(sessionId);
        event.setEventType(request.eventType());
        event.setPageType(request.pageType());
        event.setPageKey(trimToNull(request.pageKey()));
        event.setProductId(product != null ? product.getId() : trimToNull(request.productId()));
        event.setOrderId(trimToNull(request.orderId()));
        event.setCategoryKey(firstNonBlank(request.categoryKey(), product != null ? product.getDanhMuc() : null));
        event.setBrandKey(firstNonBlank(request.brandKey(), product != null ? product.getThuongHieu() : null));
        event.setSearchKeyword(trimToNull(request.searchKeyword()));
        event.setPriceValue(priceValue);
        event.setPriceBucket(resolvePriceBucket(priceValue));
        event.setQuantity(request.quantity());
        event.setDurationSeconds(request.durationSeconds());
        event.setMetadataJson(writeJson(request.metadata()));
        eventRepository.save(event);

        rebuildUserProfileIfDue(userId, event.getCreatedAt());

        return new BehaviorEventResponse("RECORDED", sessionId, event.getCreatedAt());
    }

    @Transactional
    public UserBehaviorInsightResponse getCurrentUserInsights(Authentication authentication) {
        String userId = requireUserId(authentication);
        UserBehaviorProfile profile = profileRepository.findById(userId).orElse(null);
        if (profile == null) {
            profile = rebuildUserProfile(userId);
        }
        return toInsightResponse(profile);
    }

    @Transactional
    public UserBehaviorProfile rebuildUserProfile(String userId) {
        List<UserBehaviorEvent> recentEvents = eventRepository.findTop300ByUserIdOrderByCreatedAtDesc(userId);
        BehaviorSnapshot snapshot = buildSnapshot(recentEvents);

        UserBehaviorProfile profile = profileRepository.findById(userId).orElseGet(UserBehaviorProfile::new);
        LocalDateTime now = LocalDateTime.now();
        if (profile.getCreatedAt() == null) {
            profile.setCreatedAt(now);
        }

        profile.setUserId(userId);
        profile.setFavoriteCategory(snapshot.favoriteCategory());
        profile.setFavoriteBrand(snapshot.favoriteBrand());
        profile.setPreferredPriceBucket(snapshot.preferredPriceBucket());
        profile.setPriceMin(snapshot.priceMin());
        profile.setPriceMax(snapshot.priceMax());
        profile.setTopCategoriesJson(writeJson(snapshot.topCategories()));
        profile.setTopBrandsJson(writeJson(snapshot.topBrands()));
        profile.setTopKeywordsJson(writeJson(snapshot.topKeywords()));
        profile.setLastViewedProductId(snapshot.lastViewedProductId());
        profile.setTotalInteractions(snapshot.totalInteractions());
        profile.setAverageStaySeconds(snapshot.averageStaySeconds());
        profile.setTotalPurchases(snapshot.totalPurchases());
        profile.setUpdatedAt(now);

        return profileRepository.save(profile);
    }

    private void rebuildUserProfileIfDue(String userId, LocalDateTime now) {
        String safeUserId = trimToNull(userId);
        if (safeUserId == null) {
            return;
        }

        LocalDateTime threshold = (now != null ? now : LocalDateTime.now()).minus(BEHAVIOR_RECALCULATION_INTERVAL);
        UserBehaviorProfile profile = profileRepository.findById(safeUserId).orElse(null);
        if (profile == null || profile.getUpdatedAt() == null || profile.getUpdatedAt().isBefore(threshold)) {
            rebuildUserProfile(safeUserId);
        }
    }

    @Transactional(readOnly = true)
    public List<ProductResponse> getRecommendations(
            Authentication authentication,
            String sessionId,
            String context,
            String productId,
            List<String> productIds,
            Integer limit
    ) {
        int safeLimit = Math.min(Math.max(limit == null ? DEFAULT_RECOMMENDATION_LIMIT : limit, 1), 16);
        String userId = resolveUserId(authentication);
        String normalizedSessionId = trimToNull(sessionId);
        String normalizedContext = trimToNull(context) != null ? trimToNull(context).toLowerCase(Locale.ROOT) : "home";
        LocalDateTime now = LocalDateTime.now();
        String cacheKey = buildRecommendationCacheKey(userId, normalizedSessionId, normalizedContext, productId, productIds, safeLimit);
        RecommendationCacheEntry cachedEntry = recommendationCache.get(cacheKey);
        if (cachedEntry != null && cachedEntry.expiresAt().isAfter(now)) {
            return cachedEntry.products();
        }
        if (cachedEntry != null) {
            recommendationCache.remove(cacheKey);
        }

        BehaviorSnapshot snapshot = userId != null
                ? buildSnapshot(eventRepository.findTop300ByUserIdOrderByCreatedAtDesc(userId))
                : buildSnapshot(normalizedSessionId == null
                ? List.of()
                : eventRepository.findTop300BySessionIdOrderByCreatedAtDesc(normalizedSessionId));

        Map<String, Long> popularityScores = buildWeightedProductMap(
                eventRepository.findTop1500ByCreatedAtAfterOrderByCreatedAtDesc(now.minusDays(30)),
                60
        );

        List<Product> products = productRepository.findAllByOrderByCreatedAtDesc();
        Map<String, Product> productIndex = products.stream()
                .collect(Collectors.toMap(Product::getId, Function.identity(), (left, right) -> left, LinkedHashMap::new));

        Product contextProduct = productIndex.get(trimToNull(productId));
        Set<String> excludedIds = new LinkedHashSet<>();
        if (contextProduct != null) {
            excludedIds.add(contextProduct.getId());
        }
        if (productIds != null) {
            productIds.stream()
                    .map(this::trimToNull)
                    .filter(Objects::nonNull)
                    .forEach(excludedIds::add);
        }

        List<ProductScore> scoredProducts = new ArrayList<>();

        for (Product product : products) {
            if (product == null || product.getTonKho() == null || product.getTonKho() <= 0) {
                continue;
            }
            if (excludedIds.contains(product.getId())) {
                continue;
            }

            long score = popularityScores.getOrDefault(product.getId(), 0L);
            score += snapshot.categoryScores().getOrDefault(cleanKey(product.getDanhMuc()), 0L) * 5;
            score += snapshot.brandScores().getOrDefault(cleanKey(product.getThuongHieu()), 0L) * 4;
            score += snapshot.priceBucketScores().getOrDefault(resolvePriceBucket(product.getGiaBan()), 0L) * 3;

            if ("detail".equals(normalizedContext) && contextProduct != null) {
                if (sameIgnoreCase(product.getDanhMuc(), contextProduct.getDanhMuc())) {
                    score += 40;
                }
                if (sameIgnoreCase(product.getThuongHieu(), contextProduct.getThuongHieu())) {
                    score += 18;
                }
            }

            if ("cart".equals(normalizedContext) && productIds != null && !productIds.isEmpty()) {
                List<Product> cartProducts = productIds.stream()
                        .map(productIndex::get)
                        .filter(Objects::nonNull)
                        .toList();
                long categoryMatches = cartProducts.stream()
                        .filter(item -> sameIgnoreCase(item.getDanhMuc(), product.getDanhMuc()))
                        .count();
                long brandMatches = cartProducts.stream()
                        .filter(item -> sameIgnoreCase(item.getThuongHieu(), product.getThuongHieu()))
                        .count();
                score += categoryMatches * 18;
                score += brandMatches * 8;
            }

            if ("home".equals(normalizedContext) && sameIgnoreCase(product.getDanhMuc(), snapshot.favoriteCategory())) {
                score += 24;
            }

            if (score > 0) {
                scoredProducts.add(new ProductScore(product, score));
            }
        }

        List<ProductResponse> recommendations = scoredProducts.stream()
                .sorted(Comparator.comparingLong(ProductScore::score).reversed()
                        .thenComparing(item -> item.product().getCreatedAt(), Comparator.nullsLast(Comparator.reverseOrder())))
                .limit(safeLimit)
                .map(ProductScore::product)
                .map(this::toProductResponse)
                .toList();
        recommendationCache.put(cacheKey, new RecommendationCacheEntry(List.copyOf(recommendations), now.plus(BEHAVIOR_RECALCULATION_INTERVAL)));
        return recommendations;
    }

    @Transactional(readOnly = true)
    public AdminBehaviorAnalyticsResponse getAdminAnalytics(LocalDate fromDate, LocalDate toDate) {
        LocalDate today = LocalDate.now();
        LocalDate safeFrom = fromDate != null ? fromDate : today.minusDays(29);
        LocalDate safeTo = toDate != null ? toDate : today;

        if (safeFrom.isAfter(safeTo)) {
            throw new BadRequestException("Ngày bắt đầu không được lớn hơn ngày kết thúc.");
        }

        LocalDateTime fromDateTime = safeFrom.atStartOfDay();
        LocalDateTime toDateTime = safeTo.plusDays(1).atStartOfDay().minusSeconds(1);
        List<UserBehaviorEvent> events = eventRepository.findByCreatedAtBetween(fromDateTime, toDateTime);

        long totalProductViews = events.stream().filter(event -> event.getEventType() == BehaviorEventType.PRODUCT_VIEW).count();
        long totalSearches = events.stream().filter(event -> event.getEventType() == BehaviorEventType.PRODUCT_SEARCH).count();
        long totalCartAdds = events.stream().filter(event -> event.getEventType() == BehaviorEventType.ADD_TO_CART).count();
        long totalPurchases = events.stream().filter(event -> event.getEventType() == BehaviorEventType.PURCHASE).count();
        long totalReviews = events.stream().filter(event -> event.getEventType() == BehaviorEventType.PRODUCT_REVIEW).count();
        long averageStaySeconds = Math.round(events.stream()
                .filter(event -> event.getEventType() == BehaviorEventType.PAGE_STAY)
                .map(UserBehaviorEvent::getDurationSeconds)
                .filter(Objects::nonNull)
                .mapToInt(Integer::intValue)
                .average()
                .orElse(0));

        Set<String> uniqueUsers = events.stream()
                .map(UserBehaviorEvent::getUserId)
                .filter(Objects::nonNull)
                .map(String::trim)
                .filter(value -> !value.isBlank())
                .collect(Collectors.toCollection(LinkedHashSet::new));

        Map<String, Long> topProductScores = buildWeightedProductMap(events, DEFAULT_TOP_ITEMS_LIMIT);
        Map<String, Product> productMap = productRepository.findAll().stream()
                .collect(Collectors.toMap(Product::getId, Function.identity(), (left, right) -> left));

        List<NamedMetricResponse> topProducts = topProductScores.entrySet().stream()
                .limit(DEFAULT_TOP_ITEMS_LIMIT)
                .map(entry -> {
                    Product product = productMap.get(entry.getKey());
                    String label = product != null ? product.getTenSanPham() : entry.getKey();
                    return new NamedMetricResponse(entry.getKey(), label, entry.getValue());
                })
                .toList();

        List<NamedMetricResponse> topCategories = toNamedMetrics(
                buildWeightedStringMap(events, UserBehaviorEvent::getCategoryKey, DEFAULT_TOP_ITEMS_LIMIT)
        );
        List<NamedMetricResponse> topKeywords = toNamedMetrics(
                buildKeywordMap(events, DEFAULT_TOP_ITEMS_LIMIT)
        );
        List<NamedMetricResponse> topPriceBuckets = toNamedMetrics(
                buildWeightedStringMap(events, UserBehaviorEvent::getPriceBucket, DEFAULT_TOP_ITEMS_LIMIT)
        );

        BigDecimal totalRevenue = orderRepository.findAll().stream()
                .filter(order -> isWithinRange(order, safeFrom, safeTo))
                .filter(order -> Boolean.TRUE.equals(order.getDaThanhToan()))
                .map(Order::getTongTien)
                .filter(Objects::nonNull)
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        return new AdminBehaviorAnalyticsResponse(
                safeFrom,
                safeTo,
                events.size(),
                uniqueUsers.size(),
                totalProductViews,
                totalSearches,
                totalCartAdds,
                totalPurchases,
                totalReviews,
                averageStaySeconds,
                totalRevenue,
                topProducts,
                topCategories,
                topKeywords,
                topPriceBuckets
        );
    }

    private String requireUserId(Authentication authentication) {
        String userId = resolveUserId(authentication);
        if (userId == null) {
            throw new BadRequestException("Không tìm thấy người dùng hiện tại.");
        }
        return userId;
    }

    private String resolveUserId(Authentication authentication) {
        if (authentication == null || authentication instanceof AnonymousAuthenticationToken) {
            return null;
        }

        String username = trimToNull(authentication.getName());
        if (username == null) {
            return null;
        }

        return userRepository.findByUsernameIgnoreCase(username)
                .map(User::getId)
                .orElse(null);
    }

    private Product resolveProduct(String productId) {
        String normalizedId = trimToNull(productId);
        if (normalizedId == null) {
            return null;
        }
        return productRepository.findById(normalizedId).orElse(null);
    }

    private BehaviorSnapshot buildSnapshot(List<UserBehaviorEvent> inputEvents) {
        List<UserBehaviorEvent> events = inputEvents == null ? List.of() : inputEvents.stream()
                .filter(Objects::nonNull)
                .limit(PROFILE_EVENT_LOOKBACK)
                .toList();

        Map<String, Long> categoryScores = new LinkedHashMap<>();
        Map<String, Long> brandScores = new LinkedHashMap<>();
        Map<String, Long> keywordScores = new LinkedHashMap<>();
        Map<String, Long> priceBucketScores = new LinkedHashMap<>();
        String lastViewedProductId = null;
        int totalPurchases = 0;
        int totalStaySeconds = 0;
        int totalStayEvents = 0;
        BigDecimal priceMin = null;
        BigDecimal priceMax = null;

        for (UserBehaviorEvent event : events) {
            long weight = resolveEventWeight(event);

            mergeScore(categoryScores, event.getCategoryKey(), weight);
            mergeScore(brandScores, event.getBrandKey(), weight);
            mergeScore(priceBucketScores, event.getPriceBucket(), weight);

            if (event.getSearchKeyword() != null) {
                tokenizeSearchKeyword(event.getSearchKeyword()).forEach(token -> mergeScore(keywordScores, token, weight));
            }

            if (lastViewedProductId == null
                    && event.getEventType() == BehaviorEventType.PRODUCT_VIEW
                    && trimToNull(event.getProductId()) != null) {
                lastViewedProductId = event.getProductId();
            }

            if (event.getEventType() == BehaviorEventType.PURCHASE) {
                totalPurchases += 1;
            }

            if (event.getDurationSeconds() != null && event.getDurationSeconds() > 0) {
                totalStaySeconds += event.getDurationSeconds();
                totalStayEvents += 1;
            }

            if (event.getPriceValue() != null) {
                priceMin = priceMin == null ? event.getPriceValue() : priceMin.min(event.getPriceValue());
                priceMax = priceMax == null ? event.getPriceValue() : priceMax.max(event.getPriceValue());
            }
        }

        return new BehaviorSnapshot(
                toOrderedMap(categoryScores, DEFAULT_PROFILE_TOP_LIMIT),
                toOrderedMap(brandScores, DEFAULT_PROFILE_TOP_LIMIT),
                toOrderedMap(keywordScores, DEFAULT_PROFILE_TOP_LIMIT),
                toOrderedMap(priceBucketScores, DEFAULT_PROFILE_TOP_LIMIT),
                getTopKey(categoryScores),
                getTopKey(brandScores),
                getTopKey(priceBucketScores),
                lastViewedProductId,
                events.size(),
                totalPurchases,
                totalStayEvents == 0 ? 0 : Math.round((float) totalStaySeconds / totalStayEvents),
                priceMin,
                priceMax
        );
    }

    private long resolveEventWeight(UserBehaviorEvent event) {
        if (event == null || event.getEventType() == null) {
            return 1;
        }

        return switch (event.getEventType()) {
            case PRODUCT_VIEW -> 3;
            case PRODUCT_SEARCH -> 4;
            case CATEGORY_CLICK -> 3;
            case ADD_TO_CART -> 8;
            case REMOVE_FROM_CART -> 2;
            case PURCHASE -> 12;
            case PRODUCT_REVIEW -> 9;
            case PAGE_STAY -> Math.max(1, Math.round((event.getDurationSeconds() == null ? 0 : event.getDurationSeconds()) / 20.0f));
        };
    }

    private Map<String, Long> buildWeightedProductMap(List<UserBehaviorEvent> events, int limit) {
        Map<String, Long> scoreMap = new LinkedHashMap<>();
        if (events == null) {
            return scoreMap;
        }

        for (UserBehaviorEvent event : events) {
            String productId = trimToNull(event.getProductId());
            if (productId == null) {
                continue;
            }

            long weight = switch (event.getEventType()) {
                case PRODUCT_VIEW -> 1;
                case ADD_TO_CART -> 4;
                case PURCHASE -> 8;
                case PRODUCT_REVIEW -> 5;
                case PRODUCT_SEARCH, CATEGORY_CLICK, REMOVE_FROM_CART, PAGE_STAY -> 1;
            };
            scoreMap.merge(productId, weight, Long::sum);
        }

        return toOrderedMap(scoreMap, limit);
    }

    private Map<String, Long> buildWeightedStringMap(
            Collection<UserBehaviorEvent> events,
            Function<UserBehaviorEvent, String> extractor,
            int limit
    ) {
        Map<String, Long> scoreMap = new LinkedHashMap<>();
        if (events == null) {
            return scoreMap;
        }

        for (UserBehaviorEvent event : events) {
            mergeScore(scoreMap, extractor.apply(event), resolveEventWeight(event));
        }

        return toOrderedMap(scoreMap, limit);
    }

    private Map<String, Long> buildKeywordMap(Collection<UserBehaviorEvent> events, int limit) {
        Map<String, Long> scoreMap = new LinkedHashMap<>();
        if (events == null) {
            return scoreMap;
        }

        for (UserBehaviorEvent event : events) {
            if (event.getSearchKeyword() == null) {
                continue;
            }

            tokenizeSearchKeyword(event.getSearchKeyword()).forEach(token -> mergeScore(scoreMap, token, resolveEventWeight(event)));
        }

        return toOrderedMap(scoreMap, limit);
    }

    private void mergeScore(Map<String, Long> scoreMap, String rawKey, long weight) {
        String key = cleanKey(rawKey);
        if (key == null || weight <= 0) {
            return;
        }
        scoreMap.merge(key, weight, Long::sum);
    }

    private List<String> tokenizeSearchKeyword(String rawKeyword) {
        String normalized = trimToNull(rawKeyword);
        if (normalized == null) {
            return List.of();
        }

        return List.of(normalized.toLowerCase(Locale.ROOT).split("\\s+")).stream()
                .map(this::trimToNull)
                .filter(Objects::nonNull)
                .filter(token -> token.length() >= 2)
                .distinct()
                .toList();
    }

    private String resolvePriceBucket(BigDecimal priceValue) {
        if (priceValue == null) {
            return null;
        }
        if (priceValue.compareTo(BigDecimal.valueOf(500_000)) < 0) {
            return "DUOI_500K";
        }
        if (priceValue.compareTo(BigDecimal.valueOf(1_000_000)) < 0) {
            return "500K_1M";
        }
        if (priceValue.compareTo(BigDecimal.valueOf(2_000_000)) < 0) {
            return "1M_2M";
        }
        if (priceValue.compareTo(BigDecimal.valueOf(5_000_000)) < 0) {
            return "2M_5M";
        }
        return "TREN_5M";
    }

    private String cleanKey(String value) {
        String normalized = trimToNull(value);
        return normalized == null ? null : normalized.replaceAll("\\s+", " ");
    }

    private String trimToNull(String value) {
        if (value == null) {
            return null;
        }

        String trimmed = value.trim();
        return trimmed.isEmpty() ? null : trimmed;
    }

    private String firstNonBlank(String primary, String fallback) {
        String normalizedPrimary = trimToNull(primary);
        return normalizedPrimary != null ? normalizedPrimary : trimToNull(fallback);
    }

    private String writeJson(Object value) {
        if (value == null) {
            return null;
        }

        try {
            return objectMapper.writeValueAsString(value);
        } catch (JsonProcessingException exception) {
            return null;
        }
    }

    private Map<String, Long> toOrderedMap(Map<String, Long> input, int limit) {
        return input.entrySet().stream()
                .filter(entry -> entry.getKey() != null && !entry.getKey().isBlank())
                .sorted(Map.Entry.<String, Long>comparingByValue().reversed()
                        .thenComparing(Map.Entry::getKey, String.CASE_INSENSITIVE_ORDER))
                .limit(Math.max(limit, 1))
                .collect(Collectors.toMap(
                        Map.Entry::getKey,
                        Map.Entry::getValue,
                        (left, right) -> left,
                        LinkedHashMap::new
                ));
    }

    private String getTopKey(Map<String, Long> input) {
        return toOrderedMap(input, 1).keySet().stream().findFirst().orElse(null);
    }

    private UserBehaviorInsightResponse toInsightResponse(UserBehaviorProfile profile) {
        return new UserBehaviorInsightResponse(
                profile.getFavoriteCategory(),
                profile.getFavoriteBrand(),
                profile.getPreferredPriceBucket(),
                profile.getPriceMin(),
                profile.getPriceMax(),
                readMetricJson(profile.getTopCategoriesJson()),
                readMetricJson(profile.getTopBrandsJson()),
                readMetricJson(profile.getTopKeywordsJson()),
                profile.getLastViewedProductId(),
                Optional.ofNullable(profile.getTotalInteractions()).orElse(0),
                Optional.ofNullable(profile.getTotalPurchases()).orElse(0),
                Optional.ofNullable(profile.getAverageStaySeconds()).orElse(0),
                profile.getUpdatedAt()
        );
    }

    private List<NamedMetricResponse> readMetricJson(String json) {
        String source = trimToNull(json);
        if (source == null) {
            return List.of();
        }

        try {
            Map<String, Long> data = objectMapper.readValue(source, new TypeReference<LinkedHashMap<String, Long>>() { });
            return toNamedMetrics(data);
        } catch (JsonProcessingException exception) {
            return List.of();
        }
    }

    private List<NamedMetricResponse> toNamedMetrics(Map<String, Long> scoreMap) {
        return scoreMap.entrySet().stream()
                .map(entry -> new NamedMetricResponse(entry.getKey(), translateBucketLabel(entry.getKey()), entry.getValue()))
                .toList();
    }

    private String translateBucketLabel(String key) {
        return switch (String.valueOf(key)) {
            case "DUOI_500K" -> "Dưới 500.000đ";
            case "500K_1M" -> "500.000đ - 1.000.000đ";
            case "1M_2M" -> "1.000.000đ - 2.000.000đ";
            case "2M_5M" -> "2.000.000đ - 5.000.000đ";
            case "TREN_5M" -> "Trên 5.000.000đ";
            default -> key;
        };
    }

    private boolean sameIgnoreCase(String left, String right) {
        return cleanKey(left) != null
                && cleanKey(right) != null
                && cleanKey(left).equalsIgnoreCase(cleanKey(right));
    }

    private boolean isWithinRange(Order order, LocalDate fromDate, LocalDate toDate) {
        if (order == null || order.getNgayDat() == null) {
            return false;
        }

        return !order.getNgayDat().isBefore(fromDate) && !order.getNgayDat().isAfter(toDate);
    }

    private String buildRecommendationCacheKey(
            String userId,
            String sessionId,
            String context,
            String productId,
            List<String> productIds,
            int limit
    ) {
        String principal = trimToNull(userId) != null
                ? "user:" + trimToNull(userId)
                : "session:" + Optional.ofNullable(trimToNull(sessionId)).orElse("anonymous");
        String relatedProducts = productIds == null
                ? ""
                : productIds.stream()
                .map(this::trimToNull)
                .filter(Objects::nonNull)
                .sorted()
                .collect(Collectors.joining(","));

        return String.join("|",
                principal,
                Optional.ofNullable(trimToNull(context)).orElse("home"),
                "limit:" + limit,
                "product:" + Optional.ofNullable(trimToNull(productId)).orElse(""),
                "items:" + relatedProducts
        );
    }

    private ProductResponse toProductResponse(Product product) {
        return new ProductResponse(
                product.getId(),
                product.getTenSanPham(),
                product.getSku(),
                product.getDanhMuc(),
                product.getThuongHieu(),
                product.getSize(),
                product.getMau(),
                product.getGiaNhap(),
                product.getGiaBan(),
                product.getTonKho(),
                product.getTrangThai(),
                product.getLinkSanPham(),
                product.getHinhAnhUrl(),
                product.getGhiChu(),
                product.getCreatedAt()
        );
    }

    private record ProductScore(Product product, long score) {
    }

    private record RecommendationCacheEntry(List<ProductResponse> products, LocalDateTime expiresAt) {
    }

    private record BehaviorSnapshot(
            Map<String, Long> categoryScores,
            Map<String, Long> brandScores,
            Map<String, Long> topKeywords,
            Map<String, Long> priceBucketScores,
            String favoriteCategory,
            String favoriteBrand,
            String preferredPriceBucket,
            String lastViewedProductId,
            int totalInteractions,
            int totalPurchases,
            int averageStaySeconds,
            BigDecimal priceMin,
            BigDecimal priceMax
    ) {
        private Map<String, Long> topCategories() {
            return categoryScores;
        }

        private Map<String, Long> topBrands() {
            return brandScores;
        }
    }
}
