-- Auto-generated from Front end/assets/images/products SKU folders.
-- The first image in each SKU folder is used as the product card/main image.
-- Descriptive image file names are mapped to product variant labels for non-signature products.
USE flare_fitness;

ALTER TABLE tbl_san_pham MODIFY hinh_anh_url VARCHAR(1500) NULL;
ALTER TABLE tbl_bien_the_san_pham MODIFY hinh_anh_url VARCHAR(1500) NULL;

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-ban/TT-001/1.jpg|./assets/images/products/Bong-ban/TT-001/2.jpg|./assets/images/products/Bong-ban/TT-001/3.jpg'
WHERE sku = 'TT-001';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-ban/TT-007/Red.jpg|./assets/images/products/Bong-ban/TT-007/Red2.jpg|./assets/images/products/Bong-ban/TT-007/Red3.webp',
    mau = 'Đỏ'
WHERE sku = 'TT-007';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-ban/TT-008/Red.jpg|./assets/images/products/Bong-ban/TT-008/Red2.jpg|./assets/images/products/Bong-ban/TT-008/Red3.jpg',
    mau = 'Đỏ'
WHERE sku = 'TT-008';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-ban/TT-009/Red.jpeg|./assets/images/products/Bong-ban/TT-009/Red2.png|./assets/images/products/Bong-ban/TT-009/Red3.jpg',
    mau = 'Đỏ'
WHERE sku = 'TT-009';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-ban/TT-010/Red.jpg|./assets/images/products/Bong-ban/TT-010/Red2.jpg|./assets/images/products/Bong-ban/TT-010/Red3.jpg',
    mau = 'Đỏ'
WHERE sku = 'TT-010';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-ban/TT-011/Black.jpg|./assets/images/products/Bong-ban/TT-011/Red.jpg|./assets/images/products/Bong-ban/TT-011/Red2.jpg',
    mau = 'Đen|Đỏ'
WHERE sku = 'TT-011';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-ban/TT-012/Red.jpg|./assets/images/products/Bong-ban/TT-012/Red2.jpg|./assets/images/products/Bong-ban/TT-012/Red3.jpg',
    mau = 'Đỏ'
WHERE sku = 'TT-012';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-ban/TT-013/Red.jpg|./assets/images/products/Bong-ban/TT-013/Red2.jpg|./assets/images/products/Bong-ban/TT-013/Red3.png',
    mau = 'Đỏ'
WHERE sku = 'TT-013';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-ban/TT-014/Black.jpg|./assets/images/products/Bong-ban/TT-014/Black2.jpg|./assets/images/products/Bong-ban/TT-014/Blue.jpg',
    mau = 'Đen|Xanh dương'
WHERE sku = 'TT-014';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-ban/TT-015/Black.jpg|./assets/images/products/Bong-ban/TT-015/Black2.jpg|./assets/images/products/Bong-ban/TT-015/Black3.jpg',
    mau = 'Đen'
WHERE sku = 'TT-015';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-ban/TT-016/Orginal.jpg|./assets/images/products/Bong-ban/TT-016/Red.png|./assets/images/products/Bong-ban/TT-016/Red2.jpg',
    mau = 'Nguyên bản|Đỏ'
WHERE sku = 'TT-016';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-ban/TT-017/1.jpg|./assets/images/products/Bong-ban/TT-017/2.jpg|./assets/images/products/Bong-ban/TT-017/3.jpg'
WHERE sku = 'TT-017';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-ban/TT-018/1.jpg|./assets/images/products/Bong-ban/TT-018/2.jpg|./assets/images/products/Bong-ban/TT-018/3.jpg'
WHERE sku = 'TT-018';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-ban/TT-019/1.jpg|./assets/images/products/Bong-ban/TT-019/2.jpg|./assets/images/products/Bong-ban/TT-019/3.jpg'
WHERE sku = 'TT-019';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-ban/TT-020/1.jpg|./assets/images/products/Bong-ban/TT-020/2.jpg|./assets/images/products/Bong-ban/TT-020/3.jpg'
WHERE sku = 'TT-020';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-ban/TT-021/1.jpg|./assets/images/products/Bong-ban/TT-021/2.jpg|./assets/images/products/Bong-ban/TT-021/3.jpg'
WHERE sku = 'TT-021';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-ban/TT-022/1.jpg|./assets/images/products/Bong-ban/TT-022/2.png|./assets/images/products/Bong-ban/TT-022/3.jpg'
WHERE sku = 'TT-022';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-ban/TT-023/1.jpg|./assets/images/products/Bong-ban/TT-023/2.png|./assets/images/products/Bong-ban/TT-023/3.jpg'
WHERE sku = 'TT-023';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-ban/TT-024/1.jpg|./assets/images/products/Bong-ban/TT-024/2.jpg|./assets/images/products/Bong-ban/TT-024/3.jpg'
WHERE sku = 'TT-024';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-ban/TT-025/1.png|./assets/images/products/Bong-ban/TT-025/2.jpg|./assets/images/products/Bong-ban/TT-025/4.jpg'
WHERE sku = 'TT-025';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-ban/TT-026/1.jpg|./assets/images/products/Bong-ban/TT-026/3.jpg|./assets/images/products/Bong-ban/TT-026/4.jpg'
WHERE sku = 'TT-026';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-ban/TT-027/1.jpg|./assets/images/products/Bong-ban/TT-027/3.jpg|./assets/images/products/Bong-ban/TT-027/4.jpeg'
WHERE sku = 'TT-027';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-ban/TT-028/Xanh1.jpg|./assets/images/products/Bong-ban/TT-028/Xanh2.jpg|./assets/images/products/Bong-ban/TT-028/Yellow-Purple.jpg',
    mau = 'Xanh|Vàng / Tím'
