package com.flarefitness.backend.dto.auth;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;

public record ForgotPasswordRequest(
        @NotBlank(message = "Tên đăng nhập là bắt buộc.")
        String username,
        @NotBlank(message = "Email là bắt buộc.")
        @Email(message = "Email không đúng định dạng.")
        String email,
        @NotBlank(message = "Mật khẩu mới là bắt buộc.")
        @Size(min = 6, max = 255, message = "Mật khẩu mới phải có ít nhất 6 ký tự.")
        @Pattern(
                regexp = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[^A-Za-z\\d]).+$",
                message = "Mật khẩu mới phải có chữ hoa, chữ thường, chữ số và ký tự đặc biệt như @ hoặc #."
        )
        String newPassword,
        @NotBlank(message = "Xác nhận mật khẩu là bắt buộc.")
        String confirmPassword,
        @NotBlank(message = "Mã OTP là bắt buộc.")
        @Size(min = 6, max = 6, message = "Mã OTP phải gồm 6 chữ số.")
        String otpCode
) {
}
