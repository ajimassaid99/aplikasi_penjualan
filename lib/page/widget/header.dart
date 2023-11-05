import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});
  Future<String> _getUsername() async {
    // Retrieve the username from local storage
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userName') ??
        'Penjual'; // Use a default username if not found
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 155,
          decoration: const BoxDecoration(
            color: Color(0xFF22692D),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(36),
              bottomRight: Radius.circular(36),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape
                        .circle, // Membuat Container berbentuk lingkaran
                    border: Border.all(
                      color: Colors.white, // Warna border putih
                      width: 3.0, // Lebar border
                    ),
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      "assets/username.png", // Ganti dengan path gambar Anda
                      height: 50,
                      width: 50,
                      color: Colors.white, // Tinggi gambar
                      fit: BoxFit
                          .fitHeight, // Sesuaikan gambar ke dalam lingkaran
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                FutureBuilder<String>(
                  future: _getUsername(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator(); // You can display a loading indicator
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return Column(
                        children: [
                          Text(
                            "Hello ${snapshot.data}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Produk Terbaik Yang Kita Beri Untuk Pembeli",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
                const SizedBox(height: 30),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
