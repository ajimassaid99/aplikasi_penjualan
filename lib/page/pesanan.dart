import 'package:flutter/material.dart';
import 'package:solusi_penjualan_pangan/page/widget/sidebar.dart';

// Class untuk menyimpan informasi pesanan
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

// Contoh data pesanan
List<Pesanan> daftarPesanan = [
  Pesanan(
      nama: 'Pesanan 1',
      nomorPesanan: '12345',
      harga: 100.0,
      status: 'Diproses'),
  Pesanan(
      nama: 'Pesanan 2',
      nomorPesanan: '67890',
      harga: 150.0,
      status: 'Dikirim'),
  Pesanan(
      nama: 'Pesanan 3',
      nomorPesanan: '24680',
      harga: 200.0,
      status: 'Selesai'),
  Pesanan(
      nama: 'Pesanan 4',
      nomorPesanan: '13579',
      harga: 75.0,
      status: 'Di Batalkan'),
];

// Widget untuk menampilkan list pesanan
class PesananList extends StatelessWidget {
  Color getStatusColor(String status) {
    switch (status) {
      case 'Dibatalkan':
        return Colors.red;
      case 'Diproses':
        return Colors.orange;
      case 'Dikirim':
        return Colors.blue;
      case 'Selesai':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pesanan"),
        centerTitle: true,
        backgroundColor: const Color(0xFF22692D),
      ),
      body: ListView.separated(
        itemCount: daftarPesanan.length,
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemBuilder: (context, index) {
          final pesanan = daftarPesanan[index];
          return ListTile(
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
          );
        },
      ),
      drawer: Sidebar(), // Anda dapat menambahkan drawer jika diperlukan
    );
  }
}