WHERE sku = 'TT-028';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-ban/TT-029/Blue.jpg|./assets/images/products/Bong-ban/TT-029/Green.jpg|./assets/images/products/Bong-ban/TT-029/Red.webp',
    mau = 'Xanh dương|Xanh lá|Đỏ'
WHERE sku = 'TT-029';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-ban/TT-130/1.jpg|./assets/images/products/Bong-ban/TT-130/2.jpg|./assets/images/products/Bong-ban/TT-130/3.webp'
WHERE sku = 'TT-130';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-ban/TT-131/1.jpeg|./assets/images/products/Bong-ban/TT-131/2.jpg|./assets/images/products/Bong-ban/TT-131/3.jpeg'
WHERE sku = 'TT-131';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-chuyen/VB-001/1.png|./assets/images/products/Bong-chuyen/VB-001/2.jpg|./assets/images/products/Bong-chuyen/VB-001/3.jpg'
WHERE sku = 'VB-001';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-chuyen/VB-002/1.jpg|./assets/images/products/Bong-chuyen/VB-002/2.png|./assets/images/products/Bong-chuyen/VB-002/3.jpg'
WHERE sku = 'VB-002';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-chuyen/VB-003/1.jpg|./assets/images/products/Bong-chuyen/VB-003/2.png|./assets/images/products/Bong-chuyen/VB-003/3.jpg'
WHERE sku = 'VB-003';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-chuyen/VB-004/1.jpg|./assets/images/products/Bong-chuyen/VB-004/2.jpg|./assets/images/products/Bong-chuyen/VB-004/3.jpg'
WHERE sku = 'VB-004';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-chuyen/VB-005/2.jpg|./assets/images/products/Bong-chuyen/VB-005/3.jpg|./assets/images/products/Bong-chuyen/VB-005/4.jpg'
WHERE sku = 'VB-005';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-chuyen/VB-006/1.jpg|./assets/images/products/Bong-chuyen/VB-006/2.jpg|./assets/images/products/Bong-chuyen/VB-006/4.jpg'
WHERE sku = 'VB-006';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-chuyen/VB-007/2.jpeg|./assets/images/products/Bong-chuyen/VB-007/3.jpg|./assets/images/products/Bong-chuyen/VB-007/4.png'
WHERE sku = 'VB-007';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-chuyen/VB-008/1.jpg|./assets/images/products/Bong-chuyen/VB-008/2.jpg|./assets/images/products/Bong-chuyen/VB-008/3.jpg'
WHERE sku = 'VB-008';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-chuyen/VB-009/1.jpg|./assets/images/products/Bong-chuyen/VB-009/2.jpg|./assets/images/products/Bong-chuyen/VB-009/3.png'
WHERE sku = 'VB-009';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-chuyen/VB-010/Black.jpg|./assets/images/products/Bong-chuyen/VB-010/Mix-3-Màu.jpg|./assets/images/products/Bong-chuyen/VB-010/White.webp',
    mau = 'Đen|Mix 3 màu|Trắng'
WHERE sku = 'VB-010';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-chuyen/VB-011/Green.jpg|./assets/images/products/Bong-chuyen/VB-011/Green.png|./assets/images/products/Bong-chuyen/VB-011/Red.png',
    mau = 'Xanh lá|Đỏ'
WHERE sku = 'VB-011';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-chuyen/VB-012/Blue.jpg|./assets/images/products/Bong-chuyen/VB-012/Green.jpg|./assets/images/products/Bong-chuyen/VB-012/Pink.jpg',
    mau = 'Xanh dương|Xanh lá|Hồng'
WHERE sku = 'VB-012';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-chuyen/VB-013/Black.jpg|./assets/images/products/Bong-chuyen/VB-013/Original.png|./assets/images/products/Bong-chuyen/VB-013/White.jpg',
    mau = 'Đen|Nguyên bản|Trắng'
