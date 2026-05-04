package com.flarefitness.backend.repository.support;

import com.flarefitness.backend.entity.support.SupportThread;
import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;

public interface SupportThreadRepository extends JpaRepository<SupportThread, String> {

    Optional<SupportThread> findFirstByCustomerUserId(String customerUserId);

    List<SupportThread> findAllByOrderByUpdatedAtDesc();
}
