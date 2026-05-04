package com.flarefitness.backend.dto.support;

import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import java.time.LocalDateTime;

@JsonNaming(PropertyNamingStrategies.LowerCamelCaseStrategy.class)
public record SupportMessageResponse(
        String id,
        String sender,
        String text,
        LocalDateTime createdAt
) {
}
