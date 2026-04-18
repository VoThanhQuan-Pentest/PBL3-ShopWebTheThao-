package com.flarefitness.backend.security;

import java.time.Duration;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;

@Service
public class RedisTokenStore {

    private final StringRedisTemplate redisTemplate;
    private final String tokenPrefix;

    public RedisTokenStore(
            StringRedisTemplate redisTemplate,
            @Value("${app.security.token-prefix}") String tokenPrefix
    ) {
        this.redisTemplate = redisTemplate;
        this.tokenPrefix = tokenPrefix;
    }

    public void save(String token, String username, long ttlSeconds) {
        redisTemplate.opsForValue().set(tokenPrefix + token, username, Duration.ofSeconds(ttlSeconds));
    }

    public boolean contains(String token) {
        return Boolean.TRUE.equals(redisTemplate.hasKey(tokenPrefix + token));
    }

    public void revoke(String token) {
        redisTemplate.delete(tokenPrefix + token);
    }
}
