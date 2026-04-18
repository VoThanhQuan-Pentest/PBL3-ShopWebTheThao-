package com.flarefitness.backend.security;

import com.flarefitness.backend.exception.TooManyRequestsException;
import java.time.Duration;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;

@Service
public class IpRateLimitService {

    private final StringRedisTemplate redisTemplate;
    private final String loginAttemptPrefix;
    private final int maxAttemptsPerMinute;

    public IpRateLimitService(
            StringRedisTemplate redisTemplate,
            @Value("${app.security.login-attempt-prefix}") String loginAttemptPrefix,
            @Value("${app.security.login.max-attempts-per-minute}") int maxAttemptsPerMinute
    ) {
        this.redisTemplate = redisTemplate;
        this.loginAttemptPrefix = loginAttemptPrefix;
        this.maxAttemptsPerMinute = maxAttemptsPerMinute;
    }

    public void assertNotBlocked(String ipAddress) {
        String key = key(ipAddress);
        String count = redisTemplate.opsForValue().get(key);
        if (count != null && Integer.parseInt(count) >= maxAttemptsPerMinute) {
            throw new TooManyRequestsException("IP của bạn đang bị chặn tạm thời do đăng nhập sai quá nhiều lần.");
        }
    }

    public void recordFailedAttempt(String ipAddress) {
        String key = key(ipAddress);
        Long count = redisTemplate.opsForValue().increment(key);
        if (count != null && count == 1L) {
            redisTemplate.expire(key, Duration.ofMinutes(1));
        }
    }

    public void reset(String ipAddress) {
        redisTemplate.delete(key(ipAddress));
    }

    private String key(String ipAddress) {
        return loginAttemptPrefix + ipAddress;
    }
}
