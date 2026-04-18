package com.flarefitness.backend.service;

import com.flarefitness.backend.dto.admin.AdminUserResponse;
import com.flarefitness.backend.entity.Customer;
import com.flarefitness.backend.entity.User;
import com.flarefitness.backend.repository.CustomerRepository;
import com.flarefitness.backend.repository.UserRepository;
import java.util.Comparator;
import java.util.Optional;
import org.springframework.stereotype.Service;

@Service
public class AdminService {

    private final UserRepository userRepository;
    private final CustomerRepository customerRepository;

    public AdminService(UserRepository userRepository, CustomerRepository customerRepository) {
        this.userRepository = userRepository;
        this.customerRepository = customerRepository;
    }

    public java.util.List<AdminUserResponse> getAllUsers() {
        return userRepository.findAll()
                .stream()
                .sorted(Comparator.comparing(User::getHoTen, String.CASE_INSENSITIVE_ORDER))
                .map(this::toResponse)
                .toList();
    }

    private AdminUserResponse toResponse(User user) {
        Optional<Customer> customer = Optional.empty();
        if (user.getEmail() != null && !user.getEmail().isBlank()) {
            customer = customerRepository.findFirstByEmailIgnoreCase(user.getEmail());
        }
        if (customer.isEmpty() && user.getHoTen() != null && !user.getHoTen().isBlank()) {
            customer = customerRepository.findFirstByTenKhachIgnoreCase(user.getHoTen());
        }

        return new AdminUserResponse(
                user.getId(),
                user.getHoTen(),
                user.getUsername(),
                user.getRole(),
                user.getEmail(),
                customer.map(Customer::getSdt).orElse(null)
        );
    }
}
