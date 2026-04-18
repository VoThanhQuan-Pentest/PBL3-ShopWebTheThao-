package com.flarefitness.backend.dto.product;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public record ProductResponse(
        String id,
        String tenSanPham,
        String sku,
        String danhMuc,
        String thuongHieu,
        String size,
        String mau,
        BigDecimal giaNhap,
        BigDecimal giaBan,
        Integer tonKho,
        String trangThai,
        String linkSanPham,
        String ghiChu,
        LocalDateTime ngayTao
) {
}
