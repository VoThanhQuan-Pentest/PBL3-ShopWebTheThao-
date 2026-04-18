package com.flarefitness.backend.dto.auth;

public record LoginResponse(
        String accessToken,
        long expiresIn,
        CurrentUserResponse user
) {
}
