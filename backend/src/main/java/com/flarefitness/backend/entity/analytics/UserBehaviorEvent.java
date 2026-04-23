package com.flarefitness.backend.entity.analytics;

import com.flarefitness.backend.dto.analytics.BehaviorEventType;
import com.flarefitness.backend.dto.analytics.BehaviorPageType;
import com.flarefitness.backend.entity.BaseEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;

@Entity
@Table(name = "tbl_su_kien_hanh_vi_nguoi_dung")
public class UserBehaviorEvent extends BaseEntity {

    @Id
    @Column(name = "id", nullable = false, length = 64)
    private String id;

    @Column(name = "user_id", length = 64)
    private String userId;

    @Column(name = "session_id", nullable = false, length = 100)
    private String sessionId;

    @Enumerated(EnumType.STRING)
    @Column(name = "event_type", nullable = false, length = 50)
    private BehaviorEventType eventType;

    @Enumerated(EnumType.STRING)
    @Column(name = "page_type", length = 50)
    private BehaviorPageType pageType;

    @Column(name = "page_key", length = 255)
    private String pageKey;

    @Column(name = "product_id", length = 64)
    private String productId;

    @Column(name = "order_id", length = 64)
    private String orderId;

    @Column(name = "category_key", length = 100)
    private String categoryKey;

    @Column(name = "brand_key", length = 100)
    private String brandKey;

    @Column(name = "search_keyword", length = 255)
    private String searchKeyword;

    @Column(name = "price_bucket", length = 50)
    private String priceBucket;

    @Column(name = "price_value", precision = 15, scale = 2)
    private BigDecimal priceValue;

    @Column(name = "quantity")
    private Integer quantity;

    @Column(name = "duration_seconds")
    private Integer durationSeconds;

    @Column(name = "metadata_json", columnDefinition = "json")
    private String metadataJson;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getSessionId() {
        return sessionId;
    }

    public void setSessionId(String sessionId) {
        this.sessionId = sessionId;
    }

    public BehaviorEventType getEventType() {
        return eventType;
    }

    public void setEventType(BehaviorEventType eventType) {
        this.eventType = eventType;
    }

    public BehaviorPageType getPageType() {
        return pageType;
    }

    public void setPageType(BehaviorPageType pageType) {
        this.pageType = pageType;
    }

    public String getPageKey() {
        return pageKey;
    }

    public void setPageKey(String pageKey) {
        this.pageKey = pageKey;
    }

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String getCategoryKey() {
        return categoryKey;
    }

    public void setCategoryKey(String categoryKey) {
        this.categoryKey = categoryKey;
    }

    public String getBrandKey() {
        return brandKey;
    }

    public void setBrandKey(String brandKey) {
        this.brandKey = brandKey;
    }

    public String getSearchKeyword() {
        return searchKeyword;
    }

    public void setSearchKeyword(String searchKeyword) {
        this.searchKeyword = searchKeyword;
    }

    public String getPriceBucket() {
        return priceBucket;
    }

    public void setPriceBucket(String priceBucket) {
        this.priceBucket = priceBucket;
    }

    public BigDecimal getPriceValue() {
        return priceValue;
    }

    public void setPriceValue(BigDecimal priceValue) {
        this.priceValue = priceValue;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public Integer getDurationSeconds() {
        return durationSeconds;
    }

    public void setDurationSeconds(Integer durationSeconds) {
        this.durationSeconds = durationSeconds;
    }

    public String getMetadataJson() {
        return metadataJson;
    }

    public void setMetadataJson(String metadataJson) {
        this.metadataJson = metadataJson;
    }
}
