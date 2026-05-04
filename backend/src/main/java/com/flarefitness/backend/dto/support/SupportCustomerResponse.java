package com.flarefitness.backend.dto.support;

import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;

@JsonNaming(PropertyNamingStrategies.LowerCamelCaseStrategy.class)
public record SupportCustomerResponse(
        String id,
        String name,
        String username,
        String email,
        String phone
) {
}
