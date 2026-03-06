# Tutorial 4 Game Development

**Nama:** Muhammad Fawwaz Edsa Fatin S  
**NPM:** 2306275582

---

## Latihan Mandiri

Pada tutorial ini, saya telah mengimplementasikan pembuatan level 2D dasar menggunakan `TileMapLayer`, sistem interaksi antar objek menggunakan *signal*, pembuatan objek secara dinamis menggunakan *spawner*, serta membangun level baru secara mandiri untuk memenuhi kriteria Latihan Mandiri.

Berikut adalah fitur dan elemen level lanjutan yang telah saya kembangkan beserta penjelasan implementasinya:

### 1. Desain Level Baru (Tema Salju)
Saya membuat level baru (`Level2.tscn`) dengan tata letak rintangan *platforming* yang lebih menantang, serta menggunakan aset visual yang sama sekali berbeda dari level pertama.
* **Proses Pengerjaan:** Saya menambahkan node `TileMapLayer` dan mengonfigurasi *TileSet* baru menggunakan *spritesheet* bertema salju/es. Saya mengatur ukuran *tile* menjadi 128x128 dan mengaktifkan `Physics Layer 0`. Bentuk kolisi (*collision polygon*) digambar pada masing-masing *tile* lantai agar karakter dapat berpijak dengan tepat tanpa terjatuh menembus peta.

### 2. Rintangan Statis (Spikes)
Saya menambahkan rintangan diam berupa duri tajam (`Spike.tscn`) yang diletakkan di atas lantai level untuk membatasi ruang gerak pemain.
* **Proses Pengerjaan:** Rintangan ini dibangun menggunakan `Area2D` sebagai *root node*, dipadukan dengan `Sprite2D` dan `CollisionShape2D`. Saya menyambungkan *signal* `body_entered` ke dalam *script* rintangan. Jika entitas bernama "Player" memasuki area kolisi tersebut, sistem akan memanggil fungsi `change_scene_to_file` untuk memuat *scene* kekalahan.

### 3. Rintangan Dinamis & Spawner (Hujan Bom)
Sebagai variasi dari rintangan ikan di level pertama, saya membuat rintangan hujan bom (`bom.tscn`) yang berjatuhan dari langit untuk menambah tingkat kesulitan.
* **Proses Pengerjaan:** Bom dibuat menggunakan `RigidBody2D` agar memiliki fisika gravitasi untuk jatuh secara alami. Untuk mendeteksi tabrakan dengan akurat, saya menambahkan `Area2D` sebagai sensor area. Jika mengenai "Player", game berakhir. Namun, jika menabrak objek lain (`elif body != self`) seperti lantai TileMap, bom memanggil perintah `queue_free()` agar langsung hancur. Node *spawner* diprogram menggunakan `instantiate()` untuk memunculkan bom pada koordinat sumbu X yang diacak setiap detiknya.

### 4. Auto-Restart Lose Screen
Saya membuat layar kalah (`LoseScreen2.tscn`) yang secara otomatis memuat ulang Level 2 tanpa memerlukan input tambahan dari pemain, membuat *gameplay loop* menjadi lebih lancar.
* **Proses Pengerjaan:** Saya menduplikat *scene* kekalahan awal dan menyematkan *script* baru. Pada fungsi awal, saya menggunakan baris kode `await get_tree().create_timer(2.0).timeout` untuk menjeda layar kekalahan selama 2 detik. Setelah *timer* tersebut habis, fungsi `change_scene_to_file("res://scenes/Level2.tscn")` otomatis dieksekusi untuk mereset permainan kembali ke titik awal Level 2.

### 5. Double Jump
Karakter dapat melompat maksimal dua kali sebelum menyentuh tanah untuk membantu navigasi *platforming* melewati rintangan dan jurang di Level 2.
* **Proses Pengerjaan:** Saya menambahkan variabel `max_jumps = 2` dan `jump_count = 0` pada *script* `Player.gd`. Setiap kali karakter terdeteksi menginjak lantai (`is_on_floor()`), nilai `jump_count` otomatis di-reset menjadi 0. Ketika tombol lompat ditekan (aksi `jump`), sistem akan mengecek apakah `jump_count < max_jumps`. Jika kondisi terpenuhi, sistem akan memberikan gaya vertikal (`velocity.y = jump_speed`) untuk membuat karakter melompat, lalu nilai `jump_count` bertambah 1.
---

## Referensi
* [Godot Engine Documentation: Using TileMaps](https://docs.godotengine.org/en/stable/tutorials/2d/using_tilemaps.html)
* [Godot Engine Documentation: Using Signals](https://docs.godotengine.org/en/stable/getting_started/step_by_step/signals.html)
