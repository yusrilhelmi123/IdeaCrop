# IdeaCrop

**IdeaCrop - Harvest Your Thoughts**
Aplikasi pengumpulan ide yang dirancang khusus untuk membantu para inovator menangkap dan membudidayakan inspirasi secara praktis, kapan saja dan di mana saja.

## Fitur Utama

- **Layar Pembuka Interaktif (_Splash Screen_)**
  Menyambut Anda dengan salam dinamis yang otomatis menyesuaikan waktu lokal perangkat Anda (Pagi/Siang/Sore/Malam), memberikan sentuhan magis sebelum masuk ke sistem.
  
- **Dashboard Grid Modern & Jam _Real-Time_**
  Tidak seperti aplikasi pencatat biasa, aplikasi ini memiliki tampilan *dashboard* berbentuk rak *grid/ikon* sehingga kumpulan ide Anda menyala seperti "lampu bohlam gagasan". Lengkap dengan jam pintar _real-time_ di posisi atas untuk manajemen sesi.
  
- **Sistem _Tagging_ Visual**
  Kategorikan berbagai gagasan berlian Anda dengan entri tag pintar. Ketik nama kategori, lalu tekan **(+)**, dan saksikan stiker kategorinya bermunculan. Memudahkan saat pencarian skala besar!

- **Gudang Referensi Fleksibel**
  Sebuah ide butuh fondasi? Tambahkan link URL web, YouTube, atau judul buku spesifik TANPA adanya batas! Sistem _list referensi otomatis_ di halaman detail akan menjajarkannya dengan rapi.

- **Penyimpanan Instan & Aman (*Offline-First*)**
  Dilengkapi dengan integrasi `Hive` database yang *ultra-fast*. Tak perlukan internet. Semua aset karya pikiran Anda dijamin tersimpan aman di memori lokal smartphone Anda.

## Teknologi Pendahulu (Stack)

- **Flutter / Dart** (SDK ^3.11.1)
- **Riverpod** - *State management* interaktif tingkat atas
- **Hive** - Penyimpanan NoSQL berkecepatan tinggi (*local database*)
- **Intl** - Manajemen tanggal & zona waktu dinamis
- **Flutter Launcher Icons** - Standarisasi visual identitas di _Home Screen_

## Cara Menjalankan (*How to Run*)

Pastikan Anda telah memasang **Flutter SDK** versi 3.11 ke atas.

1. **Jalankan Terminal** pada *root folder* proyek ini (`IdeaCrop`).
2. Pasang semua dependensi yang dibutuhkan:
   ```bash
   flutter pub get
   ```
3. Mulai kompilasi simulator/*device* yang tersambung:
   ```bash
   flutter run
   ```

*(Apabila Anda mengalami masalah "Not recognized / Spasi", pastikan nama folder root (_Path_) dari direktori tempat menaruh source code ini **TIDAK MENGANDUNG SPASI** dan pastikan environment variable flutter telah diarahkan pada letak instalasi yang benar).*

## Mengemas ke bentuk APK 

Untuk mencetak aplikasi ke bentuk _release_ APK untuk smartphone asli Anda, jalankan perintah singkat berikut:
```bash
flutter build apk --release
```
Bila berhasil, Anda dapat mencabut dan menemukan file `.apk` instalasinya di direktori: 
`\build\app\outputs\flutter-apk\app-release.apk`

---
*Didesain dan diprogram khusus untuk mencatat lompatan besar Anda.* 
**@Developer:** Yusrilizer | Versi 1.0.0
