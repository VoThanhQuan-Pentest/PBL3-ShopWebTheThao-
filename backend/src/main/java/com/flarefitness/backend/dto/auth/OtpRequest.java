package com.flarefitness.backend.dto.auth;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;

public record OtpRequest(
        String username,
        @NotBlank(message = "Email la bat buoc.")
        @Email(message = "Email khong dung dinh dang.")
        String email
) {
}
