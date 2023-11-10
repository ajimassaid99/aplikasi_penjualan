import 'package:flutter/material.dart';
import 'package:solusi_penjualan_pangan/page/dashboard_penjual.dart';
import 'package:solusi_penjualan_pangan/page/dashboard_user.dart';
import 'package:solusi_penjualan_pangan/page/login.dart';
import 'package:solusi_penjualan_pangan/page/loginPenjual.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
    checkUserRoleAndNavigate();
  }

  void checkUserRoleAndNavigate() async {
    final preferences = await SharedPreferences.getInstance();
    final userRole = preferences.getString('userRole') ?? '';

    if (userRole == 'pembeli') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const DashboardUserPage(),
        ),
      );
    } else if (userRole == 'penjual') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const DashboardPenjualPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Column(
                children: [
                  const Text('Silakan hubungi pusat bantuan'),
                  GestureDetector(
                    onTap: () {
                      launchWhatsApp(); // Fungsi untuk membuka WhatsApp
                    },
                    child: const Text(
                      'WhatsApp 081362280934',
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        tooltip: 'Bantuan', // Ini akan muncul saat tombol dihover
        child: const Icon(Icons.headset_mic),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 20),
              const Text(
                'Aplikasi Solusi',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Itim',
                  letterSpacing: 0.0,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Penjualan Makanan',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Itim',
                  letterSpacing: 0.0,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'di Kecamatan Kemuning',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Itim',
                  letterSpacing: 0.0,
                ),
              ),
              const SizedBox(height: 80),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Image.asset('assets/welcome.png', fit: BoxFit.fitWidth),
              ),
              const SizedBox(height: 10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Masuk Sebagai:          ',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Itim',
                      letterSpacing: 0.0,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  )
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const LoginPenjualPage(), // Ganti dengan nama halaman login Anda
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(
                      0xFF22692D), // Warna latar belakang sesuai dengan kode warna yang diberikan
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        0), // Tidak ada sudut yang terbulat
                    side: const BorderSide(
                        width: 2,
                        color: Colors
                            .transparent), // Ketebalan border (untuk memberikan ukuran)
                  ),
                  minimumSize: const Size(
                      306, 45), // Atur lebar dan tinggi sesuai kebutuhan
                ),
                child: const Text(
                  'Penjual',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Itim',
                    letterSpacing: 0.0,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Atau',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Itim',
                  letterSpacing: 0.0,
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const LoginPage(), // Ganti dengan nama halaman login Anda
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(
                      0xFF22692D), // Warna latar belakang sesuai dengan kode warna yang diberikan
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        0), // Tidak ada sudut yang terbulat
                    side: const BorderSide(
                        width: 2,
                        color: Colors
                            .transparent), // Ketebalan border (untuk memberikan ukuran)
                  ),
                  minimumSize: const Size(
                      306, 45), // Atur lebar dan tinggi sesuai kebutuhan
                ),
                child: const Text(
                  'Pembeli',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Itim',
                    letterSpacing: 0.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void launchWhatsApp() async {
    final url = Uri.https('wa.me', '+6281362280934');

    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
