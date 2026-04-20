package com.flarefitness.backend.repository;

import com.flarefitness.backend.entity.Customer;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CustomerRepository extends JpaRepository<Customer, String> {

    Optional<Customer> findFirstByUserId(String userId);

    Optional<Customer> findFirstByEmailIgnoreCase(String email);

    Optional<Customer> findFirstBySdt(String sdt);

    Optional<Customer> findFirstByTenKhachIgnoreCase(String tenKhach);
}
