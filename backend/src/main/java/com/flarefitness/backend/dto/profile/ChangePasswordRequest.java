package com.flarefitness.backend.dto.profile;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

public record ChangePasswordRequest(
        @NotBlank(message = "Mật khẩu hiện tại là bắt buộc.")
        String currentPassword,
        @NotBlank(message = "Mật khẩu mới là bắt buộc.")
        @Size(min = 6, message = "Mật khẩu mới phải có ít nhất 6 ký tự.")
        String newPassword,
        @NotBlank(message = "Xác nhận mật khẩu là bắt buộc.")
        String confirmPassword
) {
}
