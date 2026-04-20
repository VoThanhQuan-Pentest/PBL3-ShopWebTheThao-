package com.flarefitness.backend.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "tbl_khach_hang")
public class Customer extends BaseEntity {

    @Id
    @Column(name = "id", nullable = false, length = 64)
    private String id;

    @Column(name = "user_id", length = 64)
    private String userId;

    @Column(name = "ten_khach", nullable = false, length = 150)
    private String tenKhach;

    @Column(name = "sdt", nullable = false, length = 30)
    private String sdt;

    @Column(name = "email", length = 150)
    private String email;

    @Column(name = "kenh", length = 50)
    private String kenh;

    @Column(name = "nhan", length = 100)
    private String nhan;

    @Column(name = "dia_chi", length = 500)
    private String diaChi;

    @Column(name = "ghi_chu", length = 500)
    private String ghiChu;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getTenKhach() {
        return tenKhach;
    }

    public void setTenKhach(String tenKhach) {
        this.tenKhach = tenKhach;
    }

    public String getSdt() {
        return sdt;
    }

    public void setSdt(String sdt) {
        this.sdt = sdt;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getKenh() {
        return kenh;
    }

    public void setKenh(String kenh) {
        this.kenh = kenh;
    }

    public String getNhan() {
        return nhan;
    }

    public void setNhan(String nhan) {
        this.nhan = nhan;
    }

    public String getDiaChi() {
        return diaChi;
    }

    public void setDiaChi(String diaChi) {
        this.diaChi = diaChi;
    }

    public String getGhiChu() {
        return ghiChu;
    }

    public void setGhiChu(String ghiChu) {
        this.ghiChu = ghiChu;
    }
}
