package com.flarefitness.backend.dto.support;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

public record SupportThreadStatusRequest(
        @NotBlank(message = "Trang thai ho tro la bat buoc.")
        @Size(max = 50, message = "Trang thai ho tro toi da 50 ky tu.")
        String status
) {
}
