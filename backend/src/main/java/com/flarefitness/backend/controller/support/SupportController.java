package com.flarefitness.backend.controller.support;

import com.flarefitness.backend.dto.support.SupportMessageRequest;
import com.flarefitness.backend.dto.support.SupportThreadResponse;
import com.flarefitness.backend.dto.support.SupportThreadStatusRequest;
import com.flarefitness.backend.service.support.SupportChatService;
import jakarta.validation.Valid;
import java.util.List;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/support")
public class SupportController {

    private final SupportChatService supportChatService;

    public SupportController(SupportChatService supportChatService) {
        this.supportChatService = supportChatService;
    }

    @GetMapping("/me")
    public ResponseEntity<SupportThreadResponse> getCurrentCustomerThread(
            Authentication authentication,
            @RequestParam(defaultValue = "false") boolean createIfMissing
    ) {
        SupportThreadResponse response = supportChatService.getCurrentCustomerThread(authentication, createIfMissing);
        return response == null ? ResponseEntity.noContent().build() : ResponseEntity.ok(response);
    }

    @PostMapping("/me/messages")
    public ResponseEntity<SupportThreadResponse> appendCustomerMessage(
            Authentication authentication,
            @Valid @RequestBody SupportMessageRequest request
    ) {
        return ResponseEntity.ok(supportChatService.appendCustomerMessage(authentication, request));
    }

    @GetMapping("/threads")
    public ResponseEntity<List<SupportThreadResponse>> getThreads(Authentication authentication) {
        return ResponseEntity.ok(supportChatService.getThreadsForWorkspace(authentication));
    }

    @PostMapping("/threads/{threadId}/messages")
    public ResponseEntity<SupportThreadResponse> appendWorkspaceMessage(
            Authentication authentication,
            @PathVariable String threadId,
            @Valid @RequestBody SupportMessageRequest request
    ) {
        return ResponseEntity.ok(supportChatService.appendWorkspaceMessage(authentication, threadId, request));
    }

    @PutMapping("/threads/{threadId}/status")
    public ResponseEntity<SupportThreadResponse> updateThreadStatus(
            Authentication authentication,
            @PathVariable String threadId,
            @Valid @RequestBody SupportThreadStatusRequest request
    ) {
        return ResponseEntity.ok(supportChatService.updateThreadStatus(authentication, threadId, request));
    }
}
