package com.flarefitness.backend.controller.analytics;

import com.flarefitness.backend.dto.analytics.BehaviorEventResponse;
import com.flarefitness.backend.dto.analytics.TrackBehaviorEventRequest;
import com.flarefitness.backend.dto.analytics.UserBehaviorInsightResponse;
import com.flarefitness.backend.dto.product.ProductResponse;
import com.flarefitness.backend.service.analytics.BehaviorAnalyticsService;
import jakarta.validation.Valid;
import java.util.List;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/analytics")
public class AnalyticsController {

    private final BehaviorAnalyticsService behaviorAnalyticsService;

    public AnalyticsController(BehaviorAnalyticsService behaviorAnalyticsService) {
        this.behaviorAnalyticsService = behaviorAnalyticsService;
    }

    @PostMapping("/events")
    public ResponseEntity<BehaviorEventResponse> trackEvent(
            @Valid @RequestBody TrackBehaviorEventRequest request,
            Authentication authentication
    ) {
        return ResponseEntity.ok(behaviorAnalyticsService.trackEvent(request, authentication));
    }

    @GetMapping("/me/insights")
    public ResponseEntity<UserBehaviorInsightResponse> getCurrentInsights(Authentication authentication) {
        return ResponseEntity.ok(behaviorAnalyticsService.getCurrentUserInsights(authentication));
    }

    @GetMapping("/recommendations")
    public ResponseEntity<List<ProductResponse>> getRecommendations(
            Authentication authentication,
            @RequestParam(required = false) String sessionId,
            @RequestParam(defaultValue = "home") String context,
            @RequestParam(required = false) String productId,
            @RequestParam(required = false) List<String> productIds,
            @RequestParam(defaultValue = "8") Integer limit
    ) {
        return ResponseEntity.ok(
                behaviorAnalyticsService.getRecommendations(authentication, sessionId, context, productId, productIds, limit)
        );
    }
}
