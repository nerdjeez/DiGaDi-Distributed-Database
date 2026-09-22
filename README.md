# DiGaDi (Distributed Game Distribution)

Membangun arsitektur basis data terdistribusi heterogen (PostgreSQL & MariaDB) lintas OS. Mengimplementasikan fragmentasi vertikal-horizontal dan *fragmentation transparency* secara *real-time* murni di level *database* menggunakan MariaDB CONNECT Engine (ODBC), menghasilkan sistem federasi data yang efisien tanpa membebani *layer* aplikasi.

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)
![MariaDB](https://img.shields.io/badge/MariaDB-003545?style=for-the-badge&logo=mariadb&logoColor=white)
![Windows 11](https://img.shields.io/badge/Windows_11-0078D4?style=for-the-badge&logo=windows&logoColor=white)
![Linux Mint](https://img.shields.io/badge/Linux_Mint-87A556?style=for-the-badge&logo=linux-mint&logoColor=white)

## Fitur Utama Arsitektur
1. **Sistem Terdistribusi Heterogen:** Menyatukan dua mesin RDBMS yang berbeda (PostgreSQL dan MariaDB) yang berjalan di atas dua Sistem Operasi yang berbeda.
2. **Fragmentasi Vertikal:** Memisahkan kolom berat (teks deskripsi *game*) ke *node* lokal untuk menghemat I/O *server* utama.
3. **Fragmentasi Horizontal (Derived):** Memotong baris tabel transaksi (*library* dan *wishlist*) berdasarkan region/negara (*user country*).
4. **Transparansi Fragmentasi Murni Database:** Aplikasi membaca satu tabel utuh (`games_utuh`) tanpa perlu mengetahui bahwa di belakang layar terjadi *Cross-Node JOIN* menggunakan protokol ODBC.

## Topologi & Arsitektur Sistem

![Diagram Arsitektur DiGaDi](docs\DiGaDi-architecture.png)

## Struktur Repositori

```text
DiGaDi-Distributed-Database/
├── node1-postgresql/
│   ├── node1_schema.sql      # DDL Master (Tabel Global & Fragmen V1)
│   └── node1_seed.sql        # Data Dummy Sistem Global
├── node2-mariadb/
│   ├── node2_schema.sql      # DDL Lokal, Tabel CONNECT (Bridge), & Tabel Federasi
│   └── node2_seed.sql        # Data Dummy Fisik Regional Linux
└── README.md
```

## Panduan Instalasi (Reproducibility)

### 1. Konfigurasi Node 1 (Windows 11)
- Pastikan PostgreSQL berjalan pada mesin Windows (menggunakan *port* `5433` pada lingkungan uji ini).
- Eksekusi *file* `node1_schema.sql` untuk membangun struktur tabel dan *sequence*.
- Eksekusi *file* `node1_seed.sql` untuk memasukkan data awal.
- Konfigurasi *file* `pg_hba.conf` dan `postgresql.conf` agar PostgreSQL menerima koneksi dari alamat IP VM atau jaringan Node 2.

### 2. Konfigurasi Node 2 (Linux Mint)
- Pastikan MariaDB berjalan dan *driver* `psqlODBC` (*PostgreSQL ODBC driver untuk Linux*) telah terpasang di sistem.
- Modifikasi *file* konfigurasi `/etc/odbc.ini` pada OS Linux agar *Data Source Name* (DSN) mengarah ke IP PostgreSQL Windows (`192.168.56.1:5433`).
- Masuk ke antarmuka baris perintah MariaDB sebagai `root` dan buat pengguna khusus untuk memotong restriksi `unix_socket` dalam koneksi *loopback*:
  ```sql
  CREATE USER IF NOT EXISTS 'penghubung'@'127.0.0.1' IDENTIFIED BY 'buka_pintu';
  GRANT ALL PRIVILEGES ON digadi_node2.* TO 'penghubung'@'127.0.0.1';
  FLUSH PRIVILEGES;
  ```
- Eksekusi `node2_schema.sql` untuk mendirikan jembatan federasi dan tabel fisik lokal.
- Eksekusi `node2_seed.sql` untuk menyuntikkan data transaksi regional.

## Pembuktian Transparansi Fragmentasi

Setelah instalasi selesai, sistem transparansi dan sinkronisasi lintas *platform* dapat diuji langsung dari terminal Node 2 (MariaDB Linux Mint).

**Mengintip Rencana Eksekusi (Query Execution Plan):**
Menjalankan perintah `EXPLAIN` membuktikan bahwa *engine* MariaDB mengambil peran orkestrasi; menarik kueri dari PostgreSQL via jembatan `games_v1_remote` lalu menggabungkannya dengan fragmen lokal `games_v2`.
```sql
EXPLAIN SELECT * FROM games_utuh;
```

**Pembuktian Integrasi Data Real-Time:**
Data *frontend* dapat ditarik secara logis menggunakan satu kueri *SELECT* sederhana pada tabel campuran tanpa perlu mengetahui letak fisik fragmen data.
```sql
SELECT title, price, description FROM games_utuh WHERE game_id = 1;
```
*(Setiap operasi mutasi, seperti pembaruan nilai `price` di lingkungan Node 1 Windows, akan langsung terefleksikan pada penarikan kueri `games_utuh` di Node 2 Linux secara instan).*