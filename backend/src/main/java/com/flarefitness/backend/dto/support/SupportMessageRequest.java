package com.flarefitness.backend.dto.support;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

public record SupportMessageRequest(
        @NotBlank(message = "Noi dung tin nhan la bat buoc.")
        @Size(max = 2000, message = "Noi dung tin nhan toi da 2000 ky tu.")
        String text
) {
}
