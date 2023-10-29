import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solusi_penjualan_pangan/bloc/lupa_Password/lupa_password_bloc.dart';
import 'package:solusi_penjualan_pangan/core.dart';
import 'package:solusi_penjualan_pangan/page/reset_password.dart';

class LupaPasswordPage extends StatefulWidget {
  const LupaPasswordPage({super.key});

  @override
  State<LupaPasswordPage> createState() => _LupaPasswordPageState();
}

class _LupaPasswordPageState extends State<LupaPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LupaPasswordBloc, LupaPasswordState>(
      listener: (context, state) {
        if (state is LupaPasswordError) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Gagal Merubah Password"),
            ),
          );
        }
        if (state is LupaPasswordSucces) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Silahkan Cek Email Anda untuk reset Password"),
            ),
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResetPasswordPage(
                email: emailController.text,
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is LupaPasswordLoading) {
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
                      const Text(
                        'Reset Password',
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
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<LupaPasswordBloc>().add(
                                LupaPasswordEvent(email: emailController.text));
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
                          'Reset',
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
