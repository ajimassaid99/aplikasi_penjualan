import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solusi_penjualan_pangan/bloc/register/sing_up_bloc.dart';
import 'package:solusi_penjualan_pangan/page/login.dart';
import 'package:solusi_penjualan_pangan/page/welcome.dart';

class RegisterUserPage extends StatefulWidget {
  const RegisterUserPage({super.key});

  @override
  State<RegisterUserPage> createState() => _RegisterUserPageState();
}

class _RegisterUserPageState extends State<RegisterUserPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SingUpBloc, SingUpState>(
      listener: (context, state) {
        if (state is SingUpSucces) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Pendaftaran berhasil!'),
              duration: Duration(seconds: 2), // Durasi tampilan SnackBar
            ),
          );
          // Redirect ke WelcomePage setelah 2 detik
          Future.delayed(const Duration(seconds: 2));
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const WelcomePage()),
          );
        }
        if (state is SingUpError) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Pendaftaran gagal. Silakan coba lagi.'),
              duration: Duration(seconds: 2), // Durasi tampilan SnackBar
            ),
          );
        }
      },
      builder: (context, state) {
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
            ),
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff211616),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: const BorderSide(
                            width: 2,
                            color: Colors.transparent,
                          ),
                        ),
                        minimumSize: const Size(70, 55),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 30), // Margin kiri dan kanan sebesar 30
                        child: Text(
                          'Registrasi',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Itim',
                            letterSpacing: 0.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      child: Divider(
                        thickness: 1.0, // Ketebalan garis
                        color: Colors.black, // Warna garis
                        indent: 0.0, // Margin kiri (bisa disesuaikan)
                        endIndent: 0.0, // Margin kanan (bisa disesuaikan)
                        height: 50, // Panjang garis (sesuai kebutuhan)
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Divider(
                        thickness: 1.0, // Ketebalan garis
                        color: Colors.black, // Warna garis
                        indent: 0.0, // Margin kiri (bisa disesuaikan)
                        endIndent: 0.0, // Margin kanan (bisa disesuaikan)
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Nama Pengguna',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Itim',
                              letterSpacing: 0.0,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 10),
                        ],
                      ),
                    ),
                    TextField(
                      controller: usernameController,
                      decoration: const InputDecoration(
                        hintText: 'Masukkan nama pengguna',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (text) {
                        usernameController.text = text;
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Email',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Itim',
                              letterSpacing: 0.0,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 10),
                        ],
                      ),
                    ),
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        hintText: 'Masukkan Email Anda',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (text) {
                        emailController.text = text;
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Password',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Itim',
                              letterSpacing: 0.0,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 10),
                        ],
                      ),
                    ),
                    TextField(
                      controller: passwordController,
                      decoration: const InputDecoration(
                        hintText: 'Masukkan Password Anda',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (text) {
                        passwordController.text = text;
                      },
                      obscureText:
                          true, // Ini akan menyembunyikan karakter pada password
                    ),
                    const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            'No Handphone',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Itim',
                              letterSpacing: 0.0,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 10),
                        ],
                      ),
                    ),
                    TextField(
                      controller: phoneController,
                      decoration: const InputDecoration(
                        hintText: 'Masukkan No Handphone Anda',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (text) {
                        passwordController.text = text;
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Alamat Rumah',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Itim',
                              letterSpacing: 0.0,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 10),
                        ],
                      ),
                    ),
                    TextField(
                      controller: addressController,
                      decoration: const InputDecoration(
                        hintText: 'Masukkan Alamat Anda',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (text) {
                        addressController.text = text;
                      },
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.read<SingUpBloc>().add(SingUpEvent(
                            email: emailController.text,
                            noHp: phoneController.text,
                            alamat: addressController.text,
                            password: passwordController.text,
                            username: usernameController.text));
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
                        minimumSize: const Size(380, 45),
                      ),
                      child: state is SingUpLoading
                          ? const CircularProgressIndicator()
                          : const Text(
                              'Lanjutkan',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Itim',
                                letterSpacing: 0.0,
                                color: Colors.white,
                              ),
                            ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Itim',
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.0,
                        ),
                        children: <TextSpan>[
                          const TextSpan(
                            text: 'Sudah punya akun? ',
                          ),
                          TextSpan(
                            text: 'Masuk',
                            style: const TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()),
                                );
                              },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
