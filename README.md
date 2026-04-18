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

Lan dau tien hoac khi muon reset sach database:

```powershell
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

## Cac diem can biet

- Khong can import SQL thu cong neu chay bang Docker stack nay.
- `schema_full.sql` chi duoc MySQL tu dong import khi volume `mysql-data` con trong.
- Neu da chay truoc do va muon nap lai schema/data moi, chay lai:

```powershell
docker compose down -v
docker compose up --build
```

- Port MySQL host la `3307` de tranh xung dot voi MySQL local tren may that.
