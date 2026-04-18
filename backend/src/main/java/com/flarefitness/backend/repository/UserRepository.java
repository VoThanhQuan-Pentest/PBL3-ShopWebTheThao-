package com.flarefitness.backend.repository;

import com.flarefitness.backend.entity.User;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, String> {

    Optional<User> findByUsernameIgnoreCase(String username);
}
