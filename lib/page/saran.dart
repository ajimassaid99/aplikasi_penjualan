import 'package:flutter/material.dart';
import 'package:solusi_penjualan_pangan/page/widget/sidebar.dart';

class Saran {
  final String namaPelanggan;
  final String saran;

  Saran({
    required this.namaPelanggan,
    required this.saran,
  });
}

List<Saran> daftarSaran = [
  Saran(
      namaPelanggan: 'John Doe',
      saran: 'Peningkatan kualitas produk sangat diperlukan.'),
  Saran(
      namaPelanggan: 'Jane Smith',
      saran: 'Pelayanan pelanggan perlu ditingkatkan.'),
  Saran(
      namaPelanggan: 'Alex Johnson',
      saran: 'Produk yang ditawarkan sudah sangat baik.'),
  Saran(
      namaPelanggan: 'Emily Davis', saran: 'Harap memperluas variasi produk.'),
];

class SaranList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Saran'),
        centerTitle: true,
        backgroundColor: const Color(0xFF22692D),
      ),
      drawer: Sidebar(),
      body: ListView.builder(
        itemCount: daftarSaran.length,
        itemBuilder: (context, index) {
          final saran = daftarSaran[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            elevation: 3,
            child: ListTile(
              title: Text(
                saran.namaPelanggan,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(saran.saran),
            ),
          );
        },
      ),
    );
  }
}
