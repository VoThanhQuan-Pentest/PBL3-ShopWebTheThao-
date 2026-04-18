package com.flarefitness.backend.service;

import com.flarefitness.backend.dto.auth.CurrentUserResponse;
import com.flarefitness.backend.dto.profile.ChangePasswordRequest;
import com.flarefitness.backend.dto.profile.UpdateProfileRequest;
import com.flarefitness.backend.entity.Customer;
import com.flarefitness.backend.entity.User;
import com.flarefitness.backend.exception.BadRequestException;
import com.flarefitness.backend.exception.ResourceNotFoundException;
import com.flarefitness.backend.repository.CustomerRepository;
import com.flarefitness.backend.repository.UserRepository;
import java.time.LocalDateTime;
import java.util.Optional;
import java.util.UUID;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ProfileService {

    private final UserRepository userRepository;
    private final CustomerRepository customerRepository;
    private final PasswordEncoder passwordEncoder;
    private final AuthService authService;

    public ProfileService(
            UserRepository userRepository,
            CustomerRepository customerRepository,
            PasswordEncoder passwordEncoder,
            AuthService authService
    ) {
        this.userRepository = userRepository;
        this.customerRepository = customerRepository;
        this.passwordEncoder = passwordEncoder;
        this.authService = authService;
    }

    public CurrentUserResponse getProfile(String username) {
        User user = loadUser(username);
        return authService.toCurrentUserResponse(user);
    }

    @Transactional
    public CurrentUserResponse updateProfile(String username, UpdateProfileRequest request) {
        User user = loadUser(username);
        String oldEmail = user.getEmail();
        String oldName = user.getHoTen();

        user.setHoTen(request.hoTen());
        user.setEmail(request.email());
        userRepository.save(user);

        if (isCustomer(user.getRole())) {
            Customer customer = findOrCreateCustomer(user, oldEmail, oldName);
            customer.setTenKhach(request.hoTen());
            customer.setEmail(request.email());
            customer.setSdt(request.sdt());
            customerRepository.save(customer);
        }

        return authService.toCurrentUserResponse(user);
    }

    @Transactional
    public void changePassword(String username, ChangePasswordRequest request) {
        User user = loadUser(username);

        if (!request.newPassword().equals(request.confirmPassword())) {
            throw new BadRequestException("Mật khẩu xác nhận không khớp.");
        }

        if (!passwordEncoder.matches(request.currentPassword(), user.getPassword())) {
            throw new BadRequestException("Mật khẩu hiện tại không đúng.");
        }

        user.setPassword(passwordEncoder.encode(request.newPassword()));
        userRepository.save(user);
    }

    private User loadUser(String username) {
        return userRepository.findByUsernameIgnoreCase(username)
                .orElseThrow(() -> new ResourceNotFoundException("Không tìm thấy người dùng."));
    }

    private Customer findOrCreateCustomer(User user, String oldEmail, String oldName) {
        Optional<Customer> existing = Optional.empty();
        if (oldEmail != null && !oldEmail.isBlank()) {
            existing = customerRepository.findFirstByEmailIgnoreCase(oldEmail);
        }

        if (existing.isEmpty() && oldName != null && !oldName.isBlank()) {
            existing = customerRepository.findFirstByTenKhachIgnoreCase(oldName);
        }

        Customer customer = existing.orElseGet(Customer::new);
        if (customer.getId() == null) {
            customer.setId(UUID.randomUUID().toString());
            customer.setCreatedAt(LocalDateTime.now());
            customer.setKenh("Website");
            customer.setNhan("Mới");
        }
        return customer;
    }

    private boolean isCustomer(String role) {
        return role != null && role.trim().equalsIgnoreCase("khách hàng");
    }
}
