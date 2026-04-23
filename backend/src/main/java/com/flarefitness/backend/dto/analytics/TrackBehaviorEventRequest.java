package com.flarefitness.backend.dto.analytics;

import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import java.math.BigDecimal;
import java.util.Map;

public record TrackBehaviorEventRequest(
        @Size(max = 100) String sessionId,
        @NotNull BehaviorEventType eventType,
        BehaviorPageType pageType,
        @Size(max = 255) String pageKey,
        @Size(max = 64) String productId,
        @Size(max = 64) String orderId,
        @Size(max = 100) String categoryKey,
        @Size(max = 100) String brandKey,
        @Size(max = 255) String searchKeyword,
        @DecimalMin("0.0") BigDecimal priceValue,
        @Min(0) Integer quantity,
        @Min(0) Integer durationSeconds,
        Map<String, Object> metadata
) {
}
