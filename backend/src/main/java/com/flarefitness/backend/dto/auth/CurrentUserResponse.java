package com.flarefitness.backend.dto.auth;

public record CurrentUserResponse(
        String id,
        String username,
        String role,
        String hoTen,
        String email,
        String sdt
) {
}
