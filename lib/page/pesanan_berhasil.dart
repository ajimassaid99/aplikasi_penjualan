import 'package:flutter/material.dart';
import 'package:solusi_penjualan_pangan/page/home_pembeli.dart';

class PesananBerhasil extends StatelessWidget {
  PesananBerhasil();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Center(
                child: Text(
                  'Terima Kasih Telah Melakukan Pemesanan ',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 32),
              Image.asset(
                'assets/pesanaBerhasil.png',
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 30),
              const Text(
                'Pesananmu Sedang diproses ',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green, // Ubah warna tombol menjadi hijau
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero, // Tidak ada border bulat
                  ),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePembeli()));
                },
                child: const Text(
                  'Back To Home',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
