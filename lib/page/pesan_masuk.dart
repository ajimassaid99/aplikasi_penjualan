import 'package:flutter/material.dart';

class PesananMasukNotification extends StatelessWidget {
  final int jumlahPesanan;
  final String jenisPembayaran;
  final Function() onProses;

  PesananMasukNotification({
    required this.jumlahPesanan,
    required this.jenisPembayaran,
    required this.onProses,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              '$jumlahPesanan Pesanan Masuk',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Image.asset(
              // URL gambar jenis pembayaran
              'assets/hand.png',
              height: 200,
              width: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 30),
            const Text(
              'No. Pesanan xxxxxx',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Pembayaran Nontunai',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.green, // Ubah warna tombol menjadi hijau
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero, // Tidak ada border bulat
                ),
              ),
              onPressed: onProses,
              child: const Text(
                'Proses',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PesananMasukPage extends StatelessWidget {
  void showPesananMasukNotification(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext ctx) {
        return PesananMasukNotification(
          jumlahPesanan: 5, // Ganti dengan jumlah pesanan yang sesuai
          jenisPembayaran:
              'Transfer Bank', // Ganti dengan jenis pembayaran yang sesuai
          onProses: () {
            // Aksi ketika tombol proses ditekan
            // Implementasikan aksi yang sesuai di sini
            print('Pesanan diproses');
            Navigator.pop(context); // Tutup notifikasi setelah diproses
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contoh Pesanan Masuk'),
        backgroundColor: const Color(0xFF22692D),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showPesananMasukNotification(context);
          },
          child: const Text('Tampilkan Pesanan Masuk'),
        ),
      ),
    );
  }
}
