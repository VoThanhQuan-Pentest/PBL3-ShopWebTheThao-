package com.flarefitness.backend.dto.product;

import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import java.math.BigDecimal;

public record UpsertProductRequest(
        @NotBlank(message = "Tên sản phẩm là bắt buộc.")
        String tenSanPham,
        @NotBlank(message = "SKU là bắt buộc.")
        String sku,
        @NotBlank(message = "Danh mục là bắt buộc.")
        String danhMuc,
        String thuongHieu,
        String size,
        String mau,
        @NotNull(message = "Giá nhập là bắt buộc.")
        @DecimalMin(value = "0.0", inclusive = true, message = "Giá nhập phải >= 0.")
        BigDecimal giaNhap,
        @NotNull(message = "Giá bán là bắt buộc.")
        @DecimalMin(value = "0.0", inclusive = true, message = "Giá bán phải >= 0.")
        BigDecimal giaBan,
        @NotNull(message = "Tồn kho là bắt buộc.")
        @Min(value = 0, message = "Tồn kho phải >= 0.")
        Integer tonKho,
        @NotBlank(message = "Trạng thái là bắt buộc.")
        String trangThai,
        String linkSanPham,
        String ghiChu
) {
}
