--Membuat tabel sesuai ERD

CREATE TABLE Jabatan(
	ID_Jabatan serial PRIMARY KEY,
	Nama_Jabatan varchar(100) not null,
	Deskripsi text
)

CREATE TABLE Pegawai(
	ID_Pegawai varchar(20) PRIMARY KEY,
	Nama_Pegawai varchar(100) not null,
	Alamat_Kota varchar(30) not null,
	Alamat_Provinsi varchar(30) not null,
	Gender varchar(10) not null,
	Nomor_Telepon bigint not null,
	ID_Jabatan integer not null --fk
)

CREATE TABLE Jenis_Hewan(
	ID_Jenis_Hewan serial PRIMARY KEY,
	Jenis_Hewan varchar(25),
	Deskripsi text
)

CREATE TABLE Hewan(
	ID_Hewan serial PRIMARY KEY,
	Nama_Hewan varchar(50) not null, 
	Jenis_Kelamin varchar(10) not null,
	Umur integer not null,
	ID_Jenis_Hewan integer not null --fk
)

CREATE TABLE Kandang(
	ID_Kandang varchar(20) PRIMARY KEY,
	Ukuran varchar(20) not null,
	Deskripsi text
)

CREATE TABLE Customer(
	ID_Customer serial PRIMARY KEY,
	Nama_Customer varchar(100) not null,
	Nomor_Telepon bigint not null,
	Alamat_Kota varchar(30) not null,
	Alamat_Customer varchar(30) not null
)

--supertype and subtypes--

CREATE TABLE Pembayaran ( --Supertype of :
    ID_Pembayaran serial PRIMARY KEY,
    Deskripsi text
)

CREATE TABLE Debit(
    ID_Pembayaran integer not null, --fk pk
    Nama_Bank varchar(20) not null,
    Nomor_Rekening bigint not null
)

CREATE TABLE EWallet(
    ID_Pembayaran integer not null, --fk pk
    Nama_E_Wallet varchar(30) not null,
    Nomor_Telepon bigint not null
)

CREATE TABLE Cash(
    ID_Pembayaran integer not null, --fk pk
    Jumlah_Pembayaran bigint not null,
	Nomor_telepon bigint not null
)

-------------------

CREATE TABLE Transaksi(
	ID_Transaksi integer PRIMARY KEY,
	Tgl_Penitipan date not null, 
	Tgl_Pengambilan date not null, 
	ID_Hewan integer not null, --fk
	Id_Pegawai varchar(20) not null, --fk
	ID_Customer integer not null, --fk
	ID_Kandang varchar(20) not null, --fk
	ID_Pembayaran integer not null --fk
)

CREATE TABLE Detail_Transaksi(
    ID_Layanan varchar(20) not null, --pf
    ID_Transaksi integer not null, --pf
	Deskripsi text
)

CREATE TABLE Layanan (
    ID_Layanan varchar(20) PRIMARY KEY,
    Nama_layanan varchar(100) not null,
	Harga numeric not null,
    Deskripsi text
)

--Menjadikan sebuah attribut menjadi secondary uid--

ALTER TABLE Pegawai
ADD CONSTRAINT NomorTelepon UNIQUE (Nomor_Telepon)

ALTER TABLE Customer
ADD CONSTRAINT Nomor_Telepon UNIQUE (Nomor_Telepon)

ALTER TABLE Cash
ADD CONSTRAINT NomorTelepon UNIQUE (Nomor_Telepon)

--Menambahkan Foreign Key di setiap entitas yang memiliki--

ALTER TABLE Pegawai
ADD CONSTRAINT fk_Jabatan
FOREIGN KEY (ID_Jabatan)
REFERENCES Jabatan(ID_Jabatan)

ALTER TABLE Hewan
ADD CONSTRAINT fk_Jenis_Hewan
FOREIGN KEY (ID_Jenis_Hewan)
REFERENCES Jenis_Hewan(ID_Jenis_Hewan)

ALTER TABLE Transaksi
ADD CONSTRAINT fk_Customer
FOREIGN KEY (ID_Customer)
REFERENCES Customer(ID_Customer)

ALTER TABLE Transaksi
ADD CONSTRAINT fk_Hewan
FOREIGN KEY (ID_Hewan)
REFERENCES Hewan(ID_Hewan)

ALTER TABLE Transaksi
ADD CONSTRAINT fk_Kandang
FOREIGN KEY (ID_Kandang)
REFERENCES Kandang(ID_Kandang)

