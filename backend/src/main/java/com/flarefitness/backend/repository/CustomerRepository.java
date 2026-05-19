package com.flarefitness.backend.repository;

import com.flarefitness.backend.entity.Customer;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface CustomerRepository extends JpaRepository<Customer, String> {

    Optional<Customer> findFirstByUserId(String userId);

    Optional<Customer> findFirstByEmailIgnoreCase(String email);

    Optional<Customer> findFirstBySdt(String sdt);

    Optional<Customer> findFirstByTenKhachIgnoreCase(String tenKhach);

    @Query("select c from Customer c where c.userId = :userId and (c.deleted = false or c.deleted is null)")
    Optional<Customer> findActiveFirstByUserId(@Param("userId") String userId);

    @Query("select c from Customer c where lower(c.email) = lower(:email) and (c.deleted = false or c.deleted is null)")
    Optional<Customer> findActiveFirstByEmailIgnoreCase(@Param("email") String email);

    @Query("select c from Customer c where lower(c.tenKhach) = lower(:tenKhach) and (c.deleted = false or c.deleted is null)")
    Optional<Customer> findActiveFirstByTenKhachIgnoreCase(@Param("tenKhach") String tenKhach);
}
