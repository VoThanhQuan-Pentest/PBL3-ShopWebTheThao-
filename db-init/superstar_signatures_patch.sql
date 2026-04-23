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
