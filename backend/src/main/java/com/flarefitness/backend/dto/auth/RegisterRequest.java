package com.flarefitness.backend.dto.auth;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;

public record RegisterRequest(
        @NotBlank(message = "Tên đăng nhập là bắt buộc.")
        @Size(min = 4, max = 100, message = "Tên đăng nhập phải từ 4 đến 100 ký tự.")
        String username,
        @NotBlank(message = "Họ tên là bắt buộc.")
        @Size(max = 150, message = "Họ tên không được vượt quá 150 ký tự.")
        String hoTen,
        @NotBlank(message = "Email là bắt buộc.")
        @Email(message = "Email không đúng định dạng.")
        @Size(max = 150, message = "Email không được vượt quá 150 ký tự.")
        String email,
        @NotBlank(message = "Số điện thoại là bắt buộc.")
        @Size(max = 30, message = "Số điện thoại không được vượt quá 30 ký tự.")
        String sdt,
        @NotBlank(message = "Mật khẩu là bắt buộc.")
        @Size(min = 6, max = 255, message = "Mật khẩu phải có ít nhất 6 ký tự.")
        @Pattern(
                regexp = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[^A-Za-z\\d]).+$",
                message = "Mật khẩu phải có chữ hoa, chữ thường, chữ số và ký tự đặc biệt như @ hoặc #."
        )
        String password,
        @NotBlank(message = "Xác nhận mật khẩu là bắt buộc.")
        String confirmPassword
) {
}
