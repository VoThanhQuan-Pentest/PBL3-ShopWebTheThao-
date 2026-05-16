
SET NAMES utf8mb4;

CREATE DATABASE IF NOT EXISTS flare_fitness
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE flare_fitness;


CREATE TABLE IF NOT EXISTS tbl_nguoi_dung (
    id VARCHAR(64) NOT NULL,
    username VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(50) NOT NULL,
    ho_ten VARCHAR(150) NOT NULL,
    email VARCHAR(150) NULL,
    avatar_url VARCHAR(500) NULL,
    trang_thai VARCHAR(30) NOT NULL DEFAULT 'Đang hoạt động',
    lan_dang_nhap_cuoi DATETIME NULL,
    ngay_tao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ngay_cap_nhat DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    is_deleted TINYINT(1) NOT NULL DEFAULT 0,
    PRIMARY KEY (id),
    UNIQUE KEY uk_tbl_nguoi_dung_username (username),
    KEY idx_tbl_nguoi_dung_email (email),
    KEY idx_tbl_nguoi_dung_role (role),
    KEY idx_tbl_nguoi_dung_trang_thai (trang_thai),
    KEY idx_tbl_nguoi_dung_ngay_tao (ngay_tao)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS tbl_khach_hang (
    id VARCHAR(64) NOT NULL,
    user_id VARCHAR(64) NULL,
    ten_khach VARCHAR(150) NOT NULL,
    sdt VARCHAR(30) NOT NULL,
    email VARCHAR(150) NULL,
    kenh VARCHAR(50) NULL,
    nhan VARCHAR(100) NULL,
    dia_chi VARCHAR(500) NULL,
    ghi_chu VARCHAR(500) NULL,
    tong_chi_tieu DECIMAL(15,2) NOT NULL DEFAULT 0,
    hang_khach_hang VARCHAR(50) NOT NULL DEFAULT 'Thường',
    ngay_tao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ngay_cap_nhat DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    is_deleted TINYINT(1) NOT NULL DEFAULT 0,
    PRIMARY KEY (id),
    UNIQUE KEY uk_tbl_khach_hang_user_id (user_id),
    KEY idx_tbl_khach_hang_email (email),
    KEY idx_tbl_khach_hang_sdt (sdt),
    KEY idx_tbl_khach_hang_ten_khach (ten_khach),
    KEY idx_tbl_khach_hang_ngay_tao (ngay_tao),
    CONSTRAINT fk_tbl_khach_hang_user
        FOREIGN KEY (user_id) REFERENCES tbl_nguoi_dung (id)
        ON UPDATE CASCADE
        ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS tbl_san_pham (
    id VARCHAR(64) NOT NULL,
    ten_san_pham VARCHAR(255) NOT NULL,
    sku VARCHAR(64) NOT NULL,
    danh_muc VARCHAR(100) NOT NULL,
    thuong_hieu VARCHAR(100) NULL,
    size VARCHAR(50) NULL,
    mau VARCHAR(50) NULL,
    gia_nhap DECIMAL(15,2) NOT NULL,
    gia_ban DECIMAL(15,2) NOT NULL,
    ton_kho INT NOT NULL DEFAULT 0,
    trang_thai VARCHAR(50) NOT NULL,
    link_san_pham VARCHAR(500) NULL,
    hinh_anh_url VARCHAR(500) NULL,
    mo_ta_ngan TEXT NULL,
    ghi_chu VARCHAR(500) NULL,
    ngay_tao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ngay_cap_nhat DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    is_deleted TINYINT(1) NOT NULL DEFAULT 0,
    PRIMARY KEY (id),
    UNIQUE KEY uk_tbl_san_pham_sku (sku),
    KEY idx_tbl_san_pham_danh_muc (danh_muc),
    KEY idx_tbl_san_pham_trang_thai (trang_thai),
    KEY idx_tbl_san_pham_thuong_hieu (thuong_hieu),
    KEY idx_tbl_san_pham_ngay_tao (ngay_tao)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS tbl_bien_the_san_pham (
    id VARCHAR(64) NOT NULL,
    product_id VARCHAR(64) NOT NULL,
    sku_bien_the VARCHAR(64) NOT NULL,
    size VARCHAR(50) NOT NULL,
    mau VARCHAR(50) NOT NULL,
    ton_kho_hien_tai INT NOT NULL DEFAULT 0,
    gia_nhap DECIMAL(15,2) NOT NULL,
    gia_ban DECIMAL(15,2) NOT NULL,
    hinh_anh_url VARCHAR(500) NULL,
    trang_thai VARCHAR(50) NOT NULL DEFAULT 'Đang bán',
    ghi_chu VARCHAR(500) NULL,
    ngay_tao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ngay_cap_nhat DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    is_deleted TINYINT(1) NOT NULL DEFAULT 0,
    PRIMARY KEY (id),
    UNIQUE KEY uk_tbl_bien_the_san_pham_sku_bien_the (sku_bien_the),
    UNIQUE KEY uk_tbl_bien_the_san_pham_product_size_mau (product_id, size, mau),
    KEY idx_tbl_bien_the_san_pham_product_id (product_id),
    KEY idx_tbl_bien_the_san_pham_trang_thai (trang_thai),
    CONSTRAINT fk_tbl_bien_the_san_pham_product
        FOREIGN KEY (product_id) REFERENCES tbl_san_pham (id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS tbl_gio_hang (
    id VARCHAR(64) NOT NULL,
    user_id VARCHAR(64) NULL,
    customer_id VARCHAR(64) NULL,
    trang_thai VARCHAR(30) NOT NULL DEFAULT 'ACTIVE',
    tong_san_pham INT NOT NULL DEFAULT 0,
    tong_tien_tam_tinh DECIMAL(15,2) NOT NULL DEFAULT 0,
    ngay_tao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ngay_cap_nhat DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uk_tbl_gio_hang_user_id (user_id),
    UNIQUE KEY uk_tbl_gio_hang_customer_id (customer_id),
    KEY idx_tbl_gio_hang_trang_thai (trang_thai),
    CONSTRAINT fk_tbl_gio_hang_user
        FOREIGN KEY (user_id) REFERENCES tbl_nguoi_dung (id)
        ON UPDATE CASCADE
        ON DELETE SET NULL,
    CONSTRAINT fk_tbl_gio_hang_customer
        FOREIGN KEY (customer_id) REFERENCES tbl_khach_hang (id)
        ON UPDATE CASCADE
        ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS tbl_chi_tiet_gio_hang (
    id VARCHAR(64) NOT NULL,
    cart_id VARCHAR(64) NOT NULL,
    product_id VARCHAR(64) NOT NULL,
    variant_id VARCHAR(64) NOT NULL,
    so_luong INT NOT NULL DEFAULT 1,
    don_gia DECIMAL(15,2) NOT NULL,
    thanh_tien DECIMAL(15,2) NOT NULL,
    ngay_tao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ngay_cap_nhat DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uk_tbl_chi_tiet_gio_hang_cart_variant (cart_id, variant_id),
    KEY idx_tbl_chi_tiet_gio_hang_product_id (product_id),
    CONSTRAINT fk_tbl_chi_tiet_gio_hang_cart
        FOREIGN KEY (cart_id) REFERENCES tbl_gio_hang (id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_tbl_chi_tiet_gio_hang_product
        FOREIGN KEY (product_id) REFERENCES tbl_san_pham (id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT fk_tbl_chi_tiet_gio_hang_variant
        FOREIGN KEY (variant_id) REFERENCES tbl_bien_the_san_pham (id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS tbl_don_hang (
    id VARCHAR(64) NOT NULL,
    ma_don VARCHAR(64) NOT NULL,
    ngay_dat DATE NOT NULL,
    customer_id VARCHAR(64) NOT NULL,
    user_id VARCHAR(64) NULL,
    nguoi_nhan VARCHAR(150) NULL,
    so_dien_thoai_giao VARCHAR(30) NULL,
    trang_thai_don VARCHAR(50) NOT NULL,
    thanh_toan VARCHAR(50) NOT NULL,
    da_thanh_toan TINYINT(1) NOT NULL DEFAULT 0,
    tong_tien DECIMAL(15,2) NOT NULL,
    phi_ship DECIMAL(15,2) NULL DEFAULT 0,
    giam_gia DECIMAL(15,2) NULL DEFAULT 0,
    dia_chi_giao VARCHAR(500) NOT NULL,
    ghi_chu VARCHAR(500) NULL,
    ngay_tao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ngay_cap_nhat DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    is_deleted TINYINT(1) NOT NULL DEFAULT 0,
    PRIMARY KEY (id),
    UNIQUE KEY uk_tbl_don_hang_ma_don (ma_don),
    KEY idx_tbl_don_hang_customer_id (customer_id),
    KEY idx_tbl_don_hang_user_id (user_id),
    KEY idx_tbl_don_hang_trang_thai_don (trang_thai_don),
    KEY idx_tbl_don_hang_ngay_dat (ngay_dat),
    CONSTRAINT fk_tbl_don_hang_customer
        FOREIGN KEY (customer_id) REFERENCES tbl_khach_hang (id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT fk_tbl_don_hang_user
        FOREIGN KEY (user_id) REFERENCES tbl_nguoi_dung (id)
        ON UPDATE CASCADE
        ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS tbl_chi_tiet_don_hang (
    id VARCHAR(64) NOT NULL,
    order_id VARCHAR(64) NOT NULL,
    product_id VARCHAR(64) NOT NULL,
    variant_id VARCHAR(64) NULL,
    ten_san_pham_snapshot VARCHAR(255) NOT NULL,
    sku_snapshot VARCHAR(64) NOT NULL,
    size_snapshot VARCHAR(50) NULL,
    mau_snapshot VARCHAR(50) NULL,
    so_luong INT NOT NULL,
    don_gia DECIMAL(15,2) NOT NULL,
    thanh_tien DECIMAL(15,2) NOT NULL,
    ngay_tao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uk_tbl_chi_tiet_don_hang_order_variant (order_id, sku_snapshot),
    KEY idx_tbl_chi_tiet_don_hang_product_id (product_id),
    KEY idx_tbl_chi_tiet_don_hang_variant_id (variant_id),
    CONSTRAINT fk_tbl_chi_tiet_don_hang_order
        FOREIGN KEY (order_id) REFERENCES tbl_don_hang (id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_tbl_chi_tiet_don_hang_product
        FOREIGN KEY (product_id) REFERENCES tbl_san_pham (id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT fk_tbl_chi_tiet_don_hang_variant
        FOREIGN KEY (variant_id) REFERENCES tbl_bien_the_san_pham (id)
        ON UPDATE CASCADE
        ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS tbl_danh_gia_san_pham (
    id VARCHAR(64) NOT NULL,
    product_id VARCHAR(64) NOT NULL,
    user_id VARCHAR(64) NOT NULL,
    reviewer_name VARCHAR(150) NOT NULL,
    rating INT NOT NULL,
    content VARCHAR(1000) NOT NULL,
    status VARCHAR(30) NOT NULL DEFAULT 'Hiển thị',
    ngay_tao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    KEY idx_tbl_danh_gia_product (product_id),
    KEY idx_tbl_danh_gia_user (user_id),
    KEY idx_tbl_danh_gia_status (status),
    KEY idx_tbl_danh_gia_ngay_tao (ngay_tao),
    CONSTRAINT fk_tbl_danh_gia_product
        FOREIGN KEY (product_id) REFERENCES tbl_san_pham (id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_tbl_danh_gia_user
        FOREIGN KEY (user_id) REFERENCES tbl_nguoi_dung (id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS tbl_thanh_toan (
    id VARCHAR(64) NOT NULL,
    order_id VARCHAR(64) NOT NULL,
    ma_giao_dich_truy_xuat VARCHAR(100) NOT NULL,
    phuong_thuc VARCHAR(50) NOT NULL,
    so_tien DECIMAL(15,2) NOT NULL,
    trang_thai VARCHAR(50) NOT NULL,
    nha_cung_cap VARCHAR(100) NULL,
    raw_response_json JSON NULL,
    thanh_toan_luc DATETIME NULL,
    ghi_chu VARCHAR(500) NULL,
    ngay_tao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ngay_cap_nhat DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uk_tbl_thanh_toan_ma_giao_dich_truy_xuat (ma_giao_dich_truy_xuat),
    KEY idx_tbl_thanh_toan_order_id (order_id),
    KEY idx_tbl_thanh_toan_trang_thai (trang_thai),
    CONSTRAINT fk_tbl_thanh_toan_order
        FOREIGN KEY (order_id) REFERENCES tbl_don_hang (id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS tbl_san_khuyen_mai (
    id VARCHAR(64) NOT NULL,
    voucher_code VARCHAR(64) NOT NULL,
    tong_so_luong INT NOT NULL,
    bat_dau DATETIME NOT NULL,
    ket_thuc DATETIME NOT NULL,
    trang_thai VARCHAR(50) NOT NULL DEFAULT 'ACTIVE',
    ngay_tao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ngay_cap_nhat DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    KEY idx_promo_hunt_voucher (voucher_code),
    KEY idx_promo_hunt_time (bat_dau, ket_thuc),
    KEY idx_promo_hunt_status (trang_thai)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS tbl_luot_nhan_khuyen_mai (
    id VARCHAR(64) NOT NULL,
    campaign_id VARCHAR(64) NOT NULL,
    user_id VARCHAR(64) NOT NULL,
    ngay_tao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uk_promo_hunt_claim_user (campaign_id, user_id),
    KEY idx_promo_hunt_claim_campaign (campaign_id),
    KEY idx_promo_hunt_claim_user (user_id),
    CONSTRAINT fk_promo_hunt_claim_campaign
        FOREIGN KEY (campaign_id) REFERENCES tbl_san_khuyen_mai (id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_promo_hunt_claim_user
        FOREIGN KEY (user_id) REFERENCES tbl_nguoi_dung (id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE OR REPLACE VIEW view_bang_san_pham AS
SELECT
    sp.id,
    sp.ten_san_pham,
    sp.sku,
    sp.danh_muc,
    sp.thuong_hieu,
    sp.size,
    sp.mau,
    sp.gia_nhap,
    sp.gia_ban,
    sp.ton_kho,
    sp.trang_thai,
    sp.link_san_pham,
    sp.ghi_chu,
    sp.ngay_tao,
    COUNT(btsp.id) AS so_bien_the
FROM tbl_san_pham sp
LEFT JOIN tbl_bien_the_san_pham btsp ON btsp.product_id = sp.id AND btsp.is_deleted = 0
WHERE sp.is_deleted = 0
GROUP BY
    sp.id, sp.ten_san_pham, sp.sku, sp.danh_muc, sp.thuong_hieu, sp.size, sp.mau,
    sp.gia_nhap, sp.gia_ban, sp.ton_kho, sp.trang_thai, sp.link_san_pham, sp.ghi_chu, sp.ngay_tao;

CREATE OR REPLACE VIEW view_bang_khach_hang AS
SELECT
    kh.id,
    kh.ten_khach,
    kh.sdt,
    kh.email,
    kh.kenh,
    kh.nhan,
    kh.dia_chi,
    kh.ghi_chu,
    kh.tong_chi_tieu,
    kh.hang_khach_hang,
    kh.ngay_tao
FROM tbl_khach_hang kh
WHERE kh.is_deleted = 0;

CREATE OR REPLACE VIEW view_bang_don_hang AS
SELECT
    dh.id,
    dh.ma_don,
    dh.ngay_dat,
    kh.ten_khach,
    dh.trang_thai_don,
    dh.thanh_toan,
    dh.da_thanh_toan,
    dh.tong_tien,
    dh.phi_ship,
    dh.giam_gia,
    dh.dia_chi_giao,
    dh.ghi_chu,
    dh.ngay_tao
FROM tbl_don_hang dh
JOIN tbl_khach_hang kh ON kh.id = dh.customer_id
WHERE dh.is_deleted = 0;

CREATE OR REPLACE VIEW view_ton_kho_theo_bien_the AS
SELECT
    sp.id AS product_id,
    sp.ten_san_pham,
    btsp.id AS variant_id,
    btsp.sku_bien_the,
    btsp.size,
    btsp.mau,
    btsp.ton_kho_hien_tai,
    btsp.gia_ban,
    btsp.trang_thai
FROM tbl_bien_the_san_pham btsp
JOIN tbl_san_pham sp ON sp.id = btsp.product_id
WHERE btsp.is_deleted = 0 AND sp.is_deleted = 0;

INSERT INTO tbl_nguoi_dung (
    id, username, password, role, ho_ten, email, avatar_url, trang_thai,
    lan_dang_nhap_cuoi, ngay_tao, ngay_cap_nhat, is_deleted
)
VALUES
    ('user-admin-001', 'admin', '$2a$10$yCPiRjbKafwJ0Lh5802sMuLDiCn.PJtA3WW4gCAeXowC6xV7jjrlu', 'Quản trị viên', 'Hệ Thống', 'admin@flarefitness.com', NULL, 'Đang hoạt động', NULL, '2026-04-18 08:00:00', '2026-04-18 08:00:00', 0),
    ('user-staff-001', 'nhanvien01', '$2a$10$tsHqWuYvzLI2jA6GonaWu.ysxEC4nNh9wVIMubsdkrxYdrP1mRdNO', 'Nhân viên', 'Nguyễn Nhân Viên', 'nv01@flarefitness.com', NULL, 'Đang hoạt động', NULL, '2026-04-18 08:05:00', '2026-04-18 08:05:00', 0),
    ('user-customer-001', 'khachhang01', '$2a$10$9bK6KlpWaCPwmk6kEsz0TOjPNrsoVjeg/EtzKB2l1fY40q/goVpyO', 'Khách hàng', 'Nguyễn Văn A', 'nguyenvana@email.com', NULL, 'Đang hoạt động', NULL, '2026-04-18 08:10:00', '2026-04-18 08:10:00', 0),
    ('user-customer-002', 'khachhang02', '$2a$10$CgNqJ8vr1LLcpUVVi6cAaOeXHoR4j29dW.arn/1tk6w8bJQhjhKe.', 'Khách hàng', 'Trần Thị B', 'tranthib@email.com', NULL, 'Đang hoạt động', NULL, '2026-04-18 08:12:00', '2026-04-18 08:12:00', 0)
ON DUPLICATE KEY UPDATE
    password = VALUES(password),
    role = VALUES(role),
    ho_ten = VALUES(ho_ten),
    email = VALUES(email),
    trang_thai = VALUES(trang_thai),
    is_deleted = VALUES(is_deleted);

INSERT INTO tbl_san_khuyen_mai (
    id, voucher_code, tong_so_luong, bat_dau, ket_thuc, trang_thai, ngay_tao, ngay_cap_nhat
)
VALUES
    ('hunt-hotdeal10', 'HOTDEAL10', 30, DATE_SUB(NOW(), INTERVAL 1 DAY), DATE_ADD(NOW(), INTERVAL 45 DAY), 'ACTIVE', NOW(), NOW()),
    ('hunt-seagames15', 'SEAGAMES15', 20, DATE_SUB(NOW(), INTERVAL 1 DAY), DATE_ADD(NOW(), INTERVAL 45 DAY), 'ACTIVE', NOW(), NOW()),
    ('hunt-rungym18', 'RUNGYM18', 15, DATE_SUB(NOW(), INTERVAL 1 DAY), DATE_ADD(NOW(), INTERVAL 45 DAY), 'ACTIVE', NOW(), NOW())
ON DUPLICATE KEY UPDATE
    voucher_code = VALUES(voucher_code),
    tong_so_luong = VALUES(tong_so_luong),
    trang_thai = VALUES(trang_thai);

INSERT INTO tbl_khach_hang (
    id, user_id, ten_khach, sdt, email, kenh, nhan, dia_chi, ghi_chu,
    tong_chi_tieu, hang_khach_hang, ngay_tao, ngay_cap_nhat, is_deleted
)
VALUES
    ('customer-001', 'user-customer-001', 'Nguyễn Văn A', '0901234567', 'nguyenvana@email.com', 'Website', 'VIP', '123 Đường Lê Lợi, Quận 1, TP.HCM', 'Khách hàng thân thiết', 1590000, 'Vàng', '2026-04-18 08:15:00', '2026-04-18 08:15:00', 0),
    ('customer-002', 'user-customer-002', 'Trần Thị B', '0987654321', 'tranthib@email.com', 'Facebook', 'Mới', '456 Đường Nguyễn Huệ, Quận 2, TP.HCM', '', 570000, 'Bạc', '2026-04-18 08:20:00', '2026-04-18 08:20:00', 0),
    ('customer-003', NULL, 'Lê Văn C', '0911222333', 'levanc@email.com', 'Shopee', 'Quay lại', '789 Đường Trần Phú, Quận 3, TP.HCM', 'Khách mua không tạo tài khoản', 0, 'Thường', '2026-04-18 08:25:00', '2026-04-18 08:25:00', 0)
ON DUPLICATE KEY UPDATE
    user_id = VALUES(user_id),
    ten_khach = VALUES(ten_khach),
    sdt = VALUES(sdt),
    email = VALUES(email),
    kenh = VALUES(kenh),
    nhan = VALUES(nhan),
    dia_chi = VALUES(dia_chi),
    ghi_chu = VALUES(ghi_chu),
    tong_chi_tieu = VALUES(tong_chi_tieu),
    hang_khach_hang = VALUES(hang_khach_hang),
    is_deleted = VALUES(is_deleted);

INSERT INTO tbl_san_pham (
    id, ten_san_pham, sku, danh_muc, thuong_hieu, size, mau, gia_nhap, gia_ban,
    ton_kho, trang_thai, link_san_pham, hinh_anh_url, mo_ta_ngan, ghi_chu,
    ngay_tao, ngay_cap_nhat, is_deleted
)
VALUES
    ('product-001', 'Giày bóng đá cỏ nhân tạo Nike', 'FB-001', 'Bóng đá', 'Nike', '42-43', 'Xanh / Trắng xanh', 850000, 1250000, 10, 'Đang bán', '', NULL, 'Dòng chuyên dụng cho sân cỏ nhân tạo.', 'Mẫu chủ lực cho danh mục bóng đá', '2026-04-18 08:30:00', '2026-04-18 08:30:00', 0),
    ('product-002', 'Áo đấu CLB Manchester City 2024', 'FB-003', 'Bóng đá', 'Puma', 'M-L', 'Xanh dương', 300000, 550000, 25, 'Đang bán', '', NULL, 'Chất liệu thoáng khí, mặc thi đấu và tập luyện.', '', '2026-04-18 08:31:00', '2026-04-18 08:31:00', 0),
    ('product-003', 'Bóng rổ Spalding NBA', 'BB-002', 'Bóng rổ', 'Spalding', 'Số 7', 'Cam', 400000, 650000, 15, 'Đang bán', '', NULL, 'Bóng tiêu chuẩn dùng cho tập luyện và thi đấu phong trào.', '', '2026-04-18 08:32:00', '2026-04-18 08:32:00', 0),
    ('product-004', 'Vợt cầu lông Yonex Astrox', 'BM-001', 'Cầu lông', 'Yonex', '4U-G5', 'Đen xanh', 1200000, 1850000, 8, 'Đang bán', '', NULL, 'Vợt công thủ toàn diện, phù hợp người chơi trung cấp.', 'Siêu nhẹ, thoát cầu nhanh', '2026-04-18 08:33:00', '2026-04-18 08:33:00', 0),
    ('product-005', 'Bóng chuyền hơi Động Lực', 'VB-001', 'Bóng chuyền', 'Động Lực', 'Tiêu chuẩn / Mềm', 'Vàng xanh', 80000, 120000, 30, 'Đang bán', '', NULL, 'Dòng bóng chuyền hơi phổ biến cho sân trường và CLB.', '', '2026-04-18 08:34:00', '2026-04-18 08:34:00', 0),
    ('product-006', 'Vợt bóng bàn 7 lớp gỗ', 'TT-001', 'Bóng bàn', '729-Focus', 'Tiêu chuẩn', 'Đỏ đen', 250000, 450000, 10, 'Đang bán', '', NULL, 'Phù hợp người mới tập chơi, cảm giác bóng ổn định.', 'Dành cho người mới tập chơi', '2026-04-18 08:35:00', '2026-04-18 08:35:00', 0)
ON DUPLICATE KEY UPDATE
    ten_san_pham = VALUES(ten_san_pham),
    danh_muc = VALUES(danh_muc),
    thuong_hieu = VALUES(thuong_hieu),
    size = VALUES(size),
    mau = VALUES(mau),
    gia_nhap = VALUES(gia_nhap),
    gia_ban = VALUES(gia_ban),
    ton_kho = VALUES(ton_kho),
    trang_thai = VALUES(trang_thai),
    mo_ta_ngan = VALUES(mo_ta_ngan),
    ghi_chu = VALUES(ghi_chu),
    is_deleted = VALUES(is_deleted);

INSERT INTO tbl_san_pham (
    id, ten_san_pham, sku, danh_muc, thuong_hieu, size, mau, gia_nhap, gia_ban,
    ton_kho, trang_thai, link_san_pham, hinh_anh_url, mo_ta_ngan, ghi_chu,
    ngay_tao, ngay_cap_nhat, is_deleted
)
VALUES
    ('product-007', 'Giày bóng đá Nike Tiempo Legend 10 Academy TF', 'FB-007', 'Bóng đá', 'Nike', '41-43', 'Đen / Xanh ngọc', 1150000, 1690000, 16, 'Đang bán', '', NULL, 'Mẫu giày sân cỏ nhân tạo thuộc dòng Tiempo Legend 10 Academy.', 'Seed theo dòng sản phẩm Nike chính hãng.', '2026-04-19 08:00:00', '2026-04-19 08:00:00', 0),
    ('product-008', 'Giày bóng đá Nike Mercurial Vapor 16 Academy TF', 'FB-008', 'Bóng đá', 'Nike', '40-43', 'Trắng / Hồng', 1250000, 1820000, 14, 'Đang bán', '', NULL, 'Dòng Mercurial Vapor 16 Academy cho người chơi tốc độ.', 'Phù hợp khách hàng đá phủi sân cỏ nhân tạo.', '2026-04-19 08:01:00', '2026-04-19 08:01:00', 0),
    ('product-009', 'Giày bóng đá Nike Phantom GX 2 Academy TF', 'FB-009', 'Bóng đá', 'Nike', '40-43', 'Xanh lam / Trắng', 1280000, 1890000, 12, 'Đang bán', '', NULL, 'Phantom GX 2 Academy bản turf cho kiểm soát bóng.', 'Mặt upper bám bóng tốt.', '2026-04-19 08:02:00', '2026-04-19 08:02:00', 0),
    ('product-010', 'Giày bóng đá adidas Predator League Turf', 'FB-010', 'Bóng đá', 'adidas', '40-43', 'Đỏ / Đen', 1350000, 1980000, 13, 'Đang bán', '', NULL, 'Predator League Turf dành cho sân cỏ nhân tạo.', 'Dòng giày kiểm soát bóng của adidas.', '2026-04-19 08:03:00', '2026-04-19 08:03:00', 0),
    ('product-011', 'Giày bóng đá adidas F50 League Turf', 'FB-011', 'Bóng đá', 'adidas', '40-43', 'Trắng / Xanh', 1320000, 1940000, 11, 'Đang bán', '', NULL, 'F50 League Turf thiên về tốc độ và tăng tốc.', 'Seed theo mẫu F50 League hiện hành.', '2026-04-19 08:04:00', '2026-04-19 08:04:00', 0),
    ('product-012', 'Giày bóng đá adidas Copa Pure 3 League Turf', 'FB-012', 'Bóng đá', 'adidas', '40-43', 'Trắng / Đen', 1360000, 1990000, 10, 'Đang bán', '', NULL, 'Copa Pure 3 League Turf cho cảm giác bóng êm chân.', 'Phân khúc trung cấp dễ bán.', '2026-04-19 08:05:00', '2026-04-19 08:05:00', 0),
    ('product-013', 'Giày bóng đá Puma Future 7 Play TT', 'FB-013', 'Bóng đá', 'Puma', '40-43', 'Xanh navy / Bạc', 990000, 1490000, 15, 'Đang bán', '', NULL, 'Future 7 Play TT là mẫu giày turf phổ biến của Puma.', 'Dễ phối với áo đấu CLB.', '2026-04-19 08:06:00', '2026-04-19 08:06:00', 0),
    ('product-014', 'Giày bóng đá Puma Ultra 5 Play TT', 'FB-014', 'Bóng đá', 'Puma', '40-43', 'Vàng / Đen', 980000, 1450000, 17, 'Đang bán', '', NULL, 'Ultra 5 Play TT thiên về tốc độ và trọng lượng nhẹ.', 'Phù hợp người chơi phong trào.', '2026-04-19 08:07:00', '2026-04-19 08:07:00', 0),
    ('product-015', 'Giày bóng đá Mizuno Monarcida Neo III Select AS', 'FB-015', 'Bóng đá', 'Mizuno', '40-43', 'Trắng / Đỏ', 1450000, 2190000, 9, 'Đang bán', '', NULL, 'Monarcida Neo III Select AS là mẫu AS phổ biến của Mizuno.', 'Form giày ôm vừa chân châu Á.', '2026-04-19 08:08:00', '2026-04-19 08:08:00', 0),
    ('product-016', 'Bóng đá Select Numero 10', 'FB-016', 'Bóng đá', 'Select', 'Số 5', 'Trắng / Xanh', 690000, 990000, 18, 'Đang bán', '', NULL, 'Bóng thi đấu và tập luyện nổi tiếng của Select.', 'Mẫu bóng rất phổ biến trên thị trường.', '2026-04-19 08:09:00', '2026-04-19 08:09:00', 0),
    ('product-017', 'Áo tập bóng đá Nike Dri-FIT Academy 23', 'FB-017', 'Bóng đá', 'Nike', 'M-L', 'Đen', 280000, 450000, 20, 'Đang bán', '', NULL, 'Áo tập dòng Academy 23 dùng vải Dri-FIT.', 'Có thể bán kèm quần training.', '2026-04-19 08:10:00', '2026-04-19 08:10:00', 0),
    ('product-018', 'Áo tập bóng đá adidas Tiro 24 Training Jersey', 'FB-018', 'Bóng đá', 'adidas', 'M-L', 'Xanh navy', 290000, 470000, 18, 'Đang bán', '', NULL, 'Áo training thuộc bộ sưu tập Tiro 24.', 'Mẫu áo tập dễ lên combo đội nhóm.', '2026-04-19 08:11:00', '2026-04-19 08:11:00', 0),
    ('product-019', 'Áo bóng đá Puma teamLIGA Jersey', 'FB-019', 'Bóng đá', 'Puma', 'M-L', 'Trắng / Đen', 250000, 390000, 22, 'Đang bán', '', NULL, 'Áo jersey teamLIGA dùng công nghệ dryCELL.', 'Dễ bán cho đội bóng phong trào.', '2026-04-19 08:12:00', '2026-04-19 08:12:00', 0),
    ('product-020', 'Áo khoác bóng đá Nike Dri-FIT Academy 23 Drill Top', 'FB-020', 'Bóng đá', 'Nike', 'M-L', 'Xám / Đen', 480000, 790000, 12, 'Đang bán', '', NULL, 'Drill top Academy 23 dùng cho khởi động và tập luyện.', 'Có khóa kéo 1/4 tiện dụng.', '2026-04-19 08:13:00', '2026-04-19 08:13:00', 0),
    ('product-021', 'Quần tập bóng đá adidas Tiro 24 Training Pants', 'FB-021', 'Bóng đá', 'adidas', 'M-L', 'Đen', 420000, 690000, 14, 'Đang bán', '', NULL, 'Quần training thuộc dòng Tiro 24 với ống khóa kéo.', 'Bán tốt theo set áo quần training.', '2026-04-19 08:14:00', '2026-04-19 08:14:00', 0),
    ('product-022', 'Quần tập bóng đá Puma teamLIGA Training Pants', 'FB-022', 'Bóng đá', 'Puma', 'M-L', 'Đen', 350000, 590000, 16, 'Đang bán', '', NULL, 'Quần training teamLIGA cho nhu cầu tập luyện hằng ngày.', 'Seed theo line teamLIGA của Puma.', '2026-04-19 08:15:00', '2026-04-19 08:15:00', 0),
    ('product-023', 'Balo bóng đá Nike Academy Team Backpack', 'FB-023', 'Bóng đá', 'Nike', '22L', 'Đen / Trắng', 420000, 690000, 13, 'Đang bán', '', NULL, 'Balo thể thao thuộc dòng Academy Team Backpack.', 'Phù hợp học sinh sinh viên đá bóng.', '2026-04-19 08:16:00', '2026-04-19 08:16:00', 0),
    ('product-024', 'Túi trống bóng đá adidas Tiro League Duffel Bag Medium', 'FB-024', 'Bóng đá', 'adidas', 'M', 'Đen', 520000, 850000, 9, 'Đang bán', '', NULL, 'Duffel bag thuộc dòng Tiro League kích thước trung bình.', 'Dễ bán cho đội bóng và người tập gym.', '2026-04-19 08:17:00', '2026-04-19 08:17:00', 0),
    ('product-025', 'Ống đồng bóng đá Nike Guard Lock Elite', 'FB-025', 'Bóng đá', 'Nike', 'M', 'Trắng / Đen', 390000, 620000, 19, 'Đang bán', '', NULL, 'Ống đồng Guard Lock Elite cho người chơi bóng đá.', 'Phụ kiện bán kèm giày khá ổn.', '2026-04-19 08:18:00', '2026-04-19 08:18:00', 0),
    ('product-026', 'Găng tay thủ môn adidas Predator Training', 'FB-026', 'Bóng đá', 'adidas', 'Size 9', 'Đen / Đỏ', 510000, 820000, 8, 'Đang bán', '', NULL, 'Găng tay thủ môn Predator Training dùng cho tập luyện.', 'Bổ sung nhóm phụ kiện thủ môn.', '2026-04-19 08:19:00', '2026-04-19 08:19:00', 0),

    ('product-027', 'Vợt bóng bàn Butterfly Timo Boll CF 1000', 'TT-007', 'Bóng bàn', 'Butterfly', 'Tiêu chuẩn', 'Đỏ / Đen', 550000, 890000, 12, 'Đang bán', '', NULL, 'Vợt lắp sẵn thuộc dòng Timo Boll CF 1000 của Butterfly.', 'Mẫu racket phổ biến cho người mới nâng cao.', '2026-04-19 08:20:00', '2026-04-19 08:20:00', 0),
    ('product-028', 'Vợt bóng bàn Butterfly Timo Boll CF 2000', 'TT-008', 'Bóng bàn', 'Butterfly', 'Tiêu chuẩn', 'Đỏ / Đen', 720000, 1150000, 10, 'Đang bán', '', NULL, 'Timo Boll CF 2000 là mẫu racket recreational cao hơn CF 1000.', 'Thuộc line real trên Butterfly.', '2026-04-19 08:21:00', '2026-04-19 08:21:00', 0),
    ('product-029', 'Vợt bóng bàn Butterfly Addoy 2000', 'TT-009', 'Bóng bàn', 'Butterfly', 'Tiêu chuẩn', 'Đỏ / Đen', 430000, 690000, 11, 'Đang bán', '', NULL, 'Addoy 2000 là vợt bóng bàn lắp sẵn phù hợp người mới chơi.', 'Mẫu recreational dễ bán.', '2026-04-19 08:22:00', '2026-04-19 08:22:00', 0),
    ('product-030', 'Vợt bóng bàn Butterfly Wakaba 3000', 'TT-010', 'Bóng bàn', 'Butterfly', 'Tiêu chuẩn', 'Đỏ / Đen', 680000, 1090000, 9, 'Đang bán', '', NULL, 'Wakaba 3000 là vợt lắp sẵn hướng tới người chơi trung cấp.', 'Mẫu thực tế trên catalog Butterfly.', '2026-04-19 08:23:00', '2026-04-19 08:23:00', 0),
    ('product-031', 'Vợt bóng bàn DHS 4002', 'TT-011', 'Bóng bàn', 'DHS', 'Tiêu chuẩn', 'Đỏ / Đen', 320000, 520000, 15, 'Đang bán', '', NULL, 'DHS 4002 là mẫu vợt dựng sẵn rất phổ biến trên sàn TMĐT.', 'Phù hợp tệp khách beginner.', '2026-04-19 08:24:00', '2026-04-19 08:24:00', 0),
    ('product-032', 'Vợt bóng bàn DHS 3002', 'TT-012', 'Bóng bàn', 'DHS', 'Tiêu chuẩn', 'Đỏ / Đen', 250000, 420000, 17, 'Đang bán', '', NULL, 'DHS 3002 là lựa chọn entry-level của DHS.', 'Thường bán theo set kèm bóng.', '2026-04-19 08:25:00', '2026-04-19 08:25:00', 0),
    ('product-033', 'Vợt bóng bàn 729 Focus 1', 'TT-013', 'Bóng bàn', '729', 'Tiêu chuẩn', 'Đỏ / Đen', 260000, 450000, 14, 'Đang bán', '', NULL, 'Dòng 729 Focus 1 được bán rộng rãi cho người mới tập.', 'Giá mềm dễ quay vòng tồn kho.', '2026-04-19 08:26:00', '2026-04-19 08:26:00', 0),
    ('product-034', 'Vợt bóng bàn STIGA Pro Carbon+', 'TT-014', 'Bóng bàn', 'STIGA', 'Tiêu chuẩn', 'Đen / Đỏ', 1650000, 2490000, 7, 'Đang bán', '', NULL, 'STIGA Pro Carbon+ là mẫu vợt offensive 5 sao.', 'Phân khúc cao hơn cho người chơi nghiêm túc.', '2026-04-19 08:27:00', '2026-04-19 08:27:00', 0),
    ('product-035', 'Vợt bóng bàn Donic Waldner 700', 'TT-015', 'Bóng bàn', 'Donic', 'Tiêu chuẩn', 'Đỏ / Đen', 650000, 990000, 8, 'Đang bán', '', NULL, 'Donic Waldner 700 là vợt lắp sẵn quen thuộc của Donic.', 'Tên sản phẩm có trên nhiều sàn TMĐT.', '2026-04-19 08:28:00', '2026-04-19 08:28:00', 0),
    ('product-036', 'Vợt bóng bàn JOOLA Rosskopf Classic', 'TT-016', 'Bóng bàn', 'JOOLA', 'Tiêu chuẩn', 'Đỏ / Đen', 520000, 850000, 10, 'Đang bán', '', NULL, 'Rosskopf Classic là mẫu vợt competition-level của JOOLA.', 'Tên sản phẩm xác thực trên JOOLA USA.', '2026-04-19 08:29:00', '2026-04-19 08:29:00', 0),
    ('product-037', 'Mặt vợt bóng bàn Butterfly Tenergy 05', 'TT-017', 'Bóng bàn', 'Butterfly', '2.1 mm', 'Đỏ', 1280000, 1790000, 10, 'Đang bán', '', NULL, 'Tenergy 05 là một trong các mặt vợt nổi tiếng nhất của Butterfly.', 'Phù hợp nhóm khách offensive.', '2026-04-19 08:30:00', '2026-04-19 08:30:00', 0),
    ('product-038', 'Mặt vợt bóng bàn Butterfly Rozena', 'TT-018', 'Bóng bàn', 'Butterfly', '1.9 mm', 'Đen', 850000, 1250000, 11, 'Đang bán', '', NULL, 'Rozena là mặt vợt dễ chơi, cân bằng tốc độ và kiểm soát.', 'Bán tốt cho người chơi trung cấp.', '2026-04-19 08:31:00', '2026-04-19 08:31:00', 0),
    ('product-039', 'Mặt vợt bóng bàn DHS Hurricane 3 Neo', 'TT-019', 'Bóng bàn', 'DHS', '2.15 mm', 'Đỏ', 620000, 980000, 14, 'Đang bán', '', NULL, 'Hurricane 3 Neo là mặt vợt tacky rất nổi tiếng của DHS.', 'Mặt thuận phổ biến cho người chơi Trung Quốc-style.', '2026-04-19 08:32:00', '2026-04-19 08:32:00', 0),
    ('product-040', 'Mặt vợt bóng bàn Donic Bluefire M1', 'TT-020', 'Bóng bàn', 'Donic', '2.0 mm', 'Đen', 980000, 1450000, 9, 'Đang bán', '', NULL, 'Bluefire M1 là mặt vợt tấn công tốc độ của Donic.', 'Tên sản phẩm xác thực trên Donic.', '2026-04-19 08:33:00', '2026-04-19 08:33:00', 0),
    ('product-041', 'Mặt vợt bóng bàn Xiom Vega X', 'TT-021', 'Bóng bàn', 'Xiom', '2.0 mm', 'Đỏ', 820000, 1290000, 10, 'Đang bán', '', NULL, 'Vega X thuộc dòng mặt vợt offensive phổ biến của Xiom.', 'Hàng phù hợp khách nâng cấp setup.', '2026-04-19 08:34:00', '2026-04-19 08:34:00', 0),
    ('product-042', 'Bóng bóng bàn Nittaku Premium 40+ 3-Star', 'TT-022', 'Bóng bàn', 'Nittaku', '40+ 3 sao', 'Trắng', 160000, 290000, 24, 'Đang bán', '', NULL, 'Nittaku Premium 40+ 3-Star là bóng thi đấu cao cấp.', 'Đóng hộp 3 quả.', '2026-04-19 08:35:00', '2026-04-19 08:35:00', 0),
    ('product-043', 'Bóng bóng bàn DHS DJ40+ WTT', 'TT-023', 'Bóng bàn', 'DHS', '40+ 3 sao', 'Trắng', 180000, 320000, 20, 'Đang bán', '', NULL, 'DJ40+ WTT là bóng thi đấu chính thức của DHS.', 'Đóng hộp 6 quả.', '2026-04-19 08:36:00', '2026-04-19 08:36:00', 0),
    ('product-044', 'Bóng bóng bàn Butterfly R40+ 3-Star', 'TT-024', 'Bóng bàn', 'Butterfly', '40+ 3 sao', 'Trắng', 150000, 280000, 22, 'Đang bán', '', NULL, 'R40+ 3-Star là bóng thi đấu của Butterfly.', 'Đóng hộp 3 quả.', '2026-04-19 08:37:00', '2026-04-19 08:37:00', 0),
    ('product-045', 'Bộ lưới bóng bàn JOOLA Essentials Table Tennis Net Set', 'TT-025', 'Bóng bàn', 'JOOLA', 'Tiêu chuẩn', 'Đen', 290000, 480000, 11, 'Đang bán', '', NULL, 'Bộ lưới kẹp bàn thuộc dòng Essentials của JOOLA.', 'Phụ kiện dễ đi kèm bàn bóng bàn.', '2026-04-19 08:38:00', '2026-04-19 08:38:00', 0),
    ('product-046', 'Keo dán mặt vợt Butterfly Free Chack II', 'TT-026', 'Bóng bàn', 'Butterfly', '500 ml', 'Trắng', 390000, 650000, 8, 'Đang bán', '', NULL, 'Free Chack II là keo dán mặt vợt nổi tiếng của Butterfly.', 'Phù hợp nhóm khách custom vợt.', '2026-04-19 08:39:00', '2026-04-19 08:39:00', 0),

    ('product-047', 'Bóng chuyền Mikasa V200W', 'VB-002', 'Bóng chuyền', 'Mikasa', 'Số 5', 'Vàng / Xanh', 1580000, 2390000, 10, 'Đang bán', '', NULL, 'V200W là bóng thi đấu chính thức FIVB của Mikasa.', 'Tên sản phẩm xác thực trên Mikasa Sports.', '2026-04-19 08:40:00', '2026-04-19 08:40:00', 0),
    ('product-048', 'Bóng chuyền Mikasa V330W', 'VB-003', 'Bóng chuyền', 'Mikasa', 'Số 5', 'Vàng / Xanh', 980000, 1490000, 14, 'Đang bán', '', NULL, 'V330W là club version của V200W.', 'Phù hợp tập luyện CLB và trường học.', '2026-04-19 08:41:00', '2026-04-19 08:41:00', 0),
    ('product-049', 'Bóng chuyền Molten V5M5000 FLISTATEC', 'VB-004', 'Bóng chuyền', 'Molten', 'Số 5', 'Xanh / Đỏ / Trắng', 1650000, 2480000, 9, 'Đang bán', '', NULL, 'V5M5000 là bóng chuyền FLISTATEC cao cấp của Molten.', 'Có trên Molten USA.', '2026-04-19 08:42:00', '2026-04-19 08:42:00', 0),
    ('product-050', 'Bóng chuyền Molten V5M4000', 'VB-005', 'Bóng chuyền', 'Molten', 'Số 5', 'Xanh / Trắng', 920000, 1390000, 13, 'Đang bán', '', NULL, 'V5M4000 là dòng bóng chuyền indoor phổ biến của Molten.', 'Phù hợp đội phong trào.', '2026-04-19 08:43:00', '2026-04-19 08:43:00', 0),
    ('product-051', 'Bóng chuyền bãi biển Wilson AVP OPTX Official Game Volleyball', 'VB-006', 'Bóng chuyền', 'Wilson', 'Số 5', 'Vàng / Xanh', 1180000, 1790000, 11, 'Đang bán', '', NULL, 'AVP OPTX Official Game Volleyball là bóng beach nổi tiếng của Wilson.', 'Phù hợp nhóm chơi sân cát và biển.', '2026-04-19 08:44:00', '2026-04-19 08:44:00', 0),
    ('product-052', 'Bóng chuyền Tachikara SV5WSC Sensi-Tec', 'VB-007', 'Bóng chuyền', 'Tachikara', 'Số 5', 'Trắng / Đỏ / Xanh', 780000, 1190000, 12, 'Đang bán', '', NULL, 'SV5WSC Sensi-Tec là bóng training phổ biến của Tachikara.', 'Mẫu bóng phổ biến trên sàn TMĐT.', '2026-04-19 08:45:00', '2026-04-19 08:45:00', 0),
    ('product-053', 'Bóng chuyền bãi biển Mikasa BV550C Beach Pro', 'VB-008', 'Bóng chuyền', 'Mikasa', 'Số 5', 'Vàng / Xanh', 980000, 1490000, 10, 'Đang bán', '', NULL, 'BV550C Beach Pro là bóng beach cao cấp của Mikasa.', 'Bổ sung nhóm beach volleyball.', '2026-04-19 08:46:00', '2026-04-19 08:46:00', 0),
    ('product-054', 'Bóng chuyền bãi biển Molten V5B5000', 'VB-009', 'Bóng chuyền', 'Molten', 'Số 5', 'Xanh / Trắng', 860000, 1320000, 12, 'Đang bán', '', NULL, 'V5B5000 là bóng beach volleyball của Molten.', 'Mẫu thực tế trên nhiều shop thể thao.', '2026-04-19 08:47:00', '2026-04-19 08:47:00', 0),
    ('product-055', 'Giày bóng chuyền adidas Crazyflight Mid', 'VB-010', 'Bóng chuyền', 'adidas', '40-43', 'Trắng / Xanh', 1980000, 2990000, 8, 'Đang bán', '', NULL, 'Crazyflight Mid là mẫu giày bóng chuyền nổi bật của adidas.', 'Thiên về bật nhảy và phản hồi tốt.', '2026-04-19 08:48:00', '2026-04-19 08:48:00', 0),
    ('product-056', 'Giày bóng chuyền Mizuno Wave Lightning Z8', 'VB-011', 'Bóng chuyền', 'Mizuno', '40-43', 'Trắng / Tím', 2250000, 3390000, 7, 'Đang bán', '', NULL, 'Wave Lightning Z8 là giày thi đấu cao cấp của Mizuno.', 'Form quen thuộc với người chơi chuyền chuyên nghiệp.', '2026-04-19 08:49:00', '2026-04-19 08:49:00', 0),
    ('product-057', 'Giày bóng chuyền ASICS Sky Elite FF 3', 'VB-012', 'Bóng chuyền', 'ASICS', '40-43', 'Trắng / Đỏ', 2380000, 3590000, 6, 'Đang bán', '', NULL, 'Sky Elite FF 3 là dòng giày bóng chuyền cao cấp của ASICS.', 'Tập trung khả năng bật nhảy và đáp đất.', '2026-04-19 08:50:00', '2026-04-19 08:50:00', 0),
    ('product-058', 'Giày bóng chuyền ASICS Gel-Rocket 11', 'VB-013', 'Bóng chuyền', 'ASICS', '40-43', 'Đen / Bạc', 1180000, 1790000, 13, 'Đang bán', '', NULL, 'Gel-Rocket 11 là mẫu giày indoor court rất phổ biến.', 'Phù hợp người mới chơi và phong trào.', '2026-04-19 08:51:00', '2026-04-19 08:51:00', 0),
    ('product-059', 'Giày bóng chuyền Nike Zoom Hyperset 2', 'VB-014', 'Bóng chuyền', 'Nike', '40-43', 'Đen / Volt', 2150000, 3290000, 7, 'Đang bán', '', NULL, 'Zoom Hyperset 2 là dòng giày bóng chuyền cao cấp của Nike.', 'Mẫu giày được săn nhiều trên sàn quốc tế.', '2026-04-19 08:52:00', '2026-04-19 08:52:00', 0),
    ('product-060', 'Bảo vệ gối bóng chuyền Mizuno LR6 Kneepad', 'VB-015', 'Bóng chuyền', 'Mizuno', 'M-L', 'Đen', 260000, 420000, 20, 'Đang bán', '', NULL, 'LR6 là mẫu kneepad nổi tiếng của Mizuno.', 'Phụ kiện cơ bản cho người chơi chuyền.', '2026-04-19 08:53:00', '2026-04-19 08:53:00', 0),
    ('product-061', 'Bảo vệ gối bóng chuyền Nike Streak Volleyball Knee Pads', 'VB-016', 'Bóng chuyền', 'Nike', 'M-L', 'Đen', 320000, 520000, 18, 'Đang bán', '', NULL, 'Streak Volleyball Knee Pads là mẫu kneepad phổ biến của Nike.', 'Có thể bán theo cặp.', '2026-04-19 08:54:00', '2026-04-19 08:54:00', 0),
    ('product-062', 'Áo thi đấu bóng chuyền adidas Tabela 23 Jersey', 'VB-017', 'Bóng chuyền', 'adidas', 'M-L', 'Đỏ / Trắng', 220000, 360000, 24, 'Đang bán', '', NULL, 'Tabela 23 phù hợp cho đội bóng chuyền phong trào.', 'Dễ đồng bộ theo đội.', '2026-04-19 08:55:00', '2026-04-19 08:55:00', 0),
    ('product-063', 'Áo bóng chuyền Puma teamLIGA Jersey', 'VB-018', 'Bóng chuyền', 'Puma', 'M-L', 'Trắng / Đen', 230000, 370000, 21, 'Đang bán', '', NULL, 'teamLIGA Jersey có thể dùng cho bóng chuyền phong trào.', 'Nhóm sản phẩm may mặc xoay vòng nhanh.', '2026-04-19 08:56:00', '2026-04-19 08:56:00', 0),
    ('product-064', 'Bảo vệ gối bóng chuyền McDavid Hex Knee Pads', 'VB-019', 'Bóng chuyền', 'McDavid', 'M-L', 'Đen', 340000, 550000, 16, 'Đang bán', '', NULL, 'Hex Knee Pads là phụ kiện bảo vệ gối rất quen thuộc của McDavid.', 'Bổ sung nhóm phụ kiện bảo hộ.', '2026-04-19 08:57:00', '2026-04-19 08:57:00', 0),
    ('product-065', 'Bóng chuyền mini Mikasa VQ2000', 'VB-020', 'Bóng chuyền', 'Mikasa', 'Mini', 'Vàng / Xanh', 210000, 350000, 15, 'Đang bán', '', NULL, 'VQ2000 là bóng mini phục vụ tập cơ bản và quà tặng.', 'Mẫu dễ bán cho học sinh.', '2026-04-19 08:58:00', '2026-04-19 08:58:00', 0),
    ('product-066', 'Giày bóng chuyền adidas Court Team Bounce 2.0', 'VB-021', 'Bóng chuyền', 'adidas', '40-43', 'Trắng / Đen', 1650000, 2590000, 9, 'Đang bán', '', NULL, 'Court Team Bounce 2.0 dùng tốt cho các môn indoor court.', 'Có thể dùng cho bóng chuyền và cầu lông.', '2026-04-19 08:59:00', '2026-04-19 08:59:00', 0),

    ('product-067', 'Bóng rổ Spalding React TF-250', 'BB-003', 'Bóng rổ', 'Spalding', 'Số 7', 'Cam', 420000, 690000, 16, 'Đang bán', '', NULL, 'React TF-250 là bóng indoor/outdoor phổ biến của Spalding.', 'Tên sản phẩm xác thực trên Spalding.', '2026-04-19 09:00:00', '2026-04-19 09:00:00', 0),
    ('product-068', 'Bóng rổ Spalding Excel TF-500', 'BB-004', 'Bóng rổ', 'Spalding', 'Số 7', 'Cam', 620000, 990000, 14, 'Đang bán', '', NULL, 'Excel TF-500 là bóng all-surface cao hơn TF-250.', 'Dòng phổ biến tại thị trường quốc tế.', '2026-04-19 09:01:00', '2026-04-19 09:01:00', 0),
    ('product-069', 'Bóng rổ Molten BG3800', 'BB-005', 'Bóng rổ', 'Molten', 'Số 7', 'Nâu cam', 780000, 1190000, 12, 'Đang bán', '', NULL, 'BG3800 là bóng FIBA Approved indoor/outdoor của Molten.', 'Tên sản phẩm xác thực trên Molten USA.', '2026-04-19 09:02:00', '2026-04-19 09:02:00', 0),
    ('product-070', 'Bóng rổ Molten BG4500', 'BB-006', 'Bóng rổ', 'Molten', 'Số 7', 'Nâu cam', 1180000, 1790000, 10, 'Đang bán', '', NULL, 'BG4500 là dòng bóng thi đấu cao cấp của Molten.', 'Phù hợp sân trong nhà.', '2026-04-19 09:03:00', '2026-04-19 09:03:00', 0),
    ('product-071', 'Bóng rổ Wilson NBA DRV Pro', 'BB-007', 'Bóng rổ', 'Wilson', 'Số 7', 'Cam', 620000, 980000, 13, 'Đang bán', '', NULL, 'NBA DRV Pro là bóng outdoor phổ biến của Wilson.', 'Thuộc line NBA chính thức.', '2026-04-19 09:04:00', '2026-04-19 09:04:00', 0),
    ('product-072', 'Bóng rổ Wilson NBA Forge Plus', 'BB-008', 'Bóng rổ', 'Wilson', 'Số 7', 'Cam', 480000, 790000, 15, 'Đang bán', '', NULL, 'NBA Forge Plus là bóng basket outdoor dễ tiếp cận của Wilson.', 'Dễ bán cho sinh viên và học sinh.', '2026-04-19 09:05:00', '2026-04-19 09:05:00', 0),
    ('product-073', 'Giày bóng rổ Nike Giannis Immortality 4', 'BB-009', 'Bóng rổ', 'Nike', '40-43', 'Trắng / Xanh', 1450000, 2290000, 9, 'Đang bán', '', NULL, 'Giannis Immortality 4 là mẫu giày bóng rổ của Nike.', 'Tên sản phẩm xác thực trên Nike.', '2026-04-19 09:06:00', '2026-04-19 09:06:00', 0),
    ('product-074', 'Giày bóng rổ Nike LeBron Witness 8', 'BB-010', 'Bóng rổ', 'Nike', '40-43', 'Đen / Vàng', 1680000, 2590000, 8, 'Đang bán', '', NULL, 'LeBron Witness 8 là giày bóng rổ phổ biến phân khúc tầm trung.', 'Hợp khách thích dòng LeBron.', '2026-04-19 09:07:00', '2026-04-19 09:07:00', 0),
    ('product-075', 'Giày bóng rổ adidas Own The Game 3.0', 'BB-011', 'Bóng rổ', 'adidas', '40-43', 'Đen / Trắng', 1180000, 1890000, 10, 'Đang bán', '', NULL, 'Own The Game 3.0 là mẫu giày bóng rổ phổ thông của adidas.', 'Dễ bán ở tệp khách beginner.', '2026-04-19 09:08:00', '2026-04-19 09:08:00', 0),
    ('product-076', 'Giày bóng rổ adidas Dame Certified 3', 'BB-012', 'Bóng rổ', 'adidas', '40-43', 'Đỏ / Đen', 1450000, 2290000, 8, 'Đang bán', '', NULL, 'Dame Certified 3 là mẫu signature giá tốt của adidas.', 'Phù hợp khách cần grip và ổn định.', '2026-04-19 09:09:00', '2026-04-19 09:09:00', 0),
    ('product-077', 'Giày bóng rổ PUMA Court Pro', 'BB-013', 'Bóng rổ', 'PUMA', '40-43', 'Trắng / Cam', 1320000, 2090000, 9, 'Đang bán', '', NULL, 'Court Pro là mẫu giày bóng rổ hiện đại của PUMA.', 'Form đẹp, hợp xu hướng lifestyle.', '2026-04-19 09:10:00', '2026-04-19 09:10:00', 0),
    ('product-078', 'Giày bóng rổ Under Armour Curry 3Z 24', 'BB-014', 'Bóng rổ', 'Under Armour', '40-43', 'Xanh / Bạc', 1550000, 2450000, 7, 'Đang bán', '', NULL, 'Curry 3Z 24 là mẫu giày bóng rổ outdoor/indoor của Under Armour.', 'Có sức hút với fan Stephen Curry.', '2026-04-19 09:11:00', '2026-04-19 09:11:00', 0),
    ('product-079', 'Bóng rổ Jordan Playground 2.0 8P', 'BB-015', 'Bóng rổ', 'Jordan', 'Số 7', 'Cam / Đen', 520000, 850000, 12, 'Đang bán', '', NULL, 'Jordan Playground 2.0 8P là bóng outdoor phổ biến.', 'Bổ sung line Jordan cho danh mục bóng rổ.', '2026-04-19 09:12:00', '2026-04-19 09:12:00', 0),
    ('product-080', 'Bóng rổ Nike Everyday Playground 8P 2.0', 'BB-016', 'Bóng rổ', 'Nike', 'Số 7', 'Cam / Đen', 480000, 790000, 14, 'Đang bán', '', NULL, 'Everyday Playground 8P 2.0 là bóng outdoor phổ biến của Nike.', 'Dễ bán cho khách chơi sân trường.', '2026-04-19 09:13:00', '2026-04-19 09:13:00', 0),
    ('product-081', 'Bảng rổ mini Spalding Slam Jam Over-The-Door Mini Hoop', 'BB-017', 'Bóng rổ', 'Spalding', 'Mini', 'Đen / Đỏ', 720000, 1190000, 6, 'Đang bán', '', NULL, 'Mini hoop gắn cửa thuộc line Slam Jam của Spalding.', 'Sản phẩm phụ kiện/hobby bán tốt online.', '2026-04-19 09:14:00', '2026-04-19 09:14:00', 0),
    ('product-082', 'Bóng rổ Wilson NBA Authentic Indoor/Outdoor', 'BB-018', 'Bóng rổ', 'Wilson', 'Số 7', 'Nâu cam', 880000, 1350000, 10, 'Đang bán', '', NULL, 'Bóng thuộc line NBA Authentic của Wilson.', 'Phù hợp sân trong nhà và ngoài trời.', '2026-04-19 09:15:00', '2026-04-19 09:15:00', 0),
    ('product-083', 'Ống tay bóng rổ McDavid Hex Shooter Arm Sleeve', 'BB-019', 'Bóng rổ', 'McDavid', 'M-L', 'Đen', 190000, 320000, 18, 'Đang bán', '', NULL, 'Hex Shooter Arm Sleeve là phụ kiện quen thuộc với người chơi bóng rổ.', 'Bổ sung nhóm phụ kiện bảo hộ.', '2026-04-19 09:16:00', '2026-04-19 09:16:00', 0),
    ('product-084', 'Tất bóng rổ Nike Elite Crew', 'BB-020', 'Bóng rổ', 'Nike', 'One size', 'Trắng / Đen', 180000, 320000, 26, 'Đang bán', '', NULL, 'Nike Elite Crew là dòng tất bóng rổ phổ biến.', 'Bán kèm tốt với giày basket.', '2026-04-19 09:17:00', '2026-04-19 09:17:00', 0),
    ('product-085', 'Áo bóng rổ Jordan Sport Dri-FIT Sleeveless Top', 'BB-021', 'Bóng rổ', 'Jordan', 'M-L', 'Đen', 360000, 590000, 14, 'Đang bán', '', NULL, 'Áo sleeveless Dri-FIT thuộc line Jordan Sport.', 'Phù hợp tập luyện và casual wear.', '2026-04-19 09:18:00', '2026-04-19 09:18:00', 0),
    ('product-086', 'Balo bóng rổ Nike Hoops Elite Backpack', 'BB-022', 'Bóng rổ', 'Nike', '32L', 'Đen / Xám', 820000, 1290000, 9, 'Đang bán', '', NULL, 'Hoops Elite Backpack là balo rất phổ biến của Nike Basketball.', 'Có thể bán cho cả học sinh và người chơi sân phủi.', '2026-04-19 09:19:00', '2026-04-19 09:19:00', 0),

    ('product-087', 'Vợt cầu lông Yonex Astrox 88 Play', 'BM-002', 'Cầu lông', 'Yonex', '4U-G5', 'Đen / Bạc', 1280000, 1890000, 10, 'Đang bán', '', NULL, 'Astrox 88 Play là mẫu racket beginner thuộc line Astrox.', 'Tên sản phẩm xác thực trên Yonex.', '2026-04-19 09:20:00', '2026-04-19 09:20:00', 0),
    ('product-088', 'Vợt cầu lông Yonex Arcsaber 11 Play', 'BM-003', 'Cầu lông', 'Yonex', '4U-G5', 'Grayish Pearl', 1260000, 1850000, 9, 'Đang bán', '', NULL, 'Arcsaber 11 Play là mẫu racket control thuộc line Arcsaber.', 'Hợp người chơi công thủ toàn diện.', '2026-04-19 09:21:00', '2026-04-19 09:21:00', 0),
    ('product-089', 'Vợt cầu lông Yonex Nanoflare 1000 Play', 'BM-004', 'Cầu lông', 'Yonex', '4U-G5', 'Lightning Yellow', 1240000, 1820000, 8, 'Đang bán', '', NULL, 'Nanoflare 1000 Play thiên về tốc độ và xoay trở nhanh.', 'Tên sản phẩm xác thực trên Yonex.', '2026-04-19 09:22:00', '2026-04-19 09:22:00', 0),
    ('product-090', 'Vợt cầu lông Yonex Nanoflare 1000 Game', 'BM-005', 'Cầu lông', 'Yonex', '4U-G5', 'Lightning Yellow', 1980000, 2890000, 7, 'Đang bán', '', NULL, 'Nanoflare 1000 Game là bản cao hơn Play của Yonex.', 'Phù hợp người chơi trung cấp.', '2026-04-19 09:23:00', '2026-04-19 09:23:00', 0),
    ('product-091', 'Vợt cầu lông Li-Ning Windstorm 72', 'BM-006', 'Cầu lông', 'Li-Ning', '6U-G6', 'Trắng / Xanh', 1580000, 2390000, 8, 'Đang bán', '', NULL, 'Windstorm 72 là mẫu vợt siêu nhẹ nổi tiếng của Li-Ning.', 'Dễ bán cho người thích vợt nhẹ.', '2026-04-19 09:24:00', '2026-04-19 09:24:00', 0),
    ('product-092', 'Vợt cầu lông Li-Ning Halbertec 2000', 'BM-007', 'Cầu lông', 'Li-Ning', '4U-G5', 'Đen / Vàng', 1380000, 2090000, 8, 'Đang bán', '', NULL, 'Halbertec 2000 là dòng vợt all-round của Li-Ning.', 'Tên sản phẩm phổ biến trên thị trường.', '2026-04-19 09:25:00', '2026-04-19 09:25:00', 0),
    ('product-093', 'Vợt cầu lông Victor Thruster K 12 M', 'BM-008', 'Cầu lông', 'Victor', '4U-G5', 'Blast Blue', 1780000, 2690000, 6, 'Đang bán', '', NULL, 'Thruster K 12 M là mẫu vợt thiên công của Victor.', 'Sản phẩm thực tế trên các shop cầu lông lớn.', '2026-04-19 09:26:00', '2026-04-19 09:26:00', 0),
    ('product-094', 'Vợt cầu lông Victor Auraspeed 90K II', 'BM-009', 'Cầu lông', 'Victor', '4U-G5', 'Xanh / Đen', 2150000, 3190000, 5, 'Đang bán', '', NULL, 'Auraspeed 90K II là mẫu vợt speed/control của Victor.', 'Dòng bán tốt ở tệp khách trung cao cấp.', '2026-04-19 09:27:00', '2026-04-19 09:27:00', 0),
    ('product-095', 'Cầu lông lông vũ Yonex Aerosensa 30', 'BM-010', 'Cầu lông', 'Yonex', '12 quả', 'Trắng', 720000, 1090000, 13, 'Đang bán', '', NULL, 'Aerosensa 30 là ống cầu lông cao cấp của Yonex.', 'Phù hợp sân chơi chất lượng cao.', '2026-04-19 09:28:00', '2026-04-19 09:28:00', 0),
    ('product-096', 'Cầu lông nhựa Yonex Mavis 350', 'BM-011', 'Cầu lông', 'Yonex', '6 quả', 'Vàng', 180000, 290000, 22, 'Đang bán', '', NULL, 'Mavis 350 là dòng cầu nhựa rất phổ biến của Yonex.', 'Tệp học sinh sinh viên mua nhiều.', '2026-04-19 09:29:00', '2026-04-19 09:29:00', 0),
    ('product-097', 'Cầu lông lông vũ Victor Master Ace', 'BM-012', 'Cầu lông', 'Victor', '12 quả', 'Trắng', 880000, 1320000, 11, 'Đang bán', '', NULL, 'Master Ace là dòng cầu lông thi đấu cao cấp của Victor.', 'Thuộc nhóm cầu premium.', '2026-04-19 09:30:00', '2026-04-19 09:30:00', 0),
    ('product-098', 'Cầu lông lông vũ Li-Ning No.1', 'BM-013', 'Cầu lông', 'Li-Ning', '12 quả', 'Trắng', 620000, 980000, 14, 'Đang bán', '', NULL, 'Li-Ning No.1 là ống cầu lông rất phổ biến ở thị trường châu Á.', 'Độ bền và đường bay ổn định.', '2026-04-19 09:31:00', '2026-04-19 09:31:00', 0),
    ('product-099', 'Giày cầu lông Yonex Power Cushion 65 Z3', 'BM-014', 'Cầu lông', 'Yonex', '40-43', 'Trắng / Xanh', 1980000, 2990000, 8, 'Đang bán', '', NULL, 'Power Cushion 65 Z3 là mẫu giày cầu lông cao cấp của Yonex.', 'Rất phổ biến với người chơi phong trào nâng cao.', '2026-04-19 09:32:00', '2026-04-19 09:32:00', 0),
    ('product-100', 'Giày cầu lông Yonex Aerus Z2', 'BM-015', 'Cầu lông', 'Yonex', '40-43', 'Xanh mint', 1860000, 2850000, 7, 'Đang bán', '', NULL, 'Aerus Z2 là mẫu giày siêu nhẹ của Yonex.', 'Phù hợp người chơi đôi cần di chuyển nhanh.', '2026-04-19 09:33:00', '2026-04-19 09:33:00', 0),
    ('product-101', 'Giày cầu lông Victor A970 NitroLite', 'BM-016', 'Cầu lông', 'Victor', '40-43', 'Trắng / Xanh', 1680000, 2590000, 7, 'Đang bán', '', NULL, 'A970 NitroLite là mẫu giày cầu lông nổi tiếng của Victor.', 'Form giày ổn định, bám sân tốt.', '2026-04-19 09:34:00', '2026-04-19 09:34:00', 0),
    ('product-102', 'Giày cầu lông Li-Ning Ranger Lite Z1', 'BM-017', 'Cầu lông', 'Li-Ning', '40-43', 'Đen / Đỏ', 1320000, 2090000, 9, 'Đang bán', '', NULL, 'Ranger Lite Z1 là mẫu giày indoor court của Li-Ning.', 'Có thể bán chéo cho khách cầu lông và bóng chuyền.', '2026-04-19 09:35:00', '2026-04-19 09:35:00', 0),
    ('product-103', 'Cước cầu lông Yonex BG65', 'BM-018', 'Cầu lông', 'Yonex', '0.70 mm', 'Trắng', 120000, 190000, 26, 'Đang bán', '', NULL, 'BG65 là loại cước cầu lông rất phổ biến của Yonex.', 'Phù hợp nhiều kiểu lối chơi.', '2026-04-19 09:36:00', '2026-04-19 09:36:00', 0),
    ('product-104', 'Cước cầu lông Yonex Nanogy 95', 'BM-019', 'Cầu lông', 'Yonex', '0.69 mm', 'Vàng', 160000, 260000, 20, 'Đang bán', '', NULL, 'Nanogy 95 là loại cước bền và trợ lực tốt của Yonex.', 'Bán tốt cho người chơi phong trào.', '2026-04-19 09:37:00', '2026-04-19 09:37:00', 0),
    ('product-105', 'Túi cầu lông Yonex Expert Tournament Bag', 'BM-020', 'Cầu lông', 'Yonex', '6 cây', 'Đen', 620000, 980000, 11, 'Đang bán', '', NULL, 'Expert Tournament Bag là túi cầu lông nhiều ngăn của Yonex.', 'Phù hợp người chơi đi sân thường xuyên.', '2026-04-19 09:38:00', '2026-04-19 09:38:00', 0),
    ('product-106', 'Quấn cán cầu lông Yonex AC102EX Super Grap', 'BM-021', 'Cầu lông', 'Yonex', '3 cuộn', 'Vàng', 65000, 110000, 40, 'Đang bán', '', NULL, 'AC102EX Super Grap là quấn cán rất quen thuộc của Yonex.', 'Phụ kiện bán kèm tốt cho mọi đơn cầu lông.', '2026-04-19 09:39:00', '2026-04-19 09:39:00', 0)
ON DUPLICATE KEY UPDATE
    ten_san_pham = VALUES(ten_san_pham),
    danh_muc = VALUES(danh_muc),
    thuong_hieu = VALUES(thuong_hieu),
    size = VALUES(size),
    mau = VALUES(mau),
    gia_nhap = VALUES(gia_nhap),
    gia_ban = VALUES(gia_ban),
    ton_kho = VALUES(ton_kho),
    trang_thai = VALUES(trang_thai),
    mo_ta_ngan = VALUES(mo_ta_ngan),
    ghi_chu = VALUES(ghi_chu),
    is_deleted = VALUES(is_deleted);

INSERT INTO tbl_san_pham (
    id, ten_san_pham, sku, danh_muc, thuong_hieu, size, mau,
    gia_nhap, gia_ban, ton_kho, trang_thai, link_san_pham, hinh_anh_url,
    mo_ta_ngan, ghi_chu, ngay_tao, ngay_cap_nhat, is_deleted
)
VALUES
    ('product-107', 'Nike Academy Plus Soccer Ball', 'FB-027', 'Bóng đá', 'Nike', 'Số 5', 'Trắng / Đen', 420000, 640000, 16, 'Đang bán', '', NULL, 'Bóng tập và thi đấu phong trào thuộc dòng Academy Plus của Nike.', 'Giữ lại 1 sản phẩm mới cho danh mục bóng đá.', '2026-04-19 09:40:00', '2026-04-19 09:40:00', 0),
    ('product-108', 'STIGA Allround Evolution', 'TT-027', 'Bóng bàn', 'STIGA', 'Tiêu chuẩn', 'Gỗ tự nhiên', 680000, 1080000, 8, 'Đang bán', '', NULL, 'Cốt vợt STIGA Allround Evolution dành cho lối chơi công thủ toàn diện.', 'Giữ lại 1 sản phẩm mới cho danh mục bóng bàn.', '2026-04-19 09:41:00', '2026-04-19 09:41:00', 0),
    ('product-109', 'Mikasa V390W', 'VB-022', 'Bóng chuyền', 'Mikasa', 'Số 5', 'Vàng / Xanh', 760000, 1180000, 14, 'Đang bán', '', NULL, 'Mikasa V390W là bóng chuyền tập luyện phổ biến cho trường và CLB.', 'Giữ lại 1 sản phẩm mới cho danh mục bóng chuyền.', '2026-04-19 09:42:00', '2026-04-19 09:42:00', 0),
    ('product-110', 'Wilson Evolution Game Basketball', 'BB-023', 'Bóng rổ', 'Wilson', 'Số 7', 'Cam', 980000, 1490000, 12, 'Đang bán', '', NULL, 'Wilson Evolution là một trong những bóng indoor phổ biến nhất ở thị trường Mỹ.', 'Giữ lại 1 sản phẩm mới cho danh mục bóng rổ.', '2026-04-19 09:43:00', '2026-04-19 09:43:00', 0),
    ('product-111', 'Yonex Astrox 77 Play', 'BM-022', 'Cầu lông', 'Yonex', '4U-G5', 'High Orange', 1380000, 2050000, 9, 'Đang bán', '', NULL, 'Astrox 77 Play là vợt cầu lông dành cho người chơi thích cảm giác head-heavy vừa phải.', 'Giữ lại 1 sản phẩm mới cho danh mục cầu lông.', '2026-04-19 09:44:00', '2026-04-19 09:44:00', 0)
ON DUPLICATE KEY UPDATE
    ten_san_pham = VALUES(ten_san_pham),
    danh_muc = VALUES(danh_muc),
    thuong_hieu = VALUES(thuong_hieu),
    size = VALUES(size),
    mau = VALUES(mau),
    gia_nhap = VALUES(gia_nhap),
    gia_ban = VALUES(gia_ban),
    ton_kho = VALUES(ton_kho),
    trang_thai = VALUES(trang_thai),
    mo_ta_ngan = VALUES(mo_ta_ngan),
    ghi_chu = VALUES(ghi_chu),
    is_deleted = VALUES(is_deleted);

INSERT INTO tbl_san_pham (
    id, ten_san_pham, sku, danh_muc, thuong_hieu, size, mau,
    gia_nhap, gia_ban, ton_kho, trang_thai, link_san_pham, hinh_anh_url,
    mo_ta_ngan, ghi_chu, ngay_tao, ngay_cap_nhat, is_deleted
)
VALUES
    ('product-112', 'Nike Strike Knee-High Soccer Socks', 'FB-028', 'Bóng đá', 'Nike', 'M-L', 'Trắng / Đen', 180000, 290000, 18, 'Đang bán', '', NULL, 'Dòng tất bóng đá cổ cao thuộc line Nike Strike, phù hợp đá sân cỏ nhân tạo và sân 7.', 'Bổ sung nhóm tất bóng đá trong danh mục phụ kiện.', '2026-04-20 09:00:00', '2026-04-20 09:00:00', 0),
    ('product-113', 'adidas Milano 23 Socks', 'FB-029', 'Bóng đá', 'adidas', 'M-L', 'Xanh navy / Trắng', 170000, 280000, 16, 'Đang bán', '', NULL, 'Mẫu tất bóng đá phổ biến của adidas cho cầu thủ phong trào và đội nhóm.', 'Bổ sung nhóm tất bóng đá trong danh mục phụ kiện.', '2026-04-20 09:01:00', '2026-04-20 09:01:00', 0),
    ('product-114', 'Nike Fundamental Towel Large', 'FB-030', 'Bóng đá', 'Nike', 'Large', 'Đen / Trắng', 210000, 340000, 12, 'Đang bán', '', NULL, 'Khăn thể thao cỡ lớn phù hợp mang theo khi tập bóng đá, gym hoặc chạy bộ.', 'Bổ sung nhóm khăn lau cho bóng đá.', '2026-04-20 09:02:00', '2026-04-20 09:02:00', 0),
    ('product-115', 'adidas Sports Towel Small', 'FB-031', 'Bóng đá', 'adidas', 'Small', 'Trắng / Đỏ', 150000, 250000, 14, 'Đang bán', '', NULL, 'Khăn thể thao cỡ nhỏ của adidas dùng tốt cho tập luyện và thi đấu phong trào.', 'Bổ sung nhóm khăn lau cho bóng đá.', '2026-04-20 09:03:00', '2026-04-20 09:03:00', 0),
    ('product-116', 'Mizuno Performance Plus Volleyball Crew Socks', 'VB-023', 'Bóng chuyền', 'Mizuno', 'M-L', 'Trắng / Xanh', 190000, 320000, 15, 'Đang bán', '', NULL, 'Mẫu tất thể thao cổ crew của Mizuno phù hợp cho người chơi bóng chuyền indoor.', 'Bổ sung nhóm tất bóng chuyền trong danh mục phụ kiện.', '2026-04-20 09:04:00', '2026-04-20 09:04:00', 0),
    ('product-117', 'Nike Everyday Plus Cushioned Crew Socks', 'VB-024', 'Bóng chuyền', 'Nike', 'M-L', 'Đen / Trắng', 175000, 290000, 18, 'Đang bán', '', NULL, 'Tất crew đệm dày, phù hợp mang cùng giày bóng chuyền và các môn sân trong nhà.', 'Bổ sung nhóm tất bóng chuyền trong danh mục phụ kiện.', '2026-04-20 09:05:00', '2026-04-20 09:05:00', 0),
    ('product-118', 'Mizuno Sports Towel', 'VB-025', 'Bóng chuyền', 'Mizuno', 'Medium', 'Xanh navy', 185000, 310000, 10, 'Đang bán', '', NULL, 'Khăn thể thao của Mizuno phù hợp cho người chơi bóng chuyền, cầu lông và gym.', 'Bổ sung nhóm khăn lau cho bóng chuyền.', '2026-04-20 09:06:00', '2026-04-20 09:06:00', 0),
    ('product-119', 'ASICS Sports Towel', 'VB-026', 'Bóng chuyền', 'ASICS', 'Medium', 'Trắng / Xanh', 180000, 300000, 11, 'Đang bán', '', NULL, 'Khăn lau tập luyện cỡ vừa, phù hợp cho vận động viên chơi bóng chuyền trong nhà.', 'Bổ sung nhóm khăn lau cho bóng chuyền.', '2026-04-20 09:07:00', '2026-04-20 09:07:00', 0),
    ('product-120', 'Mizuno Team Backpack 23', 'VB-027', 'Bóng chuyền', 'Mizuno', '23L', 'Đen / Xanh', 520000, 820000, 9, 'Đang bán', '', NULL, 'Balo thể thao của Mizuno có ngăn chứa đồ tập, giày và phụ kiện sân trong nhà.', 'Bổ sung nhóm balo thể thao cho bóng chuyền.', '2026-04-20 09:08:00', '2026-04-20 09:08:00', 0),
    ('product-121', 'Nike Brasilia 9.5 Training Backpack', 'VB-028', 'Bóng chuyền', 'Nike', '24L', 'Đen', 560000, 890000, 13, 'Đang bán', '', NULL, 'Balo training đa năng của Nike, phù hợp mang đi tập bóng chuyền và các môn indoor court.', 'Bổ sung nhóm balo thể thao cho bóng chuyền.', '2026-04-20 09:09:00', '2026-04-20 09:09:00', 0),
    ('product-122', 'Jordan Jumpman Sport Towel', 'BB-024', 'Bóng rổ', 'Jordan', 'Medium', 'Đen / Đỏ', 220000, 360000, 10, 'Đang bán', '', NULL, 'Khăn thể thao phong cách basketball, phù hợp sử dụng trong luyện tập và thi đấu bóng rổ.', 'Bổ sung nhóm khăn lau cho bóng rổ.', '2026-04-20 09:10:00', '2026-04-20 09:10:00', 0),
    ('product-123', 'Under Armour Performance Towel', 'BB-025', 'Bóng rổ', 'Under Armour', 'Medium', 'Xám / Đen', 210000, 350000, 12, 'Đang bán', '', NULL, 'Khăn thể thao đa dụng phù hợp cho người chơi bóng rổ tập sân trong nhà và ngoài trời.', 'Bổ sung nhóm khăn lau cho bóng rổ.', '2026-04-20 09:11:00', '2026-04-20 09:11:00', 0),
    ('product-124', 'Butterfly Selasia Shirt', 'TT-028', 'Bóng bàn', 'Butterfly', 'M-L', 'Đen / Xanh', 720000, 1140000, 8, 'Đang bán', '', NULL, 'Áo thi đấu bóng bàn của Butterfly phù hợp cho CLB, giải phong trào và thi đấu đội nhóm.', 'Bổ sung nhóm trang phục cho bóng bàn.', '2026-04-20 09:12:00', '2026-04-20 09:12:00', 0),
    ('product-125', 'JOOLA Centrela Polo Shirt', 'TT-029', 'Bóng bàn', 'JOOLA', 'M-L', 'Black / Blue', 650000, 990000, 9, 'Đang bán', '', NULL, 'Áo polo bóng bàn của JOOLA dùng tốt cho tập luyện, thi đấu CLB và đồng phục đội.', 'Bổ sung nhóm trang phục cho bóng bàn.', '2026-04-20 09:13:00', '2026-04-20 09:13:00', 0),
    ('product-126', 'Yonex Crew Neck Shirt 10627', 'BM-023', 'Cầu lông', 'Yonex', 'M-L', 'White / Clear Mint', 890000, 1390000, 10, 'Đang bán', '', NULL, 'Áo cầu lông chính hãng thuộc line Crew Neck Shirt của Yonex, phù hợp tập luyện và thi đấu.', 'Bổ sung nhóm trang phục cho cầu lông.', '2026-04-20 09:14:00', '2026-04-20 09:14:00', 0),
    ('product-127', 'VICTOR Knitted Shorts R-3096 A', 'BM-024', 'Cầu lông', 'Victor', 'M-L', 'White', 520000, 820000, 9, 'Đang bán', '', NULL, 'Quần shorts thể thao của Victor dành cho người chơi cầu lông, mặc nhẹ và khô nhanh.', 'Bổ sung nhóm trang phục cho cầu lông.', '2026-04-20 09:15:00', '2026-04-20 09:15:00', 0)
ON DUPLICATE KEY UPDATE
    ten_san_pham = VALUES(ten_san_pham),
    danh_muc = VALUES(danh_muc),
    thuong_hieu = VALUES(thuong_hieu),
    size = VALUES(size),
    mau = VALUES(mau),
    gia_nhap = VALUES(gia_nhap),
    gia_ban = VALUES(gia_ban),
    ton_kho = VALUES(ton_kho),
    trang_thai = VALUES(trang_thai),
    mo_ta_ngan = VALUES(mo_ta_ngan),
    ghi_chu = VALUES(ghi_chu),
    is_deleted = VALUES(is_deleted);

INSERT INTO tbl_san_pham (
    id, ten_san_pham, sku, danh_muc, thuong_hieu, size, mau,
    gia_nhap, gia_ban, ton_kho, trang_thai, link_san_pham, hinh_anh_url,
    mo_ta_ngan, ghi_chu, ngay_tao, ngay_cap_nhat, is_deleted
)
VALUES
    ('product-128', 'Signed Jersey Lionel Messi Argentina 2024/25', 'FB-132', 'Bóng đá', 'adidas', 'L', 'Sky Blue / White', 54000000, 89900000, 1, 'Đang bán', '', NULL, 'Autographed collectible jersey for display, collection and premium gifting.', 'Superstar signatures collection - football.', '2026-04-21 10:00:00', '2026-04-21 10:00:00', 0),
    ('product-129', 'Signed Jersey Cristiano Ronaldo Portugal 2024/25', 'FB-133', 'Bóng đá', 'Nike', 'L', 'Red / Green', 58000000, 94900000, 1, 'Đang bán', '', NULL, 'Signed Portugal jersey in premium display-ready format.', 'Superstar signatures collection - football.', '2026-04-21 10:01:00', '2026-04-21 10:01:00', 0),
    ('product-130', 'Signed Jersey Neymar Jr Brazil 2024/25', 'FB-134', 'Bóng đá', 'Nike', 'L', 'Yellow / Green', 41000000, 69900000, 1, 'Đang bán', '', NULL, 'Signed Brazil jersey aimed at collectors and luxury gifting.', 'Superstar signatures collection - football.', '2026-04-21 10:02:00', '2026-04-21 10:02:00', 0),
    ('product-131', 'Signed Jersey Kylian Mbappe France 2024/25', 'FB-135', 'Bóng đá', 'Nike', 'L', 'Blue', 46000000, 74900000, 1, 'Đang bán', '', NULL, 'Signed France jersey with high-end memorabilia positioning.', 'Superstar signatures collection - football.', '2026-04-21 10:03:00', '2026-04-21 10:03:00', 0),
    ('product-132', 'Signed Jersey Michael Jordan Chicago Bulls', 'BB-126', 'Bóng rổ', 'Jordan', 'XL', 'Red / Black', 80000000, 129000000, 1, 'Đang bán', '', NULL, 'Premium signed basketball jersey for display and serious collectors.', 'Superstar signatures collection - basketball.', '2026-04-21 10:04:00', '2026-04-21 10:04:00', 0),
    ('product-133', 'Signed Jersey LeBron James Los Angeles Lakers', 'BB-127', 'Bóng rổ', 'Nike', 'XL', 'Gold / Purple', 61000000, 98000000, 1, 'Đang bán', '', NULL, 'Signed Lakers jersey positioned as elite basketball memorabilia.', 'Superstar signatures collection - basketball.', '2026-04-21 10:05:00', '2026-04-21 10:05:00', 0),
    ('product-134', 'Signed Jersey Earvin Ngapeth France Volleyball', 'VB-129', 'Bóng chuyền', 'ASICS', 'L', 'Blue / White', 18000000, 29900000, 2, 'Đang bán', '', NULL, 'Signed volleyball jersey for premium display and gift use.', 'Superstar signatures collection - volleyball.', '2026-04-21 10:06:00', '2026-04-21 10:06:00', 0),
    ('product-135', 'Signed Jersey Yuji Nishida Japan Volleyball', 'VB-130', 'Bóng chuyền', 'Mizuno', 'L', 'Red / Black', 17000000, 27900000, 2, 'Đang bán', '', NULL, 'Signed Japan volleyball jersey in limited collector quantity.', 'Superstar signatures collection - volleyball.', '2026-04-21 10:07:00', '2026-04-21 10:07:00', 0),
    ('product-136', 'Signed Paddle Ma Long Limited Edition', 'TT-130', 'Bóng bàn', 'Butterfly', 'FL', 'Wood / Red / Black', 15000000, 24900000, 2, 'Đang bán', '', NULL, 'Limited signed paddle aimed at table tennis collectors.', 'Superstar signatures collection - table tennis.', '2026-04-21 10:08:00', '2026-04-21 10:08:00', 0),
    ('product-137', 'Signed Paddle Fan Zhendong Limited Edition', 'TT-131', 'Bóng bàn', 'DHS', 'FL', 'Wood / Red / Black', 14000000, 22900000, 2, 'Đang bán', '', NULL, 'Signed paddle for display cabinets and premium gifting.', 'Superstar signatures collection - table tennis.', '2026-04-21 10:09:00', '2026-04-21 10:09:00', 0),
    ('product-138', 'Signed Racket Lin Dan Limited Edition', 'BM-128', 'Cầu lông', 'Yonex', '3U-G5', 'Black / Gold', 22000000, 34900000, 2, 'Đang bán', '', NULL, 'Signed badminton racket in limited collector format.', 'Superstar signatures collection - badminton.', '2026-04-21 10:10:00', '2026-04-21 10:10:00', 0),
    ('product-139', 'Signed Racket Viktor Axelsen Limited Edition', 'BM-129', 'Cầu lông', 'Victor', '4U-G5', 'Black / Blue', 20000000, 31900000, 2, 'Đang bán', '', NULL, 'Signed badminton racket for display, collection and gift demand.', 'Superstar signatures collection - badminton.', '2026-04-21 10:11:00', '2026-04-21 10:11:00', 0)
ON DUPLICATE KEY UPDATE
    ten_san_pham = VALUES(ten_san_pham),
    danh_muc = VALUES(danh_muc),
    thuong_hieu = VALUES(thuong_hieu),
    size = VALUES(size),
    mau = VALUES(mau),
    gia_nhap = VALUES(gia_nhap),
    gia_ban = VALUES(gia_ban),
    ton_kho = VALUES(ton_kho),
    trang_thai = VALUES(trang_thai),
    mo_ta_ngan = VALUES(mo_ta_ngan),
    ghi_chu = VALUES(ghi_chu),
    is_deleted = VALUES(is_deleted);

UPDATE tbl_san_pham
SET danh_muc = CASE
    WHEN sku LIKE 'FB-%' THEN 'Bóng đá'
    WHEN sku LIKE 'TT-%' THEN 'Bóng bàn'
    WHEN sku LIKE 'VB-%' THEN 'Bóng chuyền'
    WHEN sku LIKE 'BB-%' THEN 'Bóng rổ'
    WHEN sku LIKE 'BM-%' THEN 'Cầu lông'
    ELSE danh_muc
END;

UPDATE tbl_san_pham
SET hinh_anh_url = CASE
    WHEN sku LIKE 'FB-%' THEN '/assets/images/catalog/football.svg'
    WHEN sku LIKE 'TT-%' THEN '/assets/images/catalog/table-tennis.svg'
    WHEN sku LIKE 'VB-%' THEN '/assets/images/catalog/volleyball.svg'
    WHEN sku LIKE 'BB-%' THEN '/assets/images/catalog/basketball.svg'
    WHEN sku LIKE 'BM-%' THEN '/assets/images/catalog/badminton.svg'
    ELSE hinh_anh_url
END
WHERE is_deleted = 0;

INSERT INTO tbl_bien_the_san_pham (
    id, product_id, sku_bien_the, size, mau, ton_kho_hien_tai, gia_nhap, gia_ban,
    hinh_anh_url, trang_thai, ghi_chu, ngay_tao, ngay_cap_nhat, is_deleted
)
VALUES
    ('variant-001', 'product-001', 'FB-001-42-XANH', '42', 'Xanh', 6, 850000, 1250000, NULL, 'Đang bán', '', '2026-04-18 08:40:00', '2026-04-18 08:40:00', 0),
    ('variant-002', 'product-001', 'FB-001-43-TRANGXANH', '43', 'Trắng xanh', 4, 850000, 1250000, NULL, 'Đang bán', '', '2026-04-18 08:41:00', '2026-04-18 08:41:00', 0),
    ('variant-003', 'product-002', 'FB-003-M-XANHDUONG', 'M', 'Xanh dương', 12, 300000, 550000, NULL, 'Đang bán', '', '2026-04-18 08:42:00', '2026-04-18 08:42:00', 0),
    ('variant-004', 'product-002', 'FB-003-L-XANHDUONG', 'L', 'Xanh dương', 13, 300000, 550000, NULL, 'Đang bán', '', '2026-04-18 08:43:00', '2026-04-18 08:43:00', 0),
    ('variant-005', 'product-003', 'BB-002-SO7-CAM', 'Số 7', 'Cam', 15, 400000, 650000, NULL, 'Đang bán', '', '2026-04-18 08:44:00', '2026-04-18 08:44:00', 0),
    ('variant-006', 'product-004', 'BM-001-4UG5-DENXANH', '4U-G5', 'Đen xanh', 8, 1200000, 1850000, NULL, 'Đang bán', '', '2026-04-18 08:45:00', '2026-04-18 08:45:00', 0),
    ('variant-007', 'product-005', 'VB-001-TIEUCHUAN-VANGXANH', 'Tiêu chuẩn', 'Vàng xanh', 18, 80000, 120000, NULL, 'Đang bán', '', '2026-04-18 08:46:00', '2026-04-18 08:46:00', 0),
    ('variant-008', 'product-005', 'VB-001-MEM-VANGXANH', 'Mềm', 'Vàng xanh', 12, 75000, 115000, NULL, 'Đang bán', '', '2026-04-18 08:47:00', '2026-04-18 08:47:00', 0),
    ('variant-009', 'product-006', 'TT-001-TIEUCHUAN-DODEN', 'Tiêu chuẩn', 'Đỏ đen', 10, 250000, 450000, NULL, 'Đang bán', '', '2026-04-18 08:48:00', '2026-04-18 08:48:00', 0)
ON DUPLICATE KEY UPDATE
    ton_kho_hien_tai = VALUES(ton_kho_hien_tai),
    gia_nhap = VALUES(gia_nhap),
    gia_ban = VALUES(gia_ban),
    trang_thai = VALUES(trang_thai),
    is_deleted = VALUES(is_deleted);

INSERT INTO tbl_gio_hang (
    id, user_id, customer_id, trang_thai, tong_san_pham, tong_tien_tam_tinh, ngay_tao, ngay_cap_nhat
)
VALUES
    ('cart-001', 'user-customer-001', 'customer-001', 'ACTIVE', 2, 2400000, '2026-04-18 08:50:00', '2026-04-18 08:55:00'),
    ('cart-002', 'user-customer-002', 'customer-002', 'ACTIVE', 1, 550000, '2026-04-18 08:51:00', '2026-04-18 08:56:00')
ON DUPLICATE KEY UPDATE
    tong_san_pham = VALUES(tong_san_pham),
    tong_tien_tam_tinh = VALUES(tong_tien_tam_tinh),
    trang_thai = VALUES(trang_thai);

INSERT INTO tbl_chi_tiet_gio_hang (
    id, cart_id, product_id, variant_id, so_luong, don_gia, thanh_tien, ngay_tao, ngay_cap_nhat
)
VALUES
    ('cart-item-001', 'cart-001', 'product-002', 'variant-003', 1, 550000, 550000, '2026-04-18 08:52:00', '2026-04-18 08:52:00'),
    ('cart-item-002', 'cart-001', 'product-004', 'variant-006', 1, 1850000, 1850000, '2026-04-18 08:53:00', '2026-04-18 08:53:00'),
    ('cart-item-003', 'cart-002', 'product-002', 'variant-004', 1, 550000, 550000, '2026-04-18 08:54:00', '2026-04-18 08:54:00')
ON DUPLICATE KEY UPDATE
    so_luong = VALUES(so_luong),
    don_gia = VALUES(don_gia),
    thanh_tien = VALUES(thanh_tien);

INSERT INTO tbl_don_hang (
    id, ma_don, ngay_dat, customer_id, user_id, nguoi_nhan, so_dien_thoai_giao,
    trang_thai_don, thanh_toan, da_thanh_toan, tong_tien, phi_ship, giam_gia,
    dia_chi_giao, ghi_chu, ngay_tao, ngay_cap_nhat, is_deleted
)
VALUES
    ('order-001', 'DH-20260418-0001', '2026-04-18', 'customer-001', 'user-customer-001', 'Nguyễn Văn A', '0901234567', 'Hoàn tất', 'Chuyển khoản', 1, 1590000, 30000, 50000, '123 Đường Lê Lợi, Quận 1, TP.HCM', 'Giao giờ hành chính', '2026-04-18 09:00:00', '2026-04-18 09:00:00', 0),
    ('order-002', 'DH-20260418-0002', '2026-04-18', 'customer-002', 'user-customer-002', 'Trần Thị B', '0987654321', 'Đang giao', 'COD', 0, 570000, 20000, 0, '456 Đường Nguyễn Huệ, Quận 2, TP.HCM', 'Gọi trước khi giao', '2026-04-18 09:10:00', '2026-04-18 09:10:00', 0),
    ('order-003', 'DH-20260418-0003', '2026-04-18', 'customer-003', NULL, 'Lê Văn C', '0911222333', 'Chờ xác nhận', 'Ví điện tử', 0, 650000, 25000, 25000, '789 Đường Trần Phú, Quận 3, TP.HCM', 'Đơn hàng khách lẻ', '2026-04-18 09:20:00', '2026-04-18 09:20:00', 0)
ON DUPLICATE KEY UPDATE
    customer_id = VALUES(customer_id),
    user_id = VALUES(user_id),
    nguoi_nhan = VALUES(nguoi_nhan),
    so_dien_thoai_giao = VALUES(so_dien_thoai_giao),
    trang_thai_don = VALUES(trang_thai_don),
    thanh_toan = VALUES(thanh_toan),
    da_thanh_toan = VALUES(da_thanh_toan),
    tong_tien = VALUES(tong_tien),
    phi_ship = VALUES(phi_ship),
    giam_gia = VALUES(giam_gia),
    dia_chi_giao = VALUES(dia_chi_giao),
    ghi_chu = VALUES(ghi_chu),
    is_deleted = VALUES(is_deleted);

INSERT INTO tbl_chi_tiet_don_hang (
    id, order_id, product_id, variant_id, ten_san_pham_snapshot, sku_snapshot,
    size_snapshot, mau_snapshot, so_luong, don_gia, thanh_tien, ngay_tao
)
VALUES
    ('order-item-001', 'order-001', 'product-001', 'variant-001', 'Giày bóng đá cỏ nhân tạo Nike', 'FB-001-42-XANH', '42', 'Xanh', 1, 1250000, 1250000, '2026-04-18 09:00:00'),
    ('order-item-002', 'order-001', 'product-005', 'variant-007', 'Bóng chuyền hơi Động Lực', 'VB-001-TIEUCHUAN-VANGXANH', 'Tiêu chuẩn', 'Vàng xanh', 3, 120000, 360000, '2026-04-18 09:00:00'),
    ('order-item-003', 'order-002', 'product-002', 'variant-004', 'Áo đấu CLB Manchester City 2024', 'FB-003-L-XANHDUONG', 'L', 'Xanh dương', 1, 550000, 550000, '2026-04-18 09:10:00'),
    ('order-item-004', 'order-003', 'product-003', 'variant-005', 'Bóng rổ Spalding NBA', 'BB-002-SO7-CAM', 'Số 7', 'Cam', 1, 650000, 650000, '2026-04-18 09:20:00')
ON DUPLICATE KEY UPDATE
    so_luong = VALUES(so_luong),
    don_gia = VALUES(don_gia),
    thanh_tien = VALUES(thanh_tien);

INSERT INTO tbl_thanh_toan (
    id, order_id, ma_giao_dich_truy_xuat, phuong_thuc, so_tien, trang_thai,
    nha_cung_cap, raw_response_json, thanh_toan_luc, ghi_chu, ngay_tao, ngay_cap_nhat
)
VALUES
    ('payment-001', 'order-001', 'TXN-DH-20260418-0001', 'Chuyển khoản', 1590000, 'Thành công', 'Vietcombank', JSON_OBJECT('status', 'success', 'bank', 'VCB'), '2026-04-18 09:02:00', 'Thanh toán đã đối soát', '2026-04-18 09:02:00', '2026-04-18 09:02:00'),
    ('payment-002', 'order-002', 'COD-DH-20260418-0002', 'COD', 570000, 'Chờ thu hộ', 'Nội bộ', JSON_OBJECT('status', 'pending', 'provider', 'COD'), NULL, 'Thu tiền khi giao hàng', '2026-04-18 09:11:00', '2026-04-18 09:11:00'),
    ('payment-003', 'order-003', 'MOMO-DH-20260418-0003', 'Ví điện tử', 650000, 'Khởi tạo', 'MoMo', JSON_OBJECT('status', 'created', 'provider', 'MoMo'), NULL, 'Chờ khách xác nhận thanh toán', '2026-04-18 09:21:00', '2026-04-18 09:21:00')
ON DUPLICATE KEY UPDATE
    so_tien = VALUES(so_tien),
    trang_thai = VALUES(trang_thai),
    nha_cung_cap = VALUES(nha_cung_cap),
    thanh_toan_luc = VALUES(thanh_toan_luc),
    ghi_chu = VALUES(ghi_chu);

INSERT INTO tbl_san_pham (
    id, ten_san_pham, sku, danh_muc, thuong_hieu, size, mau, gia_nhap, gia_ban,
    ton_kho, trang_thai, link_san_pham, hinh_anh_url, mo_ta_ngan, ghi_chu, ngay_tao, ngay_cap_nhat, is_deleted
)
VALUES
    ('product-140', 'Nike Pegasus 41', 'RUN-001', 'Chạy bộ', 'Nike', '40-44', 'Xanh dương / Trắng', 2490000, 3490000, 12, 'Đang bán', '', '', 'Mẫu giày chạy bộ road running thuộc dòng Pegasus 41 của Nike, phù hợp cho chạy hằng ngày với độ đàn hồi cân bằng và cảm giác ổn định.', 'Nguồn tham chiếu: Nike official - Pegasus 41.', '2026-04-23 08:00:00', '2026-04-23 08:00:00', 0),
    ('product-141', 'Nike Vomero 18', 'RUN-002', 'Chạy bộ', 'Nike', '40-44', 'Trắng / Xanh navy', 2790000, 3790000, 9, 'Đang bán', '', '', 'Giày road running thiên về êm ái thuộc dòng Vomero 18, phù hợp cho runner cần đệm dày và cảm giác mềm khi chạy quãng đường dài.', 'Nguồn tham chiếu: Nike official - Vomero 18.', '2026-04-23 08:01:00', '2026-04-23 08:01:00', 0),
    ('product-142', 'ASICS GEL-NIMBUS 27', 'RUN-003', 'Chạy bộ', 'ASICS', '40-44', 'Trắng / Bạc', 2650000, 3650000, 8, 'Đang bán', '', '', 'Mẫu giày chạy bộ cao cấp GEL-NIMBUS 27 của ASICS nổi bật với đệm êm, phù hợp cho chạy daily training và recovery run.', 'Nguồn tham chiếu: ASICS official - GEL-NIMBUS 27.', '2026-04-23 08:02:00', '2026-04-23 08:02:00', 0),
    ('product-143', 'ASICS GEL-KAYANO 31', 'RUN-004', 'Chạy bộ', 'ASICS', '40-44', 'Đen / Xanh ngọc', 2890000, 3990000, 7, 'Đang bán', '', '', 'GEL-KAYANO 31 là dòng stability running shoe của ASICS, phù hợp với runner cần hỗ trợ tốt hơn cho những buổi chạy hằng ngày.', 'Nguồn tham chiếu: ASICS official - GEL-KAYANO 31.', '2026-04-23 08:03:00', '2026-04-23 08:03:00', 0),
    ('product-144', 'Nike Miler Men''s Dri-FIT Short-Sleeve Running Top', 'RUN-005', 'Chạy bộ', 'Nike', 'M-L', 'Xám / Đen', 690000, 990000, 15, 'Đang bán', '', '', 'Áo chạy bộ tay ngắn Nike Miler dùng chất liệu Dri-FIT, thoáng khí và phù hợp cho các buổi chạy hằng ngày trong thời tiết nóng.', 'Nguồn tham chiếu: Nike official - Miler Running Top.', '2026-04-23 08:04:00', '2026-04-23 08:04:00', 0),
    ('product-145', 'Nike Stride Men''s Dri-FIT 7 inch 2-in-1 Running Shorts', 'RUN-006', 'Chạy bộ', 'Nike', 'M-L', 'Đen', 790000, 1090000, 14, 'Đang bán', '', '', 'Quần chạy bộ 2 trong 1 Nike Stride dài 7 inch, tối ưu cho vận động linh hoạt và kiểm soát mồ hôi trong các buổi chạy cường độ vừa.', 'Nguồn tham chiếu: Nike official - Stride Running Shorts.', '2026-04-23 08:05:00', '2026-04-23 08:05:00', 0),
    ('product-146', 'ASICS ROAD PACKABLE JACKET', 'RUN-007', 'Chạy bộ', 'ASICS', 'M-L', 'Xanh navy', 1390000, 1890000, 10, 'Đang bán', '', '', 'Áo khoác chạy bộ ROAD PACKABLE JACKET của ASICS có thể gấp gọn, phù hợp cho runner cần lớp ngoài nhẹ khi thời tiết thay đổi.', 'Nguồn tham chiếu: ASICS official - ROAD PACKABLE JACKET.', '2026-04-23 08:06:00', '2026-04-23 08:06:00', 0),
    ('product-147', 'Nike Metcon 9', 'GYM-001', 'Tập gym', 'Nike', '40-44', 'Đen / Trắng', 3190000, 4290000, 8, 'Đang bán', '', '', 'Nike Metcon 9 là mẫu giày workout chuyên cho tập gym, hỗ trợ các bài sức mạnh, conditioning và bài tập toàn thân trong phòng tập.', 'Nguồn tham chiếu: Nike official - Metcon 9.', '2026-04-23 08:07:00', '2026-04-23 08:07:00', 0),
    ('product-148', 'Nike Free Metcon 6', 'GYM-002', 'Tập gym', 'Nike', '40-44', 'Trắng / Xám', 2590000, 3590000, 9, 'Đang bán', '', '', 'Free Metcon 6 kết hợp độ linh hoạt của Nike Free với sự ổn định cho tập gym, phù hợp cho circuit training và bài tập cường độ cao.', 'Nguồn tham chiếu: Nike official - Free Metcon 6.', '2026-04-23 08:08:00', '2026-04-23 08:08:00', 0),
    ('product-149', 'Nike Dri-FIT Primary Men''s Training T-Shirt', 'GYM-003', 'Tập gym', 'Nike', 'M-L', 'Xanh rêu', 690000, 950000, 16, 'Đang bán', '', '', 'Áo tập gym Nike Dri-FIT Primary là lựa chọn cơ bản cho các buổi workout nhờ chất vải thấm hút tốt và phom dễ vận động.', 'Nguồn tham chiếu: Nike official - Dri-FIT Primary Training T-Shirt.', '2026-04-23 08:09:00', '2026-04-23 08:09:00', 0),
    ('product-150', 'Nike Pro Men''s Dri-FIT Fitness Tights', 'GYM-004', 'Tập gym', 'Nike', 'M-L', 'Đen', 790000, 1090000, 12, 'Đang bán', '', '', 'Quần tights Nike Pro Dri-FIT phù hợp cho squat, deadlift và các bài tập cường độ cao, hỗ trợ ôm cơ và thoát mồ hôi.', 'Nguồn tham chiếu: Nike official - Pro Fitness Tights.', '2026-04-23 08:10:00', '2026-04-23 08:10:00', 0),
    ('product-151', 'Nike Brasilia 9.5 Training Duffel Bag (Medium, 60L)', 'GYM-005', 'Tập gym', 'Nike', '60L', 'Đen / Trắng', 790000, 1090000, 11, 'Đang bán', '', '', 'Túi tập Nike Brasilia 9.5 dung tích 60L phù hợp mang giày, quần áo tập và phụ kiện cho lịch tập gym hằng ngày.', 'Nguồn tham chiếu: Nike official - Brasilia 9.5 Training Duffel Bag.', '2026-04-23 08:11:00', '2026-04-23 08:11:00', 0),
    ('product-152', 'Nike Brasilia 9.5 Training Backpack (Medium, 24L)', 'GYM-006', 'Tập gym', 'Nike', '24L', 'Đen / Trắng', 690000, 950000, 13, 'Đang bán', '', '', 'Balo Nike Brasilia 9.5 Training Backpack thích hợp cho người tập gym cần mang laptop, bình nước và quần áo tập trong một ngày.', 'Nguồn tham chiếu: Nike official - Brasilia 9.5 Training Backpack.', '2026-04-23 08:12:00', '2026-04-23 08:12:00', 0)
ON DUPLICATE KEY UPDATE
    ten_san_pham = VALUES(ten_san_pham),
    danh_muc = VALUES(danh_muc),
    thuong_hieu = VALUES(thuong_hieu),
    size = VALUES(size),
    mau = VALUES(mau),
    gia_nhap = VALUES(gia_nhap),
    gia_ban = VALUES(gia_ban),
    ton_kho = VALUES(ton_kho),
    trang_thai = VALUES(trang_thai),
    link_san_pham = VALUES(link_san_pham),
    hinh_anh_url = VALUES(hinh_anh_url),
    mo_ta_ngan = VALUES(mo_ta_ngan),
    ghi_chu = VALUES(ghi_chu),
    ngay_cap_nhat = VALUES(ngay_cap_nhat),
    is_deleted = VALUES(is_deleted);

