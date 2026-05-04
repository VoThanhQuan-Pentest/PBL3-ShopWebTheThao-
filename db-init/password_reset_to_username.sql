UPDATE tbl_nguoi_dung
SET password = CASE username
    WHEN 'admin' THEN '$2a$10$2aC11wroQrPCdLy/7Nc9a.eYLBhmoEZKhQloNYyUrMJTcb1VNtaoG'
    WHEN 'nhanvien01' THEN '$2a$10$0MKL/VZwelxf1dgq0rXqzuvBGWivtflHbF/8tLOrAwfNKXb/fJScO'
    WHEN 'khachhang01' THEN '$2a$10$gR7Uxrj8kRf76KS5AFDCGuBgbNhPMGLrlk1vQ0U3tYqyNyXCQrv8i'
    WHEN 'khachhang02' THEN '$2a$10$aZIAZZqOVH1CtFLaN26OMuR6VDPOvUcqW3xrshu8GR67DODVRlB/W'
    WHEN 'nguyen' THEN '$2a$10$ssvnf0hmZFee5sQJsCSx1OKG0IQDaSxfDbMPUqdCwVU8.kJEiBKnK'
    WHEN 'quan' THEN '$2a$10$XE/TIhSc/PSA2i84etuGr.0sxo0Q36oJoAWDtSOfJ/IE39wb.w6LG'
    WHEN 'rule1776692940' THEN '$2a$10$hTP/fqkiUdHoD/P1B9LmRu54TXorJMVKqMxxFAbBCCld2iHpMLqvC'
    WHEN 'user1776690398' THEN '$2a$10$oiBu1SdXIPDIyvdyl7/PHe3ge.4.pBCzl0MOxfObS1KI292cQIt4S'
    ELSE password
END
WHERE username IN (
    'admin',
    'nhanvien01',
    'khachhang01',
    'khachhang02',
    'nguyen',
    'quan',
    'rule1776692940',
    'user1776690398'
);
