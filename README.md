# Flare Fitness

Project nay da duoc chuyen sang che do self-contained bang Docker. Nguoi khac clone repo ve khong can cai MySQL local, chi can Docker Desktop.

## Stack

- `nginx`: phuc vu frontend va reverse proxy `/api`
- `app`: Spring Boot backend
- `db`: MySQL 8.4, tu dong khoi tao tu `db-init/schema_full.sql`
- `redis`: cache va luu token/login throttle

## Chay nhanh

Yeu cau:

- Docker Desktop dang chay
- Gmail `Hoangngocnguyen2006@gmail.com` da bat 2FA va co App Password de gui OTP

Lan dau tien hoac khi muon reset sach database:

```powershell
$env:APP_MAIL_PASSWORD="app-password-16-ky-tu-cua-gmail"
docker compose down -v
docker compose up --build
```

Sau khi chay xong:

- Frontend: `http://localhost`
- API health: `http://localhost/api/health`
- MySQL trong Docker: `localhost:3307`

## Tai khoan mau

- `admin / admin123`
- `nhanvien01 / password123`
- `khachhang01 / user123`
- `khachhang02 / user456`

## OTP Gmail

- He thong gui OTP dang ky va quen mat khau bang Gmail `Hoangngocnguyen2006@gmail.com`.
- Khong dung mat khau dang nhap Gmail thuong. Hay tao Gmail App Password va gan vao bien moi truong `APP_MAIL_PASSWORD` truoc khi chay Docker.
- Co the copy `.env.example` thanh `.env`, sau do dien App Password vao `APP_MAIL_PASSWORD`.
- Neu chua cau hinh `APP_MAIL_PASSWORD`, API gui OTP se tra loi loi cau hinh mail thay vi tao tai khoan/dat lai mat khau.

## Cac diem can biet

- Khong can import SQL thu cong neu chay bang Docker stack nay.
- `schema_full.sql` chi duoc MySQL tu dong import khi volume `mysql-data` con trong.
- Neu da chay truoc do va muon nap lai schema/data moi, chay lai:

```powershell
docker compose down -v
docker compose up --build
```

- Port MySQL host la `3307` de tranh xung dot voi MySQL local tren may that.
