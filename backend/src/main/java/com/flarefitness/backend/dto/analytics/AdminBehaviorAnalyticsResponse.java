package com.flarefitness.backend.dto.analytics;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

public record AdminBehaviorAnalyticsResponse(
        LocalDate fromDate,
        LocalDate toDate,
        long totalEvents,
        long uniqueUsers,
        long totalProductViews,
        long totalSearches,
        long totalCartAdds,
        long totalPurchases,
        long totalReviews,
        long averageStaySeconds,
        BigDecimal totalRevenue,
        List<NamedMetricResponse> topProducts,
        List<NamedMetricResponse> topCategories,
        List<NamedMetricResponse> topKeywords,
        List<NamedMetricResponse> topPriceBuckets
) {
}