WHERE sku = 'VB-013';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-chuyen/VB-014/Black.png|./assets/images/products/Bong-chuyen/VB-014/Brown.png|./assets/images/products/Bong-chuyen/VB-014/Red.jpg',
    mau = 'Đen|Nâu|Đỏ'
WHERE sku = 'VB-014';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-chuyen/VB-015/Black.jpg|./assets/images/products/Bong-chuyen/VB-015/Blue.jpg|./assets/images/products/Bong-chuyen/VB-015/White.jpg',
    mau = 'Đen|Xanh dương|Trắng'
WHERE sku = 'VB-015';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-chuyen/VB-016/Black.png|./assets/images/products/Bong-chuyen/VB-016/Black2.jpg|./assets/images/products/Bong-chuyen/VB-016/White.jpg',
    mau = 'Đen|Trắng'
WHERE sku = 'VB-016';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-chuyen/VB-017/Blue.jpg|./assets/images/products/Bong-chuyen/VB-017/White.jpg',
    mau = 'Xanh dương|Trắng'
WHERE sku = 'VB-017';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-chuyen/VB-018/Green.jpg|./assets/images/products/Bong-chuyen/VB-018/Red-Stripes.jpg|./assets/images/products/Bong-chuyen/VB-018/Red.jpg',
    mau = 'Xanh lá|Đỏ sọc|Đỏ'
WHERE sku = 'VB-018';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-chuyen/VB-019/Black.jpg|./assets/images/products/Bong-chuyen/VB-019/White.webp|./assets/images/products/Bong-chuyen/VB-019/White2.png',
    mau = 'Đen|Trắng'
WHERE sku = 'VB-019';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-chuyen/VB-020/1.webp|./assets/images/products/Bong-chuyen/VB-020/2.jpg|./assets/images/products/Bong-chuyen/VB-020/3.jpg'
WHERE sku = 'VB-020';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-chuyen/VB-021/Black.jpg|./assets/images/products/Bong-chuyen/VB-021/White-Special.jpg|./assets/images/products/Bong-chuyen/VB-021/White.jpg',
    mau = 'Đen|Trắng đặc biệt|Trắng'
WHERE sku = 'VB-021';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-chuyen/VB-022/1.jpg|./assets/images/products/Bong-chuyen/VB-022/2.jpg|./assets/images/products/Bong-chuyen/VB-022/3.jpg'
WHERE sku = 'VB-022';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-chuyen/VB-023/2.jpg|./assets/images/products/Bong-chuyen/VB-023/3.jpg|./assets/images/products/Bong-chuyen/VB-023/Black.png',
    mau = 'Đen'
WHERE sku = 'VB-023';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-chuyen/VB-024/3.png|./assets/images/products/Bong-chuyen/VB-024/Black.png|./assets/images/products/Bong-chuyen/VB-024/Brown.png',
    mau = 'Đen|Nâu'
WHERE sku = 'VB-024';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-chuyen/VB-025/1.png|./assets/images/products/Bong-chuyen/VB-025/2.jpg|./assets/images/products/Bong-chuyen/VB-025/3.jpg'
WHERE sku = 'VB-025';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-chuyen/VB-026/Trắng.jpg|./assets/images/products/Bong-chuyen/VB-026/Xanh.png|./assets/images/products/Bong-chuyen/VB-026/Đỏ.png',
    mau = 'Trắng|Xanh|Đỏ'
WHERE sku = 'VB-026';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-chuyen/VB-027/Black.jpg|./assets/images/products/Bong-chuyen/VB-027/Blue.jpg|./assets/images/products/Bong-chuyen/VB-027/Red.jpg',
    mau = 'Đen|Xanh dương|Đỏ'
WHERE sku = 'VB-027';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-chuyen/VB-028/3.png|./assets/images/products/Bong-chuyen/VB-028/Gray.png|./assets/images/products/Bong-chuyen/VB-028/Gray2.png',
    mau = 'Xám'
WHERE sku = 'VB-028';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-chuyen/VB-129/1.jpg|./assets/images/products/Bong-chuyen/VB-129/2.jpg|./assets/images/products/Bong-chuyen/VB-129/3.jpg'
WHERE sku = 'VB-129';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-chuyen/VB-130/1.jpg|./assets/images/products/Bong-chuyen/VB-130/2.jpg|./assets/images/products/Bong-chuyen/VB-130/3.png'
WHERE sku = 'VB-130';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-Da/FB-001/Blue-White.jpg|./assets/images/products/Bong-Da/FB-001/Blue.jpg|./assets/images/products/Bong-Da/FB-001/White.jpg',
    mau = 'Xanh dương / Trắng|Xanh dương|Trắng'
