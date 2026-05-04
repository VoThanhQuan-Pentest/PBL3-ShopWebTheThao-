package com.flarefitness.backend.repository.support;

import com.flarefitness.backend.entity.support.SupportMessage;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface SupportMessageRepository extends JpaRepository<SupportMessage, String> {

    List<SupportMessage> findByThreadIdOrderByCreatedAtAsc(String threadId);
}
