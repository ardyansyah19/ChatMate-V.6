# ChatMate

Aplikasi chat mobile bergaya WhatsApp, dibangun dengan **Flutter/Dart**. Semua fitur pengiriman **teks, foto, video, dan dokumen benar-benar berfungsi** (bukan simulasi tampilan saja) — memakai kamera/galeri asli perangkat dan file system asli.

## Fitur

- Daftar chat (list) dengan avatar, status online, badge belum dibaca, pin, tab **Semua / Belum dibaca / Grup**, dan pencarian
- Halaman chat (detail) dengan bubble hijau khas WhatsApp, centang status (mengirim → terkirim → diterima → dibaca/biru)
- Kirim **pesan teks**
- Kirim **foto** dari galeri atau kamera — tampil sebagai thumbnail, tap untuk lihat penuh layar (bisa di-zoom)
- Kirim **video** dari galeri atau rekam dari kamera — tap untuk diputar di dalam aplikasi
- Kirim **dokumen** apa saja (PDF, Word, Excel, dll) — tampil sebagai kartu file dengan nama & ukuran, tap untuk dibuka pakai aplikasi bawaan HP
- Balasan otomatis singkat dari kontak (biar chat terasa hidup) setelah pesan kamu "dibaca"
- Mode gelap otomatis mengikuti sistem HP

## Struktur Proyek

```
lib/
 ├── main.dart                     # Entry point aplikasi
 ├── models/                       # Model data (Chat, Message)
 ├── data/                         # Data awal (dummy contacts)
 ├── theme/                        # Warna & tema (light/dark)
 ├── utils/                        # Helper format tanggal & ukuran file
 ├── widgets/                      # Komponen UI (bubble, tile, avatar, attachment sheet)
 └── screens/                      # Halaman (list chat, detail chat, viewer foto/video)
```

## Cara Menjalankan

Karena kode ini dikirim sebagai source code Dart murni (tanpa folder `android/` dan `ios/`, yang sifatnya boilerplate hasil generate), ikuti langkah berikut:

### 1. Pastikan Flutter SDK sudah terpasang
```bash
flutter doctor
```

### 2. Buat project Flutter kosong sebagai wadah
```bash
flutter create chatmate_app
```

### 3. Timpa isi project kosong dengan file dari zip ini
Salin (dan timpa) folder/file berikut dari hasil unduhan ke dalam `chatmate_app/`:
- `lib/` (timpa seluruhnya)
- `pubspec.yaml` (timpa)
- `assets/`
- `analysis_options.yaml`

### 4. Install dependency
```bash
cd chatmate_app
flutter pub get
```

### 5. Tambahkan izin akses kamera, galeri, dan penyimpanan

**Android** — buka `android/app/src/main/AndroidManifest.xml`, tambahkan di dalam tag `<manifest>` (sebelum `<application>`):
```xml
<uses-permission android:name="android.permission.CAMERA"/>
<uses-permission android:name="android.permission.READ_MEDIA_IMAGES"/>
<uses-permission android:name="android.permission.READ_MEDIA_VIDEO"/>
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
```
Pastikan juga `minSdkVersion` di `android/app/build.gradle` (atau `build.gradle.kts`) minimal **21**.

**iOS** — buka `ios/Runner/Info.plist`, tambahkan sebelum `</dict>` penutup terakhir:
```xml
<key>NSCameraUsageDescription</key>
<string>ChatMate membutuhkan akses kamera untuk mengambil foto dan video</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>ChatMate membutuhkan akses galeri untuk memilih foto dan video</string>
<key>NSMicrophoneUsageDescription</key>
<string>ChatMate membutuhkan akses mikrofon untuk merekam video</string>
```

### 6. Jalankan aplikasi
```bash
flutter run
```

## Catatan

- File yang dikirim (foto/video/dokumen) diambil langsung dari path asli file di HP kamu (lewat `image_picker` & `file_picker`), lalu ditampilkan dan bisa dibuka kembali lewat `open_filex` — semuanya berjalan lokal di perangkat, tanpa server/backend.
- Data chat saat ini disimpan di memori (hilang saat aplikasi ditutup total). Kalau nanti kamu mau riwayat chat tersimpan permanen, tinggal tambahkan database lokal seperti `sqflite` atau `hive` — beri tahu saya kalau mau saya bantu lanjutkan.
- Nama-nama kontak & pesan awal di daftar chat hanyalah data contoh (dummy) supaya tampilan tidak kosong saat pertama dibuka — semua tetap bisa dipakai kirim pesan sungguhan.
