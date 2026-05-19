package com.flarefitness.backend.repository;

import com.flarefitness.backend.entity.Order;
import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface OrderRepository extends JpaRepository<Order, String> {

    @Query("select o from Order o where (o.deleted = false or o.deleted is null) order by o.createdAt desc")
    List<Order> findAllByOrderByCreatedAtDesc();

    @Query("select o from Order o where o.userId = :userId and (o.deleted = false or o.deleted is null) order by o.createdAt desc")
    List<Order> findByUserIdOrderByCreatedAtDesc(@Param("userId") String userId);

    @Query("select o from Order o where o.customerId = :customerId and (o.deleted = false or o.deleted is null) order by o.createdAt desc")
    List<Order> findByCustomerIdOrderByCreatedAtDesc(@Param("customerId") String customerId);

    @Query("select count(o) > 0 from Order o where o.customerId = :customerId and (o.deleted = false or o.deleted is null)")
    boolean existsByCustomerId(@Param("customerId") String customerId);

    @Query("select o from Order o where o.maDon = :maDon and (o.deleted = false or o.deleted is null)")
    Optional<Order> findByMaDon(@Param("maDon") String maDon);

    @Query("""
            select o from Order o
            where o.userId = :userId
               or (:customerId is not null and o.customerId = :customerId)
            """)
    List<Order> findForSoftDelete(@Param("userId") String userId, @Param("customerId") String customerId);
}