WHERE sku = 'FB-001';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-Da/FB-003/Blue.jpg|./assets/images/products/Bong-Da/FB-003/Blue2.jpg|./assets/images/products/Bong-Da/FB-003/Milk.jpg',
    mau = 'Xanh dương|Trắng sữa'
WHERE sku = 'FB-003';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-Da/FB-007/Blue.jpg|./assets/images/products/Bong-Da/FB-007/Blue2.jpg|./assets/images/products/Bong-Da/FB-007/Red.jpg',
    mau = 'Xanh dương|Đỏ'
WHERE sku = 'FB-007';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-Da/FB-008/organge.jpg|./assets/images/products/Bong-Da/FB-008/Purple.jpg|./assets/images/products/Bong-Da/FB-008/White.jpg',
    mau = 'Cam|Tím|Trắng'
WHERE sku = 'FB-008';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-Da/FB-009/Blue.jpg|./assets/images/products/Bong-Da/FB-009/Pink.jpg|./assets/images/products/Bong-Da/FB-009/Purple.jpg',
    mau = 'Xanh dương|Hồng|Tím'
WHERE sku = 'FB-009';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-Da/FB-010/Blue.jpg|./assets/images/products/Bong-Da/FB-010/Red.jpg|./assets/images/products/Bong-Da/FB-010/Yellow.jpg',
    mau = 'Xanh dương|Đỏ|Vàng'
WHERE sku = 'FB-010';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-Da/FB-011/Organge.jpg|./assets/images/products/Bong-Da/FB-011/Red.jpg|./assets/images/products/Bong-Da/FB-011/White.jpg',
    mau = 'Cam|Đỏ|Trắng'
WHERE sku = 'FB-011';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-Da/FB-012/3.jpg|./assets/images/products/Bong-Da/FB-012/Blue.jpg|./assets/images/products/Bong-Da/FB-012/Green.jpg',
    mau = 'Xanh dương|Xanh lá'
WHERE sku = 'FB-012';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-Da/FB-013/3.jpg|./assets/images/products/Bong-Da/FB-013/Blue.png|./assets/images/products/Bong-Da/FB-013/White.jpg',
    mau = 'Xanh dương|Trắng'
WHERE sku = 'FB-013';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-Da/FB-014/3.jpg|./assets/images/products/Bong-Da/FB-014/Organge.png|./assets/images/products/Bong-Da/FB-014/White.jpg',
    mau = 'Cam|Trắng'
WHERE sku = 'FB-014';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-Da/FB-015/Blue.jpg|./assets/images/products/Bong-Da/FB-015/Green.jpg|./assets/images/products/Bong-Da/FB-015/Orange.jpg',
    mau = 'Xanh dương|Xanh lá|Cam'
WHERE sku = 'FB-015';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-Da/FB-016/1.webp|./assets/images/products/Bong-Da/FB-016/5.jpg|./assets/images/products/Bong-Da/FB-016/6.webp'
WHERE sku = 'FB-016';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-Da/FB-017/Black.jpg|./assets/images/products/Bong-Da/FB-017/Black2.jpg|./assets/images/products/Bong-Da/FB-017/Gray.jpg',
    mau = 'Đen|Xám'
WHERE sku = 'FB-017';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-Da/FB-018/Black.jpg|./assets/images/products/Bong-Da/FB-018/Blue.png|./assets/images/products/Bong-Da/FB-018/Blue2.jpg',
    mau = 'Đen|Xanh dương'
WHERE sku = 'FB-018';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-Da/FB-019/Black.jpg|./assets/images/products/Bong-Da/FB-019/Green.jpg|./assets/images/products/Bong-Da/FB-019/Red.jpg',
    mau = 'Đen|Xanh lá|Đỏ'
WHERE sku = 'FB-019';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-Da/FB-020/Black.jpg|./assets/images/products/Bong-Da/FB-020/Black.png|./assets/images/products/Bong-Da/FB-020/Blue.png',
    mau = 'Đen|Xanh dương'
WHERE sku = 'FB-020';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-Da/FB-021/Black.jpg|./assets/images/products/Bong-Da/FB-021/Black2.jpg|./assets/images/products/Bong-Da/FB-021/Black3.jpg',
    mau = 'Đen'
WHERE sku = 'FB-021';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-Da/FB-022/Black.jpg|./assets/images/products/Bong-Da/FB-022/Black2.jpg|./assets/images/products/Bong-Da/FB-022/Black3.jpg',
    mau = 'Đen'
WHERE sku = 'FB-022';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-Da/FB-023/Balck2.jpg|./assets/images/products/Bong-Da/FB-023/Black.jpg|./assets/images/products/Bong-Da/FB-023/Blue.png',
    mau = 'Đen|Xanh dương'
