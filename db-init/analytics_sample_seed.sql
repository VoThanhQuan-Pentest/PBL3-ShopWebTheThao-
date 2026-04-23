DELETE FROM tbl_ho_so_hanh_vi_nguoi_dung;
DELETE FROM tbl_su_kien_hanh_vi_nguoi_dung;

INSERT INTO tbl_su_kien_hanh_vi_nguoi_dung (
    id, user_id, session_id, event_type, page_type, page_key, product_id, order_id,
    category_key, brand_key, search_keyword, price_bucket, price_value, quantity,
    duration_seconds, metadata_json, ngay_tao
)
VALUES
    (
        'behavior-event-001', 'user-customer-001', 'sample-session-001', 'CATEGORY_CLICK', 'CATALOG', 'menu:football-shoes', '',
        '', 'Bóng đá', 'adidas', '', '1-3 triệu', 1980000, NULL,
        NULL, JSON_OBJECT('source', 'sample-seed'), '2026-04-22 08:55:00'
    ),
    (
        'behavior-event-002', 'user-customer-001', 'sample-session-001', 'PRODUCT_SEARCH', 'SEARCH_RESULTS', 'search:giay-bong-da', '',
        '', 'Bóng đá', '', 'giày bóng đá', '1-3 triệu', 1980000, NULL,
        NULL, JSON_OBJECT('source', 'sample-seed'), '2026-04-22 08:57:00'
    ),
    (
        'behavior-event-003', 'user-customer-001', 'sample-session-001', 'PRODUCT_VIEW', 'PRODUCT_DETAIL', 'product:product-010', 'product-010',
        '', 'Bóng đá', 'adidas', '', '1-3 triệu', 1980000, NULL,
        NULL, JSON_OBJECT('sku', 'FB-010'), '2026-04-22 09:00:00'
    ),
    (
        'behavior-event-004', 'user-customer-001', 'sample-session-001', 'ADD_TO_CART', 'PRODUCT_DETAIL', 'product:product-010', 'product-010',
        '', 'Bóng đá', 'adidas', '', '1-3 triệu', 1980000, 1,
        NULL, JSON_OBJECT('sku', 'FB-010'), '2026-04-22 09:03:00'
    ),
    (
        'behavior-event-005', 'user-customer-001', 'sample-session-001', 'PRODUCT_VIEW', 'PRODUCT_DETAIL', 'product:product-109', 'product-109',
        '', 'Bóng chuyền', 'Mikasa', '', '1-3 triệu', 1180000, NULL,
        NULL, JSON_OBJECT('sku', 'VB-022'), '2026-04-22 09:05:00'
    ),
    (
        'behavior-event-006', 'user-customer-001', 'sample-session-001', 'PAGE_STAY', 'PRODUCT_DETAIL', 'product:product-010', 'product-010',
        '', 'Bóng đá', 'adidas', '', '1-3 triệu', 1980000, NULL,
        28, JSON_OBJECT('source', 'sample-seed'), '2026-04-22 09:06:00'
    ),
    (
        'behavior-event-007', 'user-customer-001', 'sample-session-001', 'PURCHASE', 'CHECKOUT', 'checkout', 'product-010',
        'sample-order-001', 'Bóng đá', 'adidas', '', '1-3 triệu', 1980000, 1,
        NULL, JSON_OBJECT('orderCode', 'DH-20260423-1001'), '2026-04-22 09:15:00'
    ),
    (
        'behavior-event-008', 'user-customer-001', 'sample-session-001', 'PURCHASE', 'CHECKOUT', 'checkout', 'product-109',
        'sample-order-001', 'Bóng chuyền', 'Mikasa', '', '1-3 triệu', 1180000, 1,
        NULL, JSON_OBJECT('orderCode', 'DH-20260423-1001'), '2026-04-22 09:15:00'
    ),
    (
        'behavior-event-009', 'user-customer-002', 'sample-session-002', 'PRODUCT_SEARCH', 'SEARCH_RESULTS', 'search:giay-chay-bo', '',
        '', 'Chạy bộ', 'Nike', 'giày chạy bộ', '3-5 triệu', 3490000, NULL,
        NULL, JSON_OBJECT('source', 'sample-seed'), '2026-04-22 14:10:00'
    ),
    (
        'behavior-event-010', 'user-customer-002', 'sample-session-002', 'CATEGORY_CLICK', 'COLLECTION', 'category:running', '',
        '', 'Chạy bộ', 'Nike', '', '3-5 triệu', 3490000, NULL,
        NULL, JSON_OBJECT('source', 'sample-seed'), '2026-04-22 14:12:00'
    ),
    (
        'behavior-event-011', 'user-customer-002', 'sample-session-002', 'PRODUCT_VIEW', 'PRODUCT_DETAIL', 'product:product-140', 'product-140',
        '', 'Chạy bộ', 'Nike', '', '3-5 triệu', 3490000, NULL,
        NULL, JSON_OBJECT('sku', 'RUN-001'), '2026-04-22 14:15:00'
    ),
    (
        'behavior-event-012', 'user-customer-002', 'sample-session-002', 'ADD_TO_CART', 'PRODUCT_DETAIL', 'product:product-140', 'product-140',
        '', 'Chạy bộ', 'Nike', '', '3-5 triệu', 3490000, 1,
        NULL, JSON_OBJECT('sku', 'RUN-001'), '2026-04-22 14:18:00'
    ),
    (
        'behavior-event-013', 'user-customer-002', 'sample-session-002', 'PRODUCT_VIEW', 'PRODUCT_DETAIL', 'product:product-149', 'product-149',
        '', 'Tập gym', 'Nike', '', '0-1 triệu', 950000, NULL,
        NULL, JSON_OBJECT('sku', 'GYM-003'), '2026-04-22 14:20:00'
    ),
    (
        'behavior-event-014', 'user-customer-002', 'sample-session-002', 'ADD_TO_CART', 'PRODUCT_DETAIL', 'product:product-149', 'product-149',
        '', 'Tập gym', 'Nike', '', '0-1 triệu', 950000, 2,
        NULL, JSON_OBJECT('sku', 'GYM-003'), '2026-04-22 14:22:00'
    ),
    (
        'behavior-event-015', 'user-customer-002', 'sample-session-002', 'PAGE_STAY', 'SEARCH_RESULTS', 'search:giay-chay-bo', '',
        '', 'Chạy bộ', 'Nike', 'giày chạy bộ', '3-5 triệu', 3490000, NULL,
        35, JSON_OBJECT('source', 'sample-seed'), '2026-04-22 14:24:00'
    ),
    (
        'behavior-event-016', 'user-customer-002', 'sample-session-002', 'PRODUCT_REVIEW', 'PRODUCT_DETAIL', 'product:product-140', 'product-140',
        '', 'Chạy bộ', 'Nike', '', '3-5 triệu', 3490000, NULL,
        NULL, JSON_OBJECT('rating', 5), '2026-04-22 14:27:00'
    ),
    (
        'behavior-event-017', 'user-customer-002', 'sample-session-002', 'PURCHASE', 'CHECKOUT', 'checkout', 'product-140',
        'sample-order-002', 'Chạy bộ', 'Nike', '', '3-5 triệu', 3490000, 1,
        NULL, JSON_OBJECT('orderCode', 'DH-20260423-1002'), '2026-04-22 14:30:00'
    ),
    (
        'behavior-event-018', 'user-customer-002', 'sample-session-002', 'PURCHASE', 'CHECKOUT', 'checkout', 'product-149',
        'sample-order-002', 'Tập gym', 'Nike', '', '0-1 triệu', 950000, 2,
        NULL, JSON_OBJECT('orderCode', 'DH-20260423-1002'), '2026-04-22 14:30:00'
    );
