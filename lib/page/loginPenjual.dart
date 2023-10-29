import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solusi_penjualan_pangan/bloc/login/login_bloc.dart';
import 'package:solusi_penjualan_pangan/core.dart';
import 'package:solusi_penjualan_pangan/page/dashboard_penjual.dart';
import 'package:solusi_penjualan_pangan/page/forget_password.dart';
import 'package:solusi_penjualan_pangan/page/register_penjual.dart';

class LoginPenjualPage extends StatefulWidget {
  const LoginPenjualPage({super.key});

  @override
  State<LoginPenjualPage> createState() => _LoginPenjualPageState();
}

class _LoginPenjualPageState extends State<LoginPenjualPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
            ),
          );
        }
        if (state is LoginSucces) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Login Berhasil"),
            ),
          );
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  const DashboardPenjualPage(), // Ganti dengan nama halaman login Anda
            ),
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        if (state is LoginLoading) {
          return Container(
              color: Colors.white,
              child: const Center(child: CircularProgressIndicator()));
        }
        return Scaffold(
          body: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(height: 50),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Image.asset('assets/loginPenjual.png',
                            fit: BoxFit.fitWidth),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Selamat Datang      ',
                        style: TextStyle(
                          fontFamily: 'Itim',
                          fontSize: 35,
                          fontWeight: FontWeight.w400,
                          height: 1.2, // Mengatur line-height sekitar 42px
                          letterSpacing: 0.0,
                          color: Colors.black,
                          // Warna teks sesuai kebutuhan Anda
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'Gabung bersama kami, untuk kemudahan dalam berjualan ',
                        style: TextStyle(
                          fontFamily: 'Itim',
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          height: 1.6, // Sesuaikan dengan line-height 16px
                          letterSpacing: 0.0,
                          color:
                              Colors.black, // Warna teks sesuai kebutuhan Anda
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 20),
                      //   child: Row(
                      //     children: [
                      //       Container(
                      //         color: const Color(0xFFD9D9D9),
                      //         child: Padding(
                      //           padding: const EdgeInsets.symmetric(
                      //               horizontal: 5.0, vertical: 5.0),
                      //           child: Row(
                      //             children: [
                      //               Image.asset(
                      //                 'assets/BenderaIndo.png',
                      //                 width: 33,
                      //                 height: 27,
                      //               ),
                      //               const Text(
                      //                 '+62',
                      //                 style: TextStyle(
                      //                   fontFamily: 'Itim',
                      //                   fontSize: 20,
                      //                   fontWeight: FontWeight.w600,
                      //                   height: 1.2,
                      //                   letterSpacing: 0.0,
                      //                 ),
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //       ),
                      //       const Flexible(
                      //         child: TextField(
                      //           decoration: InputDecoration(
                      //             border: UnderlineInputBorder(),
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      SPPFormInput(
                        label: 'Email',
                        hint: 'Masukkan alamat email',
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email tidak boleh kosong';
                          } else if (!RegExp(
                                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(value)) {
                            return 'Alamat email tidak valid';
                          }
                          return null;
                        },
                        onChanged: (value) {},
                        icon: const ImageIcon(
                          AppIcons.email,
                          color: AppColors.grey500,
                        ),
                      ),
                      const SizedBox(height: 30),
                      SPPFormInputPassword(
                        label: 'Password',
                        hint: 'Masukkan password',
                        controller: passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password tidak boleh kosong';
                          } else if (value.length < 6) {
                            return 'Password harus memiliki setidaknya 6 karakter';
                          }
                          return null;
                        },
                        onChanged: (value) {},
                      ),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const LupaPasswordPage(), // Ganti dengan nama halaman login Anda
                                ),
                              );
                            },
                            child: const Text(
                              'Lupa Password?',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                fontFamily: 'Itim',
                                letterSpacing: 0.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<LoginBloc>().add(LoginPenjualEvent(
                                email: emailController.text,
                                password: passwordController.text));
                          }
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
                          minimumSize: const Size(306,
                              45), // Atur lebar dan tinggi sesuai kebutuhan
                        ),
                        child: const Text(
                          'Masuk',
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
                                  const RegisterPenjualPage(), // Ganti dengan nama halaman login Anda
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
                          minimumSize: const Size(306,
                              45), // Atur lebar dan tinggi sesuai kebutuhan
                        ),
                        child: const Text(
                          'Daftar',
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
            ),
          ),
        );
      },
    );
  }
}