WHERE sku = 'FB-023';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-Da/FB-024/1.jpg|./assets/images/products/Bong-Da/FB-024/2.jpg|./assets/images/products/Bong-Da/FB-024/3.jpg'
WHERE sku = 'FB-024';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-Da/FB-025/Black.png|./assets/images/products/Bong-Da/FB-025/Black2.png|./assets/images/products/Bong-Da/FB-025/White.jpg',
    mau = 'Đen|Trắng'
WHERE sku = 'FB-025';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-Da/FB-026/Green.jpg|./assets/images/products/Bong-Da/FB-026/Orange.jpg|./assets/images/products/Bong-Da/FB-026/Red.jpg',
    mau = 'Xanh lá|Cam|Đỏ'
WHERE sku = 'FB-026';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-Da/FB-027/Black.png|./assets/images/products/Bong-Da/FB-027/Green.jpg|./assets/images/products/Bong-Da/FB-027/Red.png',
    mau = 'Đen|Xanh lá|Đỏ'
WHERE sku = 'FB-027';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-Da/FB-028/Black.png|./assets/images/products/Bong-Da/FB-028/White.png|./assets/images/products/Bong-Da/FB-028/White2.png',
    mau = 'Đen|Trắng'
WHERE sku = 'FB-028';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-Da/FB-029/Green.webp|./assets/images/products/Bong-Da/FB-029/Red.jpg|./assets/images/products/Bong-Da/FB-029/White.jpg',
    mau = 'Xanh lá|Đỏ|Trắng'
WHERE sku = 'FB-029';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-Da/FB-030/Black.jpg|./assets/images/products/Bong-Da/FB-030/Blue.jpg|./assets/images/products/Bong-Da/FB-030/Red.jpg',
    mau = 'Đen|Xanh dương|Đỏ'
WHERE sku = 'FB-030';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-Da/FB-031/Black.jpg|./assets/images/products/Bong-Da/FB-031/Black2.jpg|./assets/images/products/Bong-Da/FB-031/Blue.jpg',
    mau = 'Đen|Xanh dương'
WHERE sku = 'FB-031';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-Da/FB-132/1.jpg|./assets/images/products/Bong-Da/FB-132/2.png|./assets/images/products/Bong-Da/FB-132/3.png'
WHERE sku = 'FB-132';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-Da/FB-133/1.jpg|./assets/images/products/Bong-Da/FB-133/2.jpg|./assets/images/products/Bong-Da/FB-133/3.jpg'
WHERE sku = 'FB-133';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-Da/FB-134/1.webp|./assets/images/products/Bong-Da/FB-134/2.jpg|./assets/images/products/Bong-Da/FB-134/3.jpg'
WHERE sku = 'FB-134';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-Da/FB-135/1.jpg|./assets/images/products/Bong-Da/FB-135/2.jpeg|./assets/images/products/Bong-Da/FB-135/3.png'
WHERE sku = 'FB-135';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-ro/BB-002/1.jpg|./assets/images/products/Bong-ro/BB-002/2.png|./assets/images/products/Bong-ro/BB-002/3.jpg'
WHERE sku = 'BB-002';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-ro/BB-003/1.jpg|./assets/images/products/Bong-ro/BB-003/2.jpg|./assets/images/products/Bong-ro/BB-003/4.png'
WHERE sku = 'BB-003';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-ro/BB-004/1.jpg|./assets/images/products/Bong-ro/BB-004/2.jpg|./assets/images/products/Bong-ro/BB-004/3.jpg'
WHERE sku = 'BB-004';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-ro/BB-005/1.jpg|./assets/images/products/Bong-ro/BB-005/2.jpg|./assets/images/products/Bong-ro/BB-005/3.jpg'
WHERE sku = 'BB-005';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-ro/BB-006/1.jpg|./assets/images/products/Bong-ro/BB-006/2.jpg|./assets/images/products/Bong-ro/BB-006/3.jpg'
WHERE sku = 'BB-006';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-ro/BB-007/1.jpg|./assets/images/products/Bong-ro/BB-007/2.jpeg|./assets/images/products/Bong-ro/BB-007/3.jpg'
WHERE sku = 'BB-007';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-ro/BB-008/Blue.png|./assets/images/products/Bong-ro/BB-008/Blue2.jpeg|./assets/images/products/Bong-ro/BB-008/Original.jpg',
    mau = 'Xanh dương|Nguyên bản'
WHERE sku = 'BB-008';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-ro/BB-009/Blue.jpg|./assets/images/products/Bong-ro/BB-009/Pink.jpg|./assets/images/products/Bong-ro/BB-009/Pink2.jpg',
    mau = 'Xanh dương|Hồng'
WHERE sku = 'BB-009';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-ro/BB-010/Gray.jpg|./assets/images/products/Bong-ro/BB-010/White.jpg|./assets/images/products/Bong-ro/BB-010/White2.jpg',
    mau = 'Xám|Trắng'
WHERE sku = 'BB-010';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-ro/BB-011/Black.webp|./assets/images/products/Bong-ro/BB-011/Black2.jpg|./assets/images/products/Bong-ro/BB-011/White.jpg',
    mau = 'Đen|Trắng'
WHERE sku = 'BB-011';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-ro/BB-012/Black.jpg|./assets/images/products/Bong-ro/BB-012/Blue.jpg|./assets/images/products/Bong-ro/BB-012/Orange.png',
    mau = 'Đen|Xanh dương|Cam'
WHERE sku = 'BB-012';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-ro/BB-013/Blue.png|./assets/images/products/Bong-ro/BB-013/Brown.webp|./assets/images/products/Bong-ro/BB-013/Green.jpg',
    mau = 'Xanh dương|Nâu|Xanh lá'
WHERE sku = 'BB-013';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-ro/BB-014/Black.jpeg|./assets/images/products/Bong-ro/BB-014/Gray.jpg|./assets/images/products/Bong-ro/BB-014/White.jpg',
    mau = 'Đen|Xám|Trắng'
WHERE sku = 'BB-014';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-ro/BB-015/1.jpg|./assets/images/products/Bong-ro/BB-015/2.jpg|./assets/images/products/Bong-ro/BB-015/3.png'
WHERE sku = 'BB-015';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-ro/BB-016/Blue.jpg|./assets/images/products/Bong-ro/BB-016/Green.png|./assets/images/products/Bong-ro/BB-016/Original.jpg',
    mau = 'Xanh dương|Xanh lá|Nguyên bản'
WHERE sku = 'BB-016';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-ro/BB-017/1.jpg|./assets/images/products/Bong-ro/BB-017/2.jpg|./assets/images/products/Bong-ro/BB-017/3.jpg'
WHERE sku = 'BB-017';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-ro/BB-018/1.jpeg|./assets/images/products/Bong-ro/BB-018/2.jpg|./assets/images/products/Bong-ro/BB-018/3.jpeg'
WHERE sku = 'BB-018';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-ro/BB-019/Black.webp|./assets/images/products/Bong-ro/BB-019/Black2.png|./assets/images/products/Bong-ro/BB-019/White.png',
    mau = 'Đen|Trắng'
WHERE sku = 'BB-019';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-ro/BB-020/1.jpg|./assets/images/products/Bong-ro/BB-020/2.jpg|./assets/images/products/Bong-ro/BB-020/3.jpg'
WHERE sku = 'BB-020';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-ro/BB-021/Black.jpg|./assets/images/products/Bong-ro/BB-021/White.jpg|./assets/images/products/Bong-ro/BB-021/White2.png',
    mau = 'Đen|Trắng'
WHERE sku = 'BB-021';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-ro/BB-022/Black.png|./assets/images/products/Bong-ro/BB-022/Blue.png|./assets/images/products/Bong-ro/BB-022/Gray.jpg',
    mau = 'Đen|Xanh dương|Xám'
WHERE sku = 'BB-022';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-ro/BB-023/1.jpg|./assets/images/products/Bong-ro/BB-023/2.jpg|./assets/images/products/Bong-ro/BB-023/3.jpg'
WHERE sku = 'BB-023';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-ro/BB-024/Black.png|./assets/images/products/Bong-ro/BB-024/Red.jpg|./assets/images/products/Bong-ro/BB-024/White.jpg',
    mau = 'Đen|Đỏ|Trắng'
WHERE sku = 'BB-024';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-ro/BB-025/1.jpg|./assets/images/products/Bong-ro/BB-025/2.jpg|./assets/images/products/Bong-ro/BB-025/3.jpg'
WHERE sku = 'BB-025';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-ro/BB-126/1.jpg|./assets/images/products/Bong-ro/BB-126/3.jpg|./assets/images/products/Bong-ro/BB-126/4.jpg'
WHERE sku = 'BB-126';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Bong-ro/BB-127/1.jpg|./assets/images/products/Bong-ro/BB-127/2.jpg|./assets/images/products/Bong-ro/BB-127/3.jpg'
WHERE sku = 'BB-127';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Cau-Long/BM-001/Green.jpg|./assets/images/products/Cau-Long/BM-001/Green2.jpg|./assets/images/products/Cau-Long/BM-001/Green3.jpg',
    mau = 'Xanh lá'
WHERE sku = 'BM-001';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Cau-Long/BM-002/Gray.jpg|./assets/images/products/Cau-Long/BM-002/Gray2.jpg|./assets/images/products/Cau-Long/BM-002/Purple.jpg',
    mau = 'Xám|Tím'
WHERE sku = 'BM-002';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Cau-Long/BM-003/Red.jpg|./assets/images/products/Cau-Long/BM-003/Red2.png|./assets/images/products/Cau-Long/BM-003/Red3.jpg',
    mau = 'Đỏ'
