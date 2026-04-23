package com.flarefitness.backend.repository.analytics;

import com.flarefitness.backend.entity.analytics.UserBehaviorEvent;
import java.time.LocalDateTime;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserBehaviorEventRepository extends JpaRepository<UserBehaviorEvent, String> {

    List<UserBehaviorEvent> findTop300ByUserIdOrderByCreatedAtDesc(String userId);

    List<UserBehaviorEvent> findTop300BySessionIdOrderByCreatedAtDesc(String sessionId);

    List<UserBehaviorEvent> findByCreatedAtBetween(LocalDateTime start, LocalDateTime end);

    List<UserBehaviorEvent> findTop1500ByCreatedAtAfterOrderByCreatedAtDesc(LocalDateTime cutoff);
}
