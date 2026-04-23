package com.flarefitness.backend.entity.analytics;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "tbl_ho_so_hanh_vi_nguoi_dung")
public class UserBehaviorProfile {

    @Id
    @Column(name = "user_id", nullable = false, length = 64)
    private String userId;

    @Column(name = "favorite_category", length = 100)
    private String favoriteCategory;

    @Column(name = "favorite_brand", length = 100)
    private String favoriteBrand;

    @Column(name = "preferred_price_bucket", length = 50)
    private String preferredPriceBucket;

    @Column(name = "price_min", precision = 15, scale = 2)
    private BigDecimal priceMin;

    @Column(name = "price_max", precision = 15, scale = 2)
    private BigDecimal priceMax;

    @Column(name = "top_categories_json", columnDefinition = "json")
    private String topCategoriesJson;

    @Column(name = "top_brands_json", columnDefinition = "json")
    private String topBrandsJson;

    @Column(name = "top_keywords_json", columnDefinition = "json")
    private String topKeywordsJson;

    @Column(name = "last_viewed_product_id", length = 64)
    private String lastViewedProductId;

    @Column(name = "total_interactions", nullable = false)
    private Integer totalInteractions;

    @Column(name = "average_stay_seconds", nullable = false)
    private Integer averageStaySeconds;

    @Column(name = "total_purchases", nullable = false)
    private Integer totalPurchases;

    @Column(name = "ngay_tao", nullable = false, updatable = false)
    private LocalDateTime createdAt;

    @Column(name = "ngay_cap_nhat", nullable = false)
    private LocalDateTime updatedAt;

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getFavoriteCategory() {
        return favoriteCategory;
    }

    public void setFavoriteCategory(String favoriteCategory) {
        this.favoriteCategory = favoriteCategory;
    }

    public String getFavoriteBrand() {
        return favoriteBrand;
    }

    public void setFavoriteBrand(String favoriteBrand) {
        this.favoriteBrand = favoriteBrand;
    }

    public String getPreferredPriceBucket() {
        return preferredPriceBucket;
    }

    public void setPreferredPriceBucket(String preferredPriceBucket) {
        this.preferredPriceBucket = preferredPriceBucket;
    }

    public BigDecimal getPriceMin() {
        return priceMin;
    }

    public void setPriceMin(BigDecimal priceMin) {
        this.priceMin = priceMin;
    }

    public BigDecimal getPriceMax() {
        return priceMax;
    }

    public void setPriceMax(BigDecimal priceMax) {
        this.priceMax = priceMax;
    }

    public String getTopCategoriesJson() {
        return topCategoriesJson;
    }

    public void setTopCategoriesJson(String topCategoriesJson) {
        this.topCategoriesJson = topCategoriesJson;
    }

    public String getTopBrandsJson() {
        return topBrandsJson;
    }

    public void setTopBrandsJson(String topBrandsJson) {
        this.topBrandsJson = topBrandsJson;
    }

    public String getTopKeywordsJson() {
        return topKeywordsJson;
    }

    public void setTopKeywordsJson(String topKeywordsJson) {
        this.topKeywordsJson = topKeywordsJson;
    }

    public String getLastViewedProductId() {
        return lastViewedProductId;
    }

    public void setLastViewedProductId(String lastViewedProductId) {
        this.lastViewedProductId = lastViewedProductId;
    }

    public Integer getTotalInteractions() {
        return totalInteractions;
    }

    public void setTotalInteractions(Integer totalInteractions) {
        this.totalInteractions = totalInteractions;
    }

    public Integer getAverageStaySeconds() {
        return averageStaySeconds;
    }

    public void setAverageStaySeconds(Integer averageStaySeconds) {
        this.averageStaySeconds = averageStaySeconds;
    }

    public Integer getTotalPurchases() {
        return totalPurchases;
    }

    public void setTotalPurchases(Integer totalPurchases) {
        this.totalPurchases = totalPurchases;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }
}
