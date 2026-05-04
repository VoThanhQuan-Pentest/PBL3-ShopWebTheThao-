CREATE TABLE IF NOT EXISTS tbl_ho_tro_khach_hang (
    id VARCHAR(64) PRIMARY KEY,
    customer_user_id VARCHAR(64) NOT NULL,
    trang_thai VARCHAR(50) NOT NULL,
    ngay_tao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ngay_cap_nhat DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_support_thread_customer (customer_user_id),
    INDEX idx_support_thread_updated (ngay_cap_nhat)
);

CREATE TABLE IF NOT EXISTS tbl_tin_nhan_ho_tro (
    id VARCHAR(64) PRIMARY KEY,
    thread_id VARCHAR(64) NOT NULL,
    sender_type VARCHAR(20) NOT NULL,
    sender_user_id VARCHAR(64) NULL,
    noi_dung TEXT NOT NULL,
    ngay_tao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_support_message_thread (thread_id),
    INDEX idx_support_message_created (ngay_tao)
);
