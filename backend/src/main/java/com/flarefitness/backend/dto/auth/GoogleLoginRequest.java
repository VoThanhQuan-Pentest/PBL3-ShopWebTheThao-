package com.flarefitness.backend.dto.auth;

import com.fasterxml.jackson.annotation.JsonAlias;
import jakarta.validation.constraints.NotBlank;

public record GoogleLoginRequest(
        @JsonAlias("id_token")
        @NotBlank(message = "Google ID token la bat buoc.")
        String idToken
) {
}
