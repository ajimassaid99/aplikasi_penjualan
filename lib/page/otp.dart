import 'package:flutter/material.dart';

class OTPPage extends StatelessWidget {
  const OTPPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: GestureDetector(
        onTap: () {
          Navigator.of(context).pop(); // Fungsi untuk kembali
        },
        child: Image.asset(
          'assets/iconBack.png', // Sesuaikan dengan path ikon Anda
          width: 24, // Sesuaikan dengan ukuran ikon Anda
          height: 24,
        ),
      )),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 50),
              const Text(
                'Kode verifikasi OTP',
                style: TextStyle(
                  fontFamily: 'Itim',
                  fontSize: 30,
                  fontWeight: FontWeight.w400,
                  height: 1.2,
                  letterSpacing: 0.0,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Kode verifikasimu akan dikirim ke +62 8xxxxxxx',
                style: TextStyle(
                  fontFamily: 'Itim',
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  height: 1.2,
                  letterSpacing: 0.0,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  buildOTPTextField(),
                  buildOTPTextField(),
                  buildOTPTextField(),
                  buildOTPTextField(),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Kirim kode ulang? 00.10',
                style: TextStyle(
                  fontFamily: 'Itim',
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  height: 1.2,
                  letterSpacing: 0.0,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF22692D),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        0), // Tidak ada sudut yang terbulat
                    side: const BorderSide(width: 2, color: Colors.transparent),
                  ),
                  minimumSize: const Size(306, 45),
                ),
                child: const Text(
                  'Verifikasi',
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

  Widget buildOTPTextField() {
    return Container(
      width: 48,
      height: 48,
      decoration: const BoxDecoration(
        color: Color(0xFFD9D9D9),
      ),
      child: Center(
        child: TextFormField(
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'Itim',
            fontSize: 30,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.0,
            color: Colors.black,
          ),
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