ALTER TABLE Transaksi
ADD CONSTRAINT fk_Pegawai
FOREIGN KEY (ID_Pegawai)
REFERENCES Pegawai(ID_Pegawai)

ALTER TABLE Transaksi
ADD CONSTRAINT fk_Pembayaran
FOREIGN KEY (ID_Pembayaran)
REFERENCES Pembayaran(ID_Pembayaran)

ALTER TABLE Detail_Transaksi
ADD CONSTRAINT fk_Transaksi
FOREIGN KEY (ID_Transaksi)
REFERENCES Transaksi(ID_Transaksi)

ALTER TABLE Detail_Transaksi
ADD CONSTRAINT fk_Layanan
FOREIGN KEY (ID_Layanan)
REFERENCES Layanan(ID_Layanan)

--Memberi primary key pada entity persimpangan--

ALTER TABLE Detail_Transaksi 
ADD Primary Key (ID_Layanan, ID_Transaksi)


--Memberi default output pada tiap tabel dengan kolom deskripsi

ALTER TABLE Jabatan
ALTER COLUMN Deskripsi SET DEFAULT 'Tidak ada keterangan'

ALTER TABLE Jenis_Hewan
ALTER COLUMN Deskripsi SET DEFAULT 'Tidak ada keterangan'

ALTER TABLE Kandang
ALTER COLUMN Deskripsi SET DEFAULT 'Tidak ada keterangan'

ALTER TABLE Detail_Transaksi
ALTER COLUMN Deskripsi SET DEFAULT 'Tidak ada keterangan'

ALTER TABLE Pembayaran
ALTER COLUMN Deskripsi SET DEFAULT 'LUNAS'

--insert data ke database--

INSERT INTO Jenis_Hewan (Jenis_Hewan, Deskripsi)
VALUES ('Kucing', 'Komunikasikan masalah kucing anda dengan pegawai kami')

INSERT INTO Jenis_Hewan (Jenis_Hewan)
VALUES ('Anjing'),('Kelinci')

INSERT INTO Jenis_Hewan (Jenis_Hewan, Deskripsi)
VALUES ('Hamster', 'Untuk keamanan hamster, minimal berumur 3 bulan')

INSERT INTO Hewan (Nama_Hewan, Jenis_Kelamin, Umur, ID_Jenis_Hewan)
VALUES	('Coco Chloe', 'Jantan', '5 Bulan', 2)
		('Ollie Popper', 'Betina', '1 Tahun', 1),
		('Polly Pocket', 'Jantan', '1.5 Tahun', 2),
		('Calvin Bob', 'Jantan', '8 Bulan', 4),
		('Maggie Lucy', 'Betina', '2 Tahun', 3),
		('Pixie Penelope', 'Betina', '4 Bulan', 1),
		('Tom Winston', 'Jantan', '5 Bulan', 4)
		('Belle Boo', 'Betina', '3 Tahun', 1),
		('Lucky Penelope', 'Betina', '7 Bulan', 2),
		('Ozzy Theo', 'Jantan', '9 Bulan', 4),
		('Olive Zoe', 'Betina', '1.7 Tahun', 3),
		('Thor Murphy', 'Jantan', '8 Bulan', 1),
		('Sam Theo', 'Jantan', '1.3 Tahun', 4)
		
INSERT INTO Jabatan (Nama_Jabatan, Deskripsi)
VALUES	('Manager Petshop', 'Memanagement segala urusan pada petshop'),
		('Perawat', 'Bertugas dalam perawatan hewan peliharaan customer'),
		('Admin', 'Bertugas untuk mengurus administrasi customer'),
		('Dokter Hewan', 'Merawat dan memeriksa kesehatan hewan peliharaan customer'),
		('Petugas Kebersihan', 'Menjaga area petshop agar tetap bersih dan nyaman')

INSERT INTO Pegawai (ID_Pegawai, Nama_Pegawai, Alamat_Kota, Alamat_Provinsi, Gender, Nomor_Telepon, ID_Jabatan)
VALUES	('2CR01', 'Monica Caroline', 'Medan', 'Sumatera Utara', 'Perempuan', 08187710291, 2),
		('4DRH01', 'Irfan Zein', 'Pontianak', 'Kalimantan Barat', 'Laki-Laki', 0896302417, 4),
		('3ABP01', 'Mani ah Mellow', 'Sidoarjo', 'Jawa Timur', 'Perempuan', 089677779117, 3),
		('2CR02', 'Adini Regina', 'Simalungun', 'Sumatera Utara', 'Perempuan', 085270079377, 2),
		('1MBP01', 'Farel Alfaro', 'Gresik', 'Jawa Timur', 'Laki-Laki', 082140327545, 1),
		('4DRH02', 'Kartika Indah', 'Probolinggo', 'Jawa Timur', 'Perempuan', 081331611825, 4),
		('5PK01', 'Darvin Emilio', 'Bandung', 'Jawa Barat', 'Laki-Laki', 08536199211, 5),
		('5PK02', 'Siti Jasmin', 'Solo', 'Jawa Tengah', 'Perempuan', 081241587223, 5)

