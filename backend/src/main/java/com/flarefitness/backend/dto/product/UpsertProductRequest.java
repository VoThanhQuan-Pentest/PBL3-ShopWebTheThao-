package com.flarefitness.backend.dto.product;

import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import java.math.BigDecimal;

public record UpsertProductRequest(
        @NotBlank(message = "Ten san pham la bat buoc.")
        String tenSanPham,
        @NotBlank(message = "SKU la bat buoc.")
        String sku,
        @NotBlank(message = "Danh muc la bat buoc.")
        String danhMuc,
        String thuongHieu,
        String size,
        String mau,
        @NotNull(message = "Gia nhap la bat buoc.")
        @DecimalMin(value = "0.0", inclusive = true, message = "Gia nhap phai >= 0.")
        BigDecimal giaNhap,
        @NotNull(message = "Gia ban la bat buoc.")
        @DecimalMin(value = "0.0", inclusive = true, message = "Gia ban phai >= 0.")
        BigDecimal giaBan,
        @NotNull(message = "Ton kho la bat buoc.")
        @Min(value = 0, message = "Ton kho phai >= 0.")
        Integer tonKho,
        @NotBlank(message = "Trang thai la bat buoc.")
        String trangThai,
        String linkSanPham,
        String hinhAnhUrl,
        String ghiChu
) {
}
