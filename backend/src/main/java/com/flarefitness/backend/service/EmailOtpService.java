package com.flarefitness.backend.service;

import com.flarefitness.backend.exception.BadRequestException;
import com.flarefitness.backend.exception.TooManyRequestsException;
import java.security.SecureRandom;
import java.time.Duration;
import java.util.Locale;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.mail.MailException;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class EmailOtpService {

    public static final String PURPOSE_REGISTER = "REGISTER";
    public static final String PURPOSE_FORGOT_PASSWORD = "FORGOT_PASSWORD";

    private static final SecureRandom SECURE_RANDOM = new SecureRandom();

    private final JavaMailSender mailSender;
    private final StringRedisTemplate redisTemplate;
    private final String redisPrefix;
    private final long ttlSeconds;
    private final long cooldownSeconds;
    private final String fromAddress;
    private final String mailPassword;

    public EmailOtpService(
            JavaMailSender mailSender,
            StringRedisTemplate redisTemplate,
            @Value("${app.otp.redis-prefix}") String redisPrefix,
            @Value("${app.otp.ttl-seconds}") long ttlSeconds,
            @Value("${app.otp.cooldown-seconds}") long cooldownSeconds,
            @Value("${app.mail.from}") String fromAddress,
            @Value("${spring.mail.password:}") String mailPassword
    ) {
        this.mailSender = mailSender;
        this.redisTemplate = redisTemplate;
        this.redisPrefix = redisPrefix;
        this.ttlSeconds = ttlSeconds;
        this.cooldownSeconds = cooldownSeconds;
        this.fromAddress = fromAddress;
        this.mailPassword = mailPassword;
    }

    public void sendOtp(String purpose, String email) {
        String normalizedPurpose = normalizePurpose(purpose);
        String normalizedEmail = normalizeEmail(email);
        assertMailConfigured();

        String cooldownKey = cooldownKey(normalizedPurpose, normalizedEmail);
        if (Boolean.TRUE.equals(redisTemplate.hasKey(cooldownKey))) {
            throw new TooManyRequestsException("Vui long doi truoc khi gui lai ma OTP.");
        }

        String otpCode = generateOtpCode();
        redisTemplate.opsForValue().set(otpKey(normalizedPurpose, normalizedEmail), otpCode, Duration.ofSeconds(ttlSeconds));
        redisTemplate.opsForValue().set(cooldownKey, "1", Duration.ofSeconds(cooldownSeconds));

        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom(fromAddress);
        message.setTo(normalizedEmail);
        message.setSubject(buildSubject(normalizedPurpose));
        message.setText(buildBody(normalizedPurpose, otpCode));

        try {
            mailSender.send(message);
        } catch (MailException exception) {
            redisTemplate.delete(otpKey(normalizedPurpose, normalizedEmail));
            redisTemplate.delete(cooldownKey);
            throw new BadRequestException("Khong the gui OTP qua email. Hay kiem tra cau hinh Gmail/App Password.");
        }
    }

    public void verifyOtp(String purpose, String email, String otpCode) {
        String normalizedPurpose = normalizePurpose(purpose);
        String normalizedEmail = normalizeEmail(email);
        String normalizedCode = String.valueOf(otpCode == null ? "" : otpCode).trim();

        if (!normalizedCode.matches("\\d{6}")) {
            throw new BadRequestException("Ma OTP khong hop le.");
        }

        String key = otpKey(normalizedPurpose, normalizedEmail);
        String storedCode = redisTemplate.opsForValue().get(key);
        if (storedCode == null || !storedCode.equals(normalizedCode)) {
            throw new BadRequestException("Ma OTP khong dung hoac da het han.");
        }

        redisTemplate.delete(key);
        redisTemplate.delete(cooldownKey(normalizedPurpose, normalizedEmail));
    }

    private void assertMailConfigured() {
        if (mailPassword == null || mailPassword.isBlank()) {
            throw new BadRequestException("Chua cau hinh APP_MAIL_PASSWORD cho Gmail gui OTP.");
        }
    }

    private String buildSubject(String purpose) {
        if (PURPOSE_REGISTER.equals(purpose)) {
            return "Ma OTP dang ky tai khoan Flare Fitness";
        }
        return "Ma OTP dat lai mat khau Flare Fitness";
    }

    private String buildBody(String purpose, String otpCode) {
        String action = PURPOSE_REGISTER.equals(purpose)
                ? "dang ky tai khoan"
                : "dat lai mat khau";
        return """
                Xin chao,

                Ma OTP de %s tai Flare Fitness la: %s

                Ma co hieu luc trong %d phut. Vui long khong chia se ma nay voi bat ky ai.

                Flare Fitness
                """.formatted(action, otpCode, Math.max(1, ttlSeconds / 60));
    }

    private String generateOtpCode() {
        return String.format("%06d", SECURE_RANDOM.nextInt(1_000_000));
    }

    private String otpKey(String purpose, String email) {
        return redisPrefix + purpose + ":" + email;
    }

    private String cooldownKey(String purpose, String email) {
        return redisPrefix + "cooldown:" + purpose + ":" + email;
    }

    private String normalizePurpose(String purpose) {
        String normalized = String.valueOf(purpose == null ? "" : purpose).trim().toUpperCase(Locale.ROOT);
        if (!PURPOSE_REGISTER.equals(normalized) && !PURPOSE_FORGOT_PASSWORD.equals(normalized)) {
            throw new BadRequestException("Loai OTP khong hop le.");
        }
        return normalized;
    }

    private String normalizeEmail(String email) {
        String normalized = String.valueOf(email == null ? "" : email).trim().toLowerCase(Locale.ROOT);
        if (normalized.isBlank()) {
            throw new BadRequestException("Email la bat buoc.");
        }
        return normalized;
    }
}
