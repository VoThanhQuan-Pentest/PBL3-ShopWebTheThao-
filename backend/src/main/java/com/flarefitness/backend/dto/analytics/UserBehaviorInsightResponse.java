package com.flarefitness.backend.dto.analytics;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

public record UserBehaviorInsightResponse(
        String favoriteCategory,
        String favoriteBrand,
        String preferredPriceBucket,
        BigDecimal preferredPriceMin,
        BigDecimal preferredPriceMax,
        List<NamedMetricResponse> topCategories,
        List<NamedMetricResponse> topBrands,
        List<NamedMetricResponse> topKeywords,
        String lastViewedProductId,
        int totalInteractions,
        int totalPurchases,
        int averageStaySeconds,
        LocalDateTime updatedAt
) {
}
