package com.flarefitness.backend.dto.analytics;

public record NamedMetricResponse(
        String key,
        String label,
        long score
) {
}
