package com.flarefitness.backend.dto.profile;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;

public record UpdateProfileRequest(
        @NotBlank(message = "Họ tên là bắt buộc.")
        String hoTen,
        @Email(message = "Email không hợp lệ.")
        String email,
        String sdt
) {
}
