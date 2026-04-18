package com.flarefitness.backend.dto.auth;

import jakarta.validation.constraints.NotBlank;

public record LoginRequest(
        @NotBlank(message = "Tên đăng nhập là bắt buộc.")
        String username,
        @NotBlank(message = "Mật khẩu là bắt buộc.")
        String password
) {
}
