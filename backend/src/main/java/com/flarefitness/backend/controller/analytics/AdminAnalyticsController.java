package com.flarefitness.backend.controller.analytics;

import com.flarefitness.backend.dto.analytics.AdminBehaviorAnalyticsResponse;
import com.flarefitness.backend.service.analytics.BehaviorAnalyticsService;
import java.time.LocalDate;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/admin/analytics")
public class AdminAnalyticsController {

    private final BehaviorAnalyticsService behaviorAnalyticsService;

    public AdminAnalyticsController(BehaviorAnalyticsService behaviorAnalyticsService) {
        this.behaviorAnalyticsService = behaviorAnalyticsService;
    }

    @GetMapping("/overview")
    public ResponseEntity<AdminBehaviorAnalyticsResponse> getOverview(
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate from,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate to
    ) {
        return ResponseEntity.ok(behaviorAnalyticsService.getAdminAnalytics(from, to));
    }
}
