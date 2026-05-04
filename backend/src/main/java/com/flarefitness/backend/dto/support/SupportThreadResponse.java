package com.flarefitness.backend.dto.support;

import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import java.time.LocalDateTime;
import java.util.List;

@JsonNaming(PropertyNamingStrategies.LowerCamelCaseStrategy.class)
public record SupportThreadResponse(
        String id,
        String accountKey,
        SupportCustomerResponse customer,
        String status,
        LocalDateTime createdAt,
        LocalDateTime updatedAt,
        List<SupportMessageResponse> messages
) {
}
