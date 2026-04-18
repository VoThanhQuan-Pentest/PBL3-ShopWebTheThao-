
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
    ('user-admin-001', 'admin', 'admin123', 'Quản trị viên', 'Hệ Thống', 'admin@flarefitness.com', NULL, 'Đang hoạt động', NULL, '2026-04-18 08:00:00', '2026-04-18 08:00:00', 0),
    ('user-staff-001', 'nhanvien01', 'password123', 'Nhân viên', 'Nguyễn Nhân Viên', 'nv01@flarefitness.com', NULL, 'Đang hoạt động', NULL, '2026-04-18 08:05:00', '2026-04-18 08:05:00', 0),
    ('user-customer-001', 'khachhang01', 'user123', 'Khách hàng', 'Nguyễn Văn A', 'nguyenvana@email.com', NULL, 'Đang hoạt động', NULL, '2026-04-18 08:10:00', '2026-04-18 08:10:00', 0),
    ('user-customer-002', 'khachhang02', 'user456', 'Khách hàng', 'Trần Thị B', 'tranthib@email.com', NULL, 'Đang hoạt động', NULL, '2026-04-18 08:12:00', '2026-04-18 08:12:00', 0)
ON DUPLICATE KEY UPDATE
    password = VALUES(password),
    role = VALUES(role),
    ho_ten = VALUES(ho_ten),
    email = VALUES(email),
    trang_thai = VALUES(trang_thai),
    is_deleted = VALUES(is_deleted);

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
