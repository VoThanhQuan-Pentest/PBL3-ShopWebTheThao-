package com.flarefitness.backend.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.flarefitness.backend.dto.product.ProductResponse;
import com.flarefitness.backend.dto.product.UpsertProductRequest;
import com.flarefitness.backend.entity.Product;
import com.flarefitness.backend.exception.BadRequestException;
import com.flarefitness.backend.exception.ResourceNotFoundException;
import com.flarefitness.backend.repository.ProductRepository;
import java.time.Duration;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ProductService {

    private final ProductRepository productRepository;
    private final StringRedisTemplate redisTemplate;
    private final ObjectMapper objectMapper;
    private final String productPrefix;
    private final String productListKey;
    private final long ttlSeconds;

    public ProductService(
            ProductRepository productRepository,
            StringRedisTemplate redisTemplate,
            ObjectMapper objectMapper,
            @Value("${app.cache.product-prefix}") String productPrefix,
            @Value("${app.cache.product-list-key}") String productListKey,
            @Value("${app.cache.product-ttl-seconds}") long ttlSeconds
    ) {
        this.productRepository = productRepository;
        this.redisTemplate = redisTemplate;
        this.objectMapper = objectMapper;
        this.productPrefix = productPrefix;
        this.productListKey = productListKey;
        this.ttlSeconds = ttlSeconds;
    }

    public List<ProductResponse> getAllProducts() {
        String cachedJson = redisTemplate.opsForValue().get(productListKey);
        if (cachedJson != null) {
            try {
                return objectMapper.readValue(cachedJson, new TypeReference<List<ProductResponse>>() { });
            } catch (JsonProcessingException ignored) {
                redisTemplate.delete(productListKey);
            }
        }

        List<ProductResponse> products = productRepository.findAllByOrderByCreatedAtDesc()
                .stream()
                .map(this::toResponse)
                .toList();
        cache(productListKey, products);
        return products;
    }

    public ProductResponse getProductById(String id) {
        String cacheKey = productPrefix + id;
        String cachedJson = redisTemplate.opsForValue().get(cacheKey);
        if (cachedJson != null) {
            try {
                return objectMapper.readValue(cachedJson, ProductResponse.class);
            } catch (JsonProcessingException ignored) {
                redisTemplate.delete(cacheKey);
            }
        }

        Product product = productRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Không tìm thấy sản phẩm."));
        ProductResponse response = toResponse(product);
        cache(cacheKey, response);
        return response;
    }

    @Transactional
    public ProductResponse createProduct(UpsertProductRequest request) {
        productRepository.findBySkuIgnoreCase(request.sku())
                .ifPresent(existing -> {
                    throw new BadRequestException("SKU đã tồn tại.");
                });

        Product product = new Product();
        product.setId(UUID.randomUUID().toString());
        product.setCreatedAt(LocalDateTime.now());
        apply(product, request);

        Product saved = productRepository.save(product);
        evictProductCaches(saved.getId());
        return toResponse(saved);
    }

    @Transactional
    public ProductResponse updateProduct(String id, UpsertProductRequest request) {
        Product product = productRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Không tìm thấy sản phẩm."));

        productRepository.findBySkuIgnoreCase(request.sku())
                .filter(existing -> !existing.getId().equals(id))
                .ifPresent(existing -> {
                    throw new BadRequestException("SKU đã tồn tại.");
                });

        apply(product, request);
        Product saved = productRepository.save(product);
        evictProductCaches(id);
        return toResponse(saved);
    }

    @Transactional
    public void deleteProduct(String id) {
        if (!productRepository.existsById(id)) {
            throw new ResourceNotFoundException("Không tìm thấy sản phẩm.");
        }
        productRepository.deleteById(id);
        evictProductCaches(id);
    }

    private void apply(Product product, UpsertProductRequest request) {
        product.setTenSanPham(request.tenSanPham());
        product.setSku(request.sku());
        product.setDanhMuc(request.danhMuc());
        product.setThuongHieu(request.thuongHieu());
        product.setSize(request.size());
        product.setMau(request.mau());
        product.setGiaNhap(request.giaNhap());
        product.setGiaBan(request.giaBan());
        product.setTonKho(request.tonKho());
        product.setTrangThai(request.trangThai());
        product.setLinkSanPham(request.linkSanPham());
        product.setGhiChu(request.ghiChu());
    }

    private ProductResponse toResponse(Product product) {
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
                product.getGhiChu(),
                product.getCreatedAt()
        );
    }

    private void cache(String key, Object value) {
        try {
            redisTemplate.opsForValue().set(key, objectMapper.writeValueAsString(value), Duration.ofSeconds(ttlSeconds));
        } catch (JsonProcessingException ignored) {
            redisTemplate.delete(key);
        }
    }

    private void evictProductCaches(String id) {
        redisTemplate.delete(productListKey);
        redisTemplate.delete(productPrefix + id);
    }
}
