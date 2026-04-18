package com.flarefitness.backend.repository;

import com.flarefitness.backend.entity.Product;
import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ProductRepository extends JpaRepository<Product, String> {

    List<Product> findAllByOrderByCreatedAtDesc();

    Optional<Product> findBySkuIgnoreCase(String sku);
}
