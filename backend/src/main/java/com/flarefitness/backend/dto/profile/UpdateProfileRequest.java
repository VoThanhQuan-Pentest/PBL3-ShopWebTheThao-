package com.flarefitness.backend.dto.profile;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;

public record UpdateProfileRequest(
        @NotBlank(message = "Họ tên là bắt buộc.")
        String hoTen,
        @Email(message = "Email không hợp lệ.")
        String email,
        @Pattern(
                regexp = "^(|0(3|5|7|8|9)\\d{8}|\\+84(3|5|7|8|9)\\d{8})$",
                message = "Số điện thoại phải là số di động Việt Nam hợp lệ, ví dụ 0935250037 hoặc +84935250037."
        )
        String sdt
) {
}
