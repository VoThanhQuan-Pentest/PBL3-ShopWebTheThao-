package com.flarefitness.backend.service;

import com.flarefitness.backend.dto.auth.CurrentUserResponse;
import com.flarefitness.backend.dto.auth.LoginRequest;
import com.flarefitness.backend.dto.auth.LoginResponse;
import com.flarefitness.backend.entity.Customer;
import com.flarefitness.backend.entity.User;
import com.flarefitness.backend.exception.UnauthorizedException;
import com.flarefitness.backend.repository.CustomerRepository;
import com.flarefitness.backend.repository.UserRepository;
import com.flarefitness.backend.security.CurrentUserPrincipal;
import com.flarefitness.backend.security.IpRateLimitService;
import com.flarefitness.backend.security.JwtTokenService;
import com.flarefitness.backend.security.RedisTokenStore;
import java.util.Optional;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class AuthService {

    private final UserRepository userRepository;
    private final CustomerRepository customerRepository;
    private final PasswordEncoder passwordEncoder;
    private final JwtTokenService jwtTokenService;
    private final RedisTokenStore redisTokenStore;
    private final IpRateLimitService ipRateLimitService;

    public AuthService(
            UserRepository userRepository,
            CustomerRepository customerRepository,
            PasswordEncoder passwordEncoder,
            JwtTokenService jwtTokenService,
            RedisTokenStore redisTokenStore,
            IpRateLimitService ipRateLimitService
    ) {
        this.userRepository = userRepository;
        this.customerRepository = customerRepository;
        this.passwordEncoder = passwordEncoder;
        this.jwtTokenService = jwtTokenService;
        this.redisTokenStore = redisTokenStore;
        this.ipRateLimitService = ipRateLimitService;
    }

    public LoginResponse login(LoginRequest request, String ipAddress) {
        ipRateLimitService.assertNotBlocked(ipAddress);

        User user = userRepository.findByUsernameIgnoreCase(request.username())
                .orElseThrow(() -> invalidCredentials(ipAddress));

        if (!passwordMatches(request.password(), user)) {
            throw invalidCredentials(ipAddress);
        }

        ipRateLimitService.reset(ipAddress);

        CurrentUserPrincipal principal = new CurrentUserPrincipal(user);
        String token = jwtTokenService.generateToken(principal);
        redisTokenStore.save(token, user.getUsername(), jwtTokenService.getExpirationSeconds());

        return new LoginResponse(token, jwtTokenService.getExpirationSeconds(), toCurrentUserResponse(user));
    }

    public CurrentUserResponse getCurrentUser(String username) {
        User user = userRepository.findByUsernameIgnoreCase(username)
                .orElseThrow(() -> new UnauthorizedException("Phiên đăng nhập không hợp lệ."));
        return toCurrentUserResponse(user);
    }

    public void logout(String token) {
        redisTokenStore.revoke(token);
    }

    public CurrentUserResponse toCurrentUserResponse(User user) {
        Optional<Customer> customer = findLinkedCustomer(user);
        return new CurrentUserResponse(
                user.getId(),
                user.getUsername(),
                user.getRole(),
                user.getHoTen(),
                user.getEmail(),
                customer.map(Customer::getSdt).orElse(null)
        );
    }

    public Optional<Customer> findLinkedCustomer(User user) {
        if (user.getEmail() != null && !user.getEmail().isBlank()) {
            Optional<Customer> byEmail = customerRepository.findFirstByEmailIgnoreCase(user.getEmail());
            if (byEmail.isPresent()) {
                return byEmail;
            }
        }

        if (user.getHoTen() != null && !user.getHoTen().isBlank()) {
            return customerRepository.findFirstByTenKhachIgnoreCase(user.getHoTen());
        }

        return Optional.empty();
    }

    private UnauthorizedException invalidCredentials(String ipAddress) {
        ipRateLimitService.recordFailedAttempt(ipAddress);
        return new UnauthorizedException("Sai tên đăng nhập hoặc mật khẩu.");
    }

    private boolean passwordMatches(String rawPassword, User user) {
        String storedPassword = user.getPassword();
        if (storedPassword == null || storedPassword.isBlank()) {
            return false;
        }

        if (storedPassword.startsWith("$2a$")
                || storedPassword.startsWith("$2b$")
                || storedPassword.startsWith("$2y$")) {
            return passwordEncoder.matches(rawPassword, storedPassword);
        }

        boolean matchesLegacyPlainText = storedPassword.equals(rawPassword);
        if (matchesLegacyPlainText) {
            user.setPassword(passwordEncoder.encode(rawPassword));
            userRepository.save(user);
        }
        return matchesLegacyPlainText;
    }
}