WHERE sku = 'BM-003';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Cau-Long/BM-004/Yellow.png|./assets/images/products/Cau-Long/BM-004/Yellow.webp|./assets/images/products/Cau-Long/BM-004/Yellow2.png',
    mau = 'Vàng'
WHERE sku = 'BM-004';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Cau-Long/BM-005/Yellow.jpg|./assets/images/products/Cau-Long/BM-005/Yellow2.jpg|./assets/images/products/Cau-Long/BM-005/Yellow3.png',
    mau = 'Vàng'
WHERE sku = 'BM-005';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Cau-Long/BM-006/Purple.jpg|./assets/images/products/Cau-Long/BM-006/Purple.webp|./assets/images/products/Cau-Long/BM-006/Purple2.jpg',
    mau = 'Tím'
WHERE sku = 'BM-006';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Cau-Long/BM-007/White.jpg|./assets/images/products/Cau-Long/BM-007/White2.jpg|./assets/images/products/Cau-Long/BM-007/White3.jpg',
    mau = 'Trắng'
WHERE sku = 'BM-007';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Cau-Long/BM-008/Blue.jpg|./assets/images/products/Cau-Long/BM-008/Blue2.jpg|./assets/images/products/Cau-Long/BM-008/Blue3.jpg',
    mau = 'Xanh dương'
WHERE sku = 'BM-008';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Cau-Long/BM-009/Black.jpg|./assets/images/products/Cau-Long/BM-009/Blue.jpg|./assets/images/products/Cau-Long/BM-009/Purple.png',
    mau = 'Đen|Xanh dương|Tím'
WHERE sku = 'BM-009';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Cau-Long/BM-010/1.jpg|./assets/images/products/Cau-Long/BM-010/2.jpg|./assets/images/products/Cau-Long/BM-010/3.jpg'
WHERE sku = 'BM-010';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Cau-Long/BM-011/1.jpg|./assets/images/products/Cau-Long/BM-011/2.jpg|./assets/images/products/Cau-Long/BM-011/3.jpg'
WHERE sku = 'BM-011';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Cau-Long/BM-012/1.jpg|./assets/images/products/Cau-Long/BM-012/2.jpg|./assets/images/products/Cau-Long/BM-012/3.jpg'
WHERE sku = 'BM-012';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Cau-Long/BM-013/1.jpg|./assets/images/products/Cau-Long/BM-013/2.jpg|./assets/images/products/Cau-Long/BM-013/3.jpg'
WHERE sku = 'BM-013';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Cau-Long/BM-014/Black.jpg|./assets/images/products/Cau-Long/BM-014/White.png|./assets/images/products/Cau-Long/BM-014/White2.jpg',
    mau = 'Đen|Trắng'
WHERE sku = 'BM-014';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Cau-Long/BM-015/Black.jpg|./assets/images/products/Cau-Long/BM-015/Blue.webp|./assets/images/products/Cau-Long/BM-015/Green.webp',
    mau = 'Đen|Xanh dương|Xanh lá'
WHERE sku = 'BM-015';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Cau-Long/BM-016/Blue.jpg|./assets/images/products/Cau-Long/BM-016/Blue2.jpg|./assets/images/products/Cau-Long/BM-016/Purple.jpg',
    mau = 'Xanh dương|Tím'
WHERE sku = 'BM-016';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Cau-Long/BM-017/Black.jpg|./assets/images/products/Cau-Long/BM-017/Blue.jpg|./assets/images/products/Cau-Long/BM-017/Orange.jpeg',
    mau = 'Đen|Xanh dương|Cam'
WHERE sku = 'BM-017';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Cau-Long/BM-018/2.jpg|./assets/images/products/Cau-Long/BM-018/3.jpg|./assets/images/products/Cau-Long/BM-018/5.jpg'
WHERE sku = 'BM-018';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Cau-Long/BM-019/1.png|./assets/images/products/Cau-Long/BM-019/2.jpg|./assets/images/products/Cau-Long/BM-019/3.webp'
WHERE sku = 'BM-019';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Cau-Long/BM-020/Black.jpg|./assets/images/products/Cau-Long/BM-020/Green.jpg|./assets/images/products/Cau-Long/BM-020/White.webp',
    mau = 'Đen|Xanh lá|Trắng'
WHERE sku = 'BM-020';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Cau-Long/BM-021/1.jpg|./assets/images/products/Cau-Long/BM-021/2.jpg|./assets/images/products/Cau-Long/BM-021/3.jpg'
WHERE sku = 'BM-021';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Cau-Long/BM-022/Orange.jpg|./assets/images/products/Cau-Long/BM-022/Orange2.jpg|./assets/images/products/Cau-Long/BM-022/Orange3.png',
    mau = 'Cam'
