DELETE FROM tbl_thanh_toan;
DELETE FROM tbl_chi_tiet_don_hang;
DELETE FROM tbl_don_hang;

UPDATE tbl_khach_hang
SET tong_chi_tieu = 0;

INSERT INTO tbl_don_hang (
    id, ma_don, ngay_dat, customer_id, user_id, nguoi_nhan, so_dien_thoai_giao,
    trang_thai_don, thanh_toan, da_thanh_toan, tong_tien, phi_ship, giam_gia,
    dia_chi_giao, ghi_chu, ngay_tao, ngay_cap_nhat, is_deleted
)
VALUES
    (
        'sample-order-001', 'DH-20260423-1001', '2026-04-22', 'customer-001', 'user-customer-001',
        'Nguyen Van A', '0901234567', 'Da giao', 'COD', 1, 3160000, 0, 0,
        '123 Le Loi, Phuong Hai Chau, Da Nang', 'Don mau giao thanh cong',
        '2026-04-22 09:15:00', '2026-04-22 09:15:00', 0
    ),
    (
        'sample-order-002', 'DH-20260423-1002', '2026-04-22', 'customer-002', 'user-customer-002',
        'Tran Thi B', '0987654321', 'Da xac nhan', 'COD', 0, 5390000, 0, 0,
        '456 Nguyen Van Linh, Phuong Thanh Khe, Da Nang', 'Don mau da xac nhan',
        '2026-04-22 14:30:00', '2026-04-22 14:30:00', 0
    ),
    (
        'sample-order-003', 'DH-20260423-1003', '2026-04-23', 'customer-001', 'user-customer-001',
        'Nguyen Van A', '0901234567', 'Da huy', 'Vi dien tu', 0, 2050000, 0, 0,
        '123 Le Loi, Phuong Hai Chau, Da Nang', 'Don mau bi huy de doi chieu thong ke',
        '2026-04-23 08:00:00', '2026-04-23 08:00:00', 0
    );

INSERT INTO tbl_chi_tiet_don_hang (
    id, order_id, product_id, variant_id, ten_san_pham_snapshot, sku_snapshot,
    size_snapshot, mau_snapshot, so_luong, don_gia, thanh_tien, ngay_tao
)
VALUES
    (
        'sample-order-item-001', 'sample-order-001', 'product-010', NULL,
        'Giay bong da adidas Predator League Turf', 'FB-010', '42', 'Do / Den',
        1, 1980000, 1980000, '2026-04-22 09:15:00'
    ),
    (
        'sample-order-item-002', 'sample-order-001', 'product-109', NULL,
        'Mikasa V390W', 'VB-022', 'So 5', 'Vang / Xanh',
        1, 1180000, 1180000, '2026-04-22 09:15:00'
    ),
    (
        'sample-order-item-003', 'sample-order-002', 'product-140', NULL,
        'Nike Pegasus 41', 'RUN-001', '42', 'Xanh duong / Trang',
        1, 3490000, 3490000, '2026-04-22 14:30:00'
    ),
    (
        'sample-order-item-004', 'sample-order-002', 'product-149', NULL,
        'Nike Dri-FIT Primary Men''s Training T-Shirt', 'GYM-003', 'L', 'Xanh reu',
        2, 950000, 1900000, '2026-04-22 14:30:00'
    ),
    (
        'sample-order-item-005', 'sample-order-003', 'product-111', NULL,
        'Yonex Astrox 77 Play', 'BM-022', '4U-G5', 'High Orange',
        1, 2050000, 2050000, '2026-04-23 08:00:00'
    );

INSERT INTO tbl_thanh_toan (
    id, order_id, ma_giao_dich_truy_xuat, phuong_thuc, so_tien, trang_thai,
    nha_cung_cap, raw_response_json, thanh_toan_luc, ghi_chu, ngay_tao, ngay_cap_nhat
)
VALUES
    (
        'sample-payment-001', 'sample-order-001', 'COD-DH-20260423-1001', 'COD', 3160000, 'Thanh cong',
        'Noi bo', NULL, '2026-04-22 09:17:00', 'Nhan vien da xac nhan thu tien COD',
        '2026-04-22 09:17:00', '2026-04-22 09:17:00'
    ),
    (
        'sample-payment-002', 'sample-order-002', 'COD-DH-20260423-1002', 'COD', 5390000, 'Cho thu tien',
        'Noi bo', NULL, NULL, 'Cho giao hang va thu tien tu nguoi nhan',
        '2026-04-22 14:32:00', '2026-04-22 14:32:00'
    ),
    (
        'sample-payment-003', 'sample-order-003', 'EWALLET-DH-20260423-1003', 'Vi dien tu', 2050000, 'Da huy',
        'MoMo', NULL, NULL, 'Don huy, khong ghi nhan doanh thu',
        '2026-04-23 08:02:00', '2026-04-23 08:02:00'
    );

UPDATE tbl_khach_hang
SET tong_chi_tieu = CASE id
    WHEN 'customer-001' THEN 3160000
    WHEN 'customer-002' THEN 0
    ELSE 0
END
WHERE id IN ('customer-001', 'customer-002', 'customer-003');
