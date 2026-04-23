package com.flarefitness.backend.dto.analytics;

import java.time.LocalDateTime;

public record BehaviorEventResponse(
        String status,
        String sessionId,
        LocalDateTime recordedAt
) {
}
