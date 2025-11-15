**Tentang Aplikasi**
FreshVeg adalah aplikasi mobile berbasis Flutter yang dirancang untuk membantu pengguna mendeteksi tingkat kesegaran kentang secara otomatis menggunakan teknologi machine learning. 
Aplikasi ini memanfaatkan kamera smartphone atau galeri foto untuk menganalisis kondisi kentang dan memberikan hasil apakah kentang tersebut masih segar atau sudah busuk. Dengan 
antarmuka yang sederhana dan mudah digunakan, FreshVeg cocok digunakan oleh siapa saja yang ingin memastikan kualitas kentang sebelum dimasak atau disimpan.

Fitur Utama:
1.	Pemindaian Real-time: Ambil foto kentang langsung menggunakan kamera untuk mendapatkan hasil deteksi instan
2.	Upload dari Galeri: Pilih foto kentang yang sudah tersimpan di galeri perangkat
3.	Hasil Deteksi Akurat: Menampilkan status kesegaran (Segar/Busuk) dengan tingkat kepercayaan (confidence score)
4.	Riwayat Deteksi: Menyimpan semua hasil pemindaian sebelumnya beserta gambar dan tanggal deteksi
5.	Tips Perawatan: Panduan praktis untuk memilih, menyimpan, dan merawat kentang agar tetap segar

**Cara Menggunakan Aplikasi**
1.	Halaman Awal
    Ketika pertama kali membuka aplikasi, akan muncul logo FreshVeg. Ketuk tombol panah untuk melanjutkan ke halaman beranda.
3.	Halaman Beranda
    Di beranda, terdapat dua pilihan utama:
      •	Mulai Pemindaian Kamera: Langsung membuka kamera untuk mengambil foto kentang
      •	Unggah Gambar Dari Galeri: Memilih foto kentang dari galeri perangkat
    Bagian bawah menampilkan 3 riwayat deteksi terakhir.
4.	Melakukan Deteksi
    Menggunakan Kamera:
      1)	Ketuk "Mulai Pemindaian Kamera"
      2)	Arahkan kamera ke kentang
      3)	Ketuk tombol "Ambil Foto"
      4)	Tunggu proses deteksi selesai
      5)	Lihat hasilnya di halaman hasil
    Menggunakan Galeri:
      1)	Ketuk "Unggah Gambar Dari Galeri"
      2)	Ketuk tombol "Upload"
      3)	Pilih foto kentang dari galeri
      4)	Tunggu proses deteksi selesai
      5)	Lihat hasilnya di halaman hasil
5.	Membaca Hasil Deteksi
    Halaman hasil menampilkan:
      •	Gambar kentang yang dideteksi
      •	Status kesegaran (Segar/Busuk)
      •	Tingkat kepercayaan dalam persentase
      •	Saran penyimpanan atau penanganan
5.	Melihat Riwayat
    Ketuk ikon "Riwayat" di navigasi bawah untuk melihat semua hasil deteksi yang pernah dilakukan beserta tanggal dan statusnya.
6.	Membaca Tips
    Ketuk ikon "Tips" di navigasi bawah untuk membaca panduan tentang cara memilih, menyimpan, dan merawat kentang agar tetap segar.

**Cara Menjalankan Server**
1. Setup Environment
   cd server
   python -m venv venv
   venv\\Scripts\\activate     
3. Install Requirements
   pip install -r requirements.txt
5. Jalankan Server
   uvicorn main:app --host 0.0.0.0 --port 8000 --reload