WHERE sku = 'BM-022';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Cau-Long/BM-023/Black.png|./assets/images/products/Cau-Long/BM-023/Black.webp|./assets/images/products/Cau-Long/BM-023/White.jpg',
    mau = 'Đen|Trắng'
WHERE sku = 'BM-023';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Cau-Long/BM-024/1.jpg|./assets/images/products/Cau-Long/BM-024/2.webp|./assets/images/products/Cau-Long/BM-024/3.jpg'
WHERE sku = 'BM-024';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Cau-Long/BM-128/1.jpg|./assets/images/products/Cau-Long/BM-128/2.jpg|./assets/images/products/Cau-Long/BM-128/3.jpg'
WHERE sku = 'BM-128';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Cau-Long/BM-129/Green.png|./assets/images/products/Cau-Long/BM-129/Green2.jpg|./assets/images/products/Cau-Long/BM-129/Green3.jpg'
WHERE sku = 'BM-129';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Chay-bo/RUN-001/Black.png|./assets/images/products/Chay-bo/RUN-001/Green.png|./assets/images/products/Chay-bo/RUN-001/Orange.png',
    mau = 'Đen|Xanh lá|Cam'
WHERE sku = 'RUN-001';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Chay-bo/RUN-002/Black.png|./assets/images/products/Chay-bo/RUN-002/Blue.jpg|./assets/images/products/Chay-bo/RUN-002/Green.png',
    mau = 'Đen|Xanh dương|Xanh lá'
WHERE sku = 'RUN-002';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Chay-bo/RUN-003/Black.jpg|./assets/images/products/Chay-bo/RUN-003/Orange.jpg|./assets/images/products/Chay-bo/RUN-003/White.jpg',
    mau = 'Đen|Cam|Trắng'
WHERE sku = 'RUN-003';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Chay-bo/RUN-004/Black.jpg|./assets/images/products/Chay-bo/RUN-004/Blue.jpg|./assets/images/products/Chay-bo/RUN-004/Green.jpg',
    mau = 'Đen|Xanh dương|Xanh lá'
WHERE sku = 'RUN-004';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Chay-bo/RUN-005/Black.png|./assets/images/products/Chay-bo/RUN-005/Black2.png|./assets/images/products/Chay-bo/RUN-005/Green.png',
    mau = 'Đen|Xanh lá'
WHERE sku = 'RUN-005';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Chay-bo/RUN-006/Black.png|./assets/images/products/Chay-bo/RUN-006/Gray.png|./assets/images/products/Chay-bo/RUN-006/Green.png',
    mau = 'Đen|Xám|Xanh lá'
WHERE sku = 'RUN-006';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Chay-bo/RUN-007/Black.jpg|./assets/images/products/Chay-bo/RUN-007/Blue.jpg|./assets/images/products/Chay-bo/RUN-007/Red.jpg',
    mau = 'Đen|Xanh dương|Đỏ'
WHERE sku = 'RUN-007';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Tap-gym/GYM-001/Black.jpg|./assets/images/products/Tap-gym/GYM-001/Gray.jpg|./assets/images/products/Tap-gym/GYM-001/Green.jpg',
    mau = 'Đen|Xám|Xanh lá'
WHERE sku = 'GYM-001';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Tap-gym/GYM-002/Blue.png|./assets/images/products/Tap-gym/GYM-002/Dark-Blue.png|./assets/images/products/Tap-gym/GYM-002/Green.png',
    mau = 'Xanh dương|Xanh đậm|Xanh lá'
WHERE sku = 'GYM-002';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Tap-gym/GYM-003/Black.png|./assets/images/products/Tap-gym/GYM-003/Black2.png|./assets/images/products/Tap-gym/GYM-003/Blue.png',
    mau = 'Đen|Xanh dương'
WHERE sku = 'GYM-003';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Tap-gym/GYM-004/Black.png|./assets/images/products/Tap-gym/GYM-004/Gray.png|./assets/images/products/Tap-gym/GYM-004/Gray2.png',
    mau = 'Đen|Xám'
WHERE sku = 'GYM-004';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Tap-gym/GYM-005/Green.png|./assets/images/products/Tap-gym/GYM-005/Purple.png|./assets/images/products/Tap-gym/GYM-005/REd.png',
    mau = 'Xanh lá|Tím|Đỏ'
WHERE sku = 'GYM-005';

UPDATE tbl_san_pham
SET hinh_anh_url = './assets/images/products/Tap-gym/GYM-006/Gray.png|./assets/images/products/Tap-gym/GYM-006/Green.png|./assets/images/products/Tap-gym/GYM-006/Pink.png',
    mau = 'Xám|Xanh lá|Hồng'
WHERE sku = 'GYM-006';
