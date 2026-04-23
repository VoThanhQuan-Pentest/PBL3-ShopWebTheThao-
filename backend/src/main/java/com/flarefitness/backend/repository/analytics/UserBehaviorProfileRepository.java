package com.flarefitness.backend.repository.analytics;

import com.flarefitness.backend.entity.analytics.UserBehaviorProfile;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserBehaviorProfileRepository extends JpaRepository<UserBehaviorProfile, String> {
}
