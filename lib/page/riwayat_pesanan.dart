import 'package:flutter/material.dart';
import 'package:solusi_penjualan_pangan/page/widget/sidebar.dart';

class Pesanan {
  final String nama;
  final String nomorPesanan;
  final double harga;
  final String status;

  Pesanan({
    required this.nama,
    required this.nomorPesanan,
    required this.harga,
    required this.status,
  });
}

List<Pesanan> daftarPesanan = [
  Pesanan(
      nama: 'Pesanan 1',
      nomorPesanan: '12345',
      harga: 100.0,
      status: 'Berhasil'),
  Pesanan(
      nama: 'Pesanan 2', nomorPesanan: '67890', harga: 150.0, status: 'Gagal'),
  Pesanan(
      nama: 'Pesanan 3',
      nomorPesanan: '24680',
      harga: 200.0,
      status: 'Berhasil'),
  Pesanan(
      nama: 'Pesanan 4',
      nomorPesanan: '13579',
      harga: 75.0,
      status: 'Berhasil'),
];

// Widget untuk menampilkan list pesanan
class RiwayatPesananList extends StatelessWidget {
  Color getStatusColor(String status) {
    switch (status) {
      case 'Gagal':
        return Colors.red;
      case 'Berhasil':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Riwayat"),
        centerTitle: true,
        backgroundColor: const Color(0xFF22692D),
      ),
      body: ListView.builder(
        itemCount: daftarPesanan.length,
        itemBuilder: (context, index) {
          final pesanan = daftarPesanan[index];
          return Container(
            margin: EdgeInsets.symmetric(
                vertical: 8, horizontal: 16), // Memberikan margin luar
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey), // Menambahkan border
              borderRadius: BorderRadius.circular(8), // Mengatur border radius
            ),
            child: ListTile(
              title: Text(pesanan.nama),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nomor Pesanan: ${pesanan.nomorPesanan}'),
                  Text('Harga: ${pesanan.harga.toString()}'),
                ],
              ),
              trailing: Container(
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: getStatusColor(pesanan.status),
                ),
                child: Text(
                  pesanan.status,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          );
        },
      ),
      drawer: Sidebar(), // Anda dapat menambahkan drawer jika diperlukan
    );
  }
}
