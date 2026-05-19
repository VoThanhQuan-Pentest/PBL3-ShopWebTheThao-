-- Reset demo revenue without deleting audit data.
UPDATE tbl_don_hang
SET is_deleted = 1,
    ngay_cap_nhat = NOW(),
    ghi_chu = CONCAT(COALESCE(NULLIF(ghi_chu, ''), 'Reset demo'), ' | Soft reset revenue/bestseller data')
WHERE customer_id IN ('customer-001', 'customer-002')
   OR user_id IN ('user-customer-001', 'user-customer-002');

UPDATE tbl_thanh_toan
SET trang_thai = 'Khong ghi nhan',
    ngay_cap_nhat = NOW(),
    ghi_chu = CONCAT(COALESCE(NULLIF(ghi_chu, ''), 'Reset demo'), ' | Soft reset revenue data')
WHERE order_id IN (
    SELECT id
    FROM tbl_don_hang
    WHERE customer_id IN ('customer-001', 'customer-002')
       OR user_id IN ('user-customer-001', 'user-customer-002')
);

UPDATE tbl_khach_hang
SET tong_chi_tieu = 0,
    ngay_cap_nhat = NOW()
WHERE id IN ('customer-001', 'customer-002')
   OR user_id IN ('user-customer-001', 'user-customer-002');

UPDATE tbl_luot_nhan_khuyen_mai
SET is_deleted = 1,
    trang_thai = 'RESET',
    ngay_cap_nhat = NOW();

UPDATE tbl_sync_state
SET payload = CASE
        WHEN state_key = 'voucher-assignments' THEN '{}'
        WHEN state_key = 'promo-hunt-claims' THEN '{}'
        ELSE payload
    END,
    ngay_cap_nhat = NOW()
WHERE state_key IN ('voucher-assignments', 'promo-hunt-claims');