INSERT INTO Kandang (ID_Kandang, Ukuran, Deskripsi)
VALUES	('KD01A', '60x50x70', 'Terisi'),
		('KD02A', '60x50x70', 'Tersedia'),
		('KD03A', '60x50x70', 'Tersedia'),
		('KD04A', '60x50x70', 'Tersedia'),
		('KD05B', '200x90x100', 'Terisi'),
		('KD06B', '200x90x100', 'Terisi'),
		('KD07B', '80x60x90', 'Terisi'),
		('KD08B', '80x60x90', 'Tersedia'),
		('KD09C', '20x30x45', 'Tersedia'),
		('KD10C', '20x30x45', 'Tersedia'),
		('KD11C', '20x30x45', 'Tersedia'),
		('KD12C', '20x30x45', 'Tersedia'),
		('KD13D', '60x50x70', 'Tersedia'),
		('KD14D', '60x50x70', 'Tersedia'),
		('KD15D', '60x50x70', 'Tersedia'),
		('KD16D', '60x50x70', 'Tersedia')
		
--supertype and subtypes

INSERT INTO Pembayaran
VALUES (1),
       (2),
       (3)

INSERT INTO Debit(ID_Pembayaran, Nama_Bank, Nomor_Rekening)
VALUES (1, 'BCA', 125457700)

INSERT INTO EWallet(ID_Pembayaran, Nama_E_Wallet, Nomor_Telepon)
VALUES  (2,'ShopeePay', 082134768800),
		(2, 'Dana', 086680665440)

INSERT INTO Cash(ID_Pembayaran, Nomor_Telepon, Jumlah_Pembayaran)
VALUES (3, 086680665440, 260000)

--------

INSERT INTO Customer(Nama_Customer, Nomor_Telepon, Alamat_Kota, Alamat_Provinsi)
VALUES	('Mellow Kusmiyana', 082134768800, 'Sidoarjo', 'Jawa Timur'),
		('Dheo Ariansyah', 086680665440, 'Banyuwangi', 'Jawa Timur'),
		('Isabela Aritonang', 084455667788, 'Probolinggo', 'Jawa Timur'),
		('Fayza Situmorang', 082166655577, 'Pamekasan', 'Jawa Timur')
		
INSERT INTO layanan(id_layanan, nama_layanan, harga, deskripsi)
VALUES  ('LN01', 'Daycare', 50.000, 'Per-Hari'),
		('LN02', 'Grooming', 30.000, 'Full Paket Kebersihan Hewan Peliharaan Anda'),
		('LN03', 'Vitamin', 20.000, 'Extra Vitamin Saat Penitipan'),
		('LN04', 'Vaksinasi', 40.000, 'Hindari Peliharaan Anda Dari Penyakit'),
		('LN05', 'Cek Kesehatan', 10.000, 'Periksa Kesehatan Hewan Anda')


INSERT INTO Transaksi (Tgl_Penitipan, Tgl_Pengambilan, id_hewan, id_pegawai, id_customer, id_kandang, id_pembayaran)
VALUES  ('2023-05-01', '2023-05-05', 1, '2CR02', 1, 'KD05B', 2),
		('2023-05-01', '2023-05-01', 2, '4DRH01', 2, 'KD01A', 3),
		('2023-05-01', '2023-05-03', 3, '2CR01', 3, 'KD06B', 2),
		('2023-05-01', '2023-05-06', 4, '2CR02', 4, 'KD07B', 1)

INSERT INTO Detail_Transaksi (id_layanan, id_transaksi)
VALUES  ('LN01', 5), ('LN02', 5),
		('LN03', 6), ('LN04', 6),
		('LN01', 7), ('LN04', 7),
		('LN01', 8), ('LN02', 8), ('LN03', 8)
		

select * from pembayaran
select * from pegawai
select * from jenis_hewan
select * from customer
select * from hewan
select * from detail_transaksi
select * from debit
select * from ewallet
select * from layanan
select * from transaksi