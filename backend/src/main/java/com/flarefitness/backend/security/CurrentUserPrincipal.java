package com.flarefitness.backend.security;

import com.flarefitness.backend.entity.User;
import java.util.Collection;
import java.util.List;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

public class CurrentUserPrincipal implements UserDetails {

    private final User user;

    public CurrentUserPrincipal(User user) {
        this.user = user;
    }

    public User getUser() {
        return user;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return List.of(new SimpleGrantedAuthority(toAuthority(user.getRole())));
    }

    @Override
    public String getPassword() {
        return user.getPassword();
    }

    @Override
    public String getUsername() {
        return user.getUsername();
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }

    public static String toAuthority(String role) {
        if (role == null) {
            return "ROLE_CUSTOMER";
        }

        return switch (role.trim().toLowerCase()) {
            case "quản trị viên", "admin" -> "ROLE_ADMIN";
            case "nhân viên", "staff" -> "ROLE_STAFF";
            default -> "ROLE_CUSTOMER";
        };
    }
}
