USE flare_fitness;

INSERT INTO tbl_san_pham (
    id, ten_san_pham, sku, danh_muc, thuong_hieu, size, mau,
    gia_nhap, gia_ban, ton_kho, trang_thai, link_san_pham, hinh_anh_url,
    mo_ta_ngan, ghi_chu, ngay_tao, ngay_cap_nhat, is_deleted
)
VALUES
    ('product-112', 'Nike Strike Knee-High Soccer Socks', 'FB-028', 'Bóng đá', 'Nike', 'M-L', 'Trắng / Đen', 180000, 290000, 18, 'Đang bán', '', '/assets/images/catalog/football.svg', 'Dòng tất bóng đá cổ cao thuộc line Nike Strike, phù hợp đá sân cỏ nhân tạo và sân 7.', 'Bổ sung nhóm tất bóng đá trong danh mục phụ kiện.', '2026-04-20 09:00:00', '2026-04-20 09:00:00', 0),
    ('product-113', 'adidas Milano 23 Socks', 'FB-029', 'Bóng đá', 'adidas', 'M-L', 'Xanh navy / Trắng', 170000, 280000, 16, 'Đang bán', '', '/assets/images/catalog/football.svg', 'Mẫu tất bóng đá phổ biến của adidas cho cầu thủ phong trào và đội nhóm.', 'Bổ sung nhóm tất bóng đá trong danh mục phụ kiện.', '2026-04-20 09:01:00', '2026-04-20 09:01:00', 0),
    ('product-114', 'Nike Fundamental Towel Large', 'FB-030', 'Bóng đá', 'Nike', 'Large', 'Đen / Trắng', 210000, 340000, 12, 'Đang bán', '', '/assets/images/catalog/football.svg', 'Khăn thể thao cỡ lớn phù hợp mang theo khi tập bóng đá, gym hoặc chạy bộ.', 'Bổ sung nhóm khăn lau cho bóng đá.', '2026-04-20 09:02:00', '2026-04-20 09:02:00', 0),
    ('product-115', 'adidas Sports Towel Small', 'FB-031', 'Bóng đá', 'adidas', 'Small', 'Trắng / Đỏ', 150000, 250000, 14, 'Đang bán', '', '/assets/images/catalog/football.svg', 'Khăn thể thao cỡ nhỏ của adidas dùng tốt cho tập luyện và thi đấu phong trào.', 'Bổ sung nhóm khăn lau cho bóng đá.', '2026-04-20 09:03:00', '2026-04-20 09:03:00', 0),
    ('product-116', 'Mizuno Performance Plus Volleyball Crew Socks', 'VB-023', 'Bóng chuyền', 'Mizuno', 'M-L', 'Trắng / Xanh', 190000, 320000, 15, 'Đang bán', '', '/assets/images/catalog/volleyball.svg', 'Mẫu tất thể thao cổ crew của Mizuno phù hợp cho người chơi bóng chuyền indoor.', 'Bổ sung nhóm tất bóng chuyền trong danh mục phụ kiện.', '2026-04-20 09:04:00', '2026-04-20 09:04:00', 0),
    ('product-117', 'Nike Everyday Plus Cushioned Crew Socks', 'VB-024', 'Bóng chuyền', 'Nike', 'M-L', 'Đen / Trắng', 175000, 290000, 18, 'Đang bán', '', '/assets/images/catalog/volleyball.svg', 'Tất crew đệm dày, phù hợp mang cùng giày bóng chuyền và các môn sân trong nhà.', 'Bổ sung nhóm tất bóng chuyền trong danh mục phụ kiện.', '2026-04-20 09:05:00', '2026-04-20 09:05:00', 0),
    ('product-118', 'Mizuno Sports Towel', 'VB-025', 'Bóng chuyền', 'Mizuno', 'Medium', 'Xanh navy', 185000, 310000, 10, 'Đang bán', '', '/assets/images/catalog/volleyball.svg', 'Khăn thể thao của Mizuno phù hợp cho người chơi bóng chuyền, cầu lông và gym.', 'Bổ sung nhóm khăn lau cho bóng chuyền.', '2026-04-20 09:06:00', '2026-04-20 09:06:00', 0),
    ('product-119', 'ASICS Sports Towel', 'VB-026', 'Bóng chuyền', 'ASICS', 'Medium', 'Trắng / Xanh', 180000, 300000, 11, 'Đang bán', '', '/assets/images/catalog/volleyball.svg', 'Khăn lau tập luyện cỡ vừa, phù hợp cho vận động viên chơi bóng chuyền trong nhà.', 'Bổ sung nhóm khăn lau cho bóng chuyền.', '2026-04-20 09:07:00', '2026-04-20 09:07:00', 0),
    ('product-120', 'Mizuno Team Backpack 23', 'VB-027', 'Bóng chuyền', 'Mizuno', '23L', 'Đen / Xanh', 520000, 820000, 9, 'Đang bán', '', '/assets/images/catalog/volleyball.svg', 'Balo thể thao của Mizuno có ngăn chứa đồ tập, giày và phụ kiện sân trong nhà.', 'Bổ sung nhóm balo thể thao cho bóng chuyền.', '2026-04-20 09:08:00', '2026-04-20 09:08:00', 0),
    ('product-121', 'Nike Brasilia 9.5 Training Backpack', 'VB-028', 'Bóng chuyền', 'Nike', '24L', 'Đen', 560000, 890000, 13, 'Đang bán', '', '/assets/images/catalog/volleyball.svg', 'Balo training đa năng của Nike, phù hợp mang đi tập bóng chuyền và các môn indoor court.', 'Bổ sung nhóm balo thể thao cho bóng chuyền.', '2026-04-20 09:09:00', '2026-04-20 09:09:00', 0),
    ('product-122', 'Jordan Jumpman Sport Towel', 'BB-024', 'Bóng rổ', 'Jordan', 'Medium', 'Đen / Đỏ', 220000, 360000, 10, 'Đang bán', '', '/assets/images/catalog/basketball.svg', 'Khăn thể thao phong cách basketball, phù hợp sử dụng trong luyện tập và thi đấu bóng rổ.', 'Bổ sung nhóm khăn lau cho bóng rổ.', '2026-04-20 09:10:00', '2026-04-20 09:10:00', 0),
    ('product-123', 'Under Armour Performance Towel', 'BB-025', 'Bóng rổ', 'Under Armour', 'Medium', 'Xám / Đen', 210000, 350000, 12, 'Đang bán', '', '/assets/images/catalog/basketball.svg', 'Khăn thể thao đa dụng phù hợp cho người chơi bóng rổ tập sân trong nhà và ngoài trời.', 'Bổ sung nhóm khăn lau cho bóng rổ.', '2026-04-20 09:11:00', '2026-04-20 09:11:00', 0),
    ('product-124', 'Butterfly Selasia Shirt', 'TT-028', 'Bóng bàn', 'Butterfly', 'M-L', 'Đen / Xanh', 720000, 1140000, 8, 'Đang bán', '', '/assets/images/catalog/table-tennis.svg', 'Áo thi đấu bóng bàn của Butterfly phù hợp cho CLB, giải phong trào và thi đấu đội nhóm.', 'Bổ sung nhóm trang phục cho bóng bàn.', '2026-04-20 09:12:00', '2026-04-20 09:12:00', 0),
    ('product-125', 'JOOLA Centrela Polo Shirt', 'TT-029', 'Bóng bàn', 'JOOLA', 'M-L', 'Black / Blue', 650000, 990000, 9, 'Đang bán', '', '/assets/images/catalog/table-tennis.svg', 'Áo polo bóng bàn của JOOLA dùng tốt cho tập luyện, thi đấu CLB và đồng phục đội.', 'Bổ sung nhóm trang phục cho bóng bàn.', '2026-04-20 09:13:00', '2026-04-20 09:13:00', 0),
    ('product-126', 'Yonex Crew Neck Shirt 10627', 'BM-023', 'Cầu lông', 'Yonex', 'M-L', 'White / Clear Mint', 890000, 1390000, 10, 'Đang bán', '', '/assets/images/catalog/badminton.svg', 'Áo cầu lông chính hãng thuộc line Crew Neck Shirt của Yonex, phù hợp tập luyện và thi đấu.', 'Bổ sung nhóm trang phục cho cầu lông.', '2026-04-20 09:14:00', '2026-04-20 09:14:00', 0),
    ('product-127', 'VICTOR Knitted Shorts R-3096 A', 'BM-024', 'Cầu lông', 'Victor', 'M-L', 'White', 520000, 820000, 9, 'Đang bán', '', '/assets/images/catalog/badminton.svg', 'Quần shorts thể thao của Victor dành cho người chơi cầu lông, mặc nhẹ và khô nhanh.', 'Bổ sung nhóm trang phục cho cầu lông.', '2026-04-20 09:15:00', '2026-04-20 09:15:00', 0)
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
    hinh_anh_url = VALUES(hinh_anh_url),
    mo_ta_ngan = VALUES(mo_ta_ngan),
    ghi_chu = VALUES(ghi_chu),
    is_deleted = VALUES(is_deleted);
