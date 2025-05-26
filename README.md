# Traveling Salesman Problem Solver (Dynamic Programming)
Program ini menyelesaikan permasalahan **Travelling Salesman Problem (TSP)** menggunakan pendekatan **Dynamic Programming dengan Bitmasking** dalam bahasa **Ruby**.

---

## Cara Kerja Program

TSP adalah masalah pencarian rute minimum untuk mengunjungi setiap kota **sekali saja**, lalu kembali ke kota asal. Program ini menyelesaikan TSP dengan:

- Membangun fungsi `tsp(distance)` yang menerima **matriks jarak antar kota** sebagai input.
- Menggunakan **bitmasking** untuk merepresentasikan kumpulan kota yang telah dikunjungi.
- Menggunakan **memoization** (caching hasil) untuk mempercepat pencarian solusi optimal secara rekursif.
- Setelah menemukan jarak minimum, program juga merekonstruksi dan menampilkan **rute tur optimal**.

Contoh DP state:
- `dp(i, S)` = jarak minimum dari kota `i`, setelah mengunjungi semua kota dalam himpunan `S`, lalu kembali ke kota awal.

---

## Cara Menjalankan

1. **Install Ruby** (jika belum):
   - Windows: [https://rubyinstaller.org/](https://rubyinstaller.org/)
   - Cek instalasi:
     ```bash
     ruby -v
     ```

2. **Jalankan program** dari root direktori proyek:
    ```bash
    ruby src/main.rb
    ```

3. **Masukkan input sesuai instruksi**, contoh:
    ```
    Masukkan jumlah kota:
    4
    Masukkan matriks jarak antar kota (pisahkan dengan spasi):
    0 10 15 20
    10 0 35 25
    15 35 0 30
    20 25 30 0
    ```

4. **Output yang ditampilkan**:
    - Jarak/biaya minimum untuk mengunjungi semua kota.
    - Rute tur optimal yang harus diambil.
    contoh output:
    ```
    Biaya minimum untuk mengunjungi semua kota: 35
    Rute yang harus diambil: 1 -> 2 -> 4 -> 3 -> 1
    ```