package com.flarefitness.backend.entity.support;

import com.flarefitness.backend.entity.BaseEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "tbl_tin_nhan_ho_tro")
public class SupportMessage extends BaseEntity {

    @Id
    @Column(name = "id", nullable = false, length = 64)
    private String id;

    @Column(name = "thread_id", nullable = false, length = 64)
    private String threadId;

    @Column(name = "sender_type", nullable = false, length = 20)
    private String senderType;

    @Column(name = "sender_user_id", length = 64)
    private String senderUserId;

    @Column(name = "noi_dung", nullable = false, columnDefinition = "TEXT")
    private String text;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getThreadId() {
        return threadId;
    }

    public void setThreadId(String threadId) {
        this.threadId = threadId;
    }

    public String getSenderType() {
        return senderType;
    }

    public void setSenderType(String senderType) {
        this.senderType = senderType;
    }

    public String getSenderUserId() {
        return senderUserId;
    }

    public void setSenderUserId(String senderUserId) {
        this.senderUserId = senderUserId;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }
}
