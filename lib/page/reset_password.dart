import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solusi_penjualan_pangan/bloc/lupa_Password/lupa_password_bloc.dart';
import 'package:solusi_penjualan_pangan/core.dart';
import 'package:solusi_penjualan_pangan/page/login.dart';

class ResetPasswordPage extends StatefulWidget {
  final String email;
  const ResetPasswordPage({super.key, required this.email});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    emailController.text = widget.email;
    return BlocConsumer<LupaPasswordBloc, LupaPasswordState>(
      listener: (context, state) {
        if (state is LupaPasswordError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("OTP Yang Anda Masukan Salah Silahkan Coba Lagi"),
            ),
          );
        }
        if (state is LupaPasswordSucces) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Password Berhasil Di Ubah"),
            ),
          );
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginPage(),
            ),
            (route) => false,
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
                      SPPFormInput(
                        label: 'Email',
                        hint: 'Masukkan alamat email',
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        readOnly: true,
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
                      const SizedBox(height: 10),
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
                      const SizedBox(height: 10),
                      SPPFormInput(
                        label: 'OTP',
                        controller: otpController,
                        keyboardType: TextInputType.number,
                        hint: 'Masukan OTP Anda',
                        icon: const ImageIcon(
                          AppIcons.numberPhone,
                          color: AppColors.grey500,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'OTP tidak boleh kosong';
                          }
                          if (value.length != 6) {
                            return 'OTP Harus 6 angka';
                          }
                          return null;
                        },
                        onChanged: (value) {},
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<LupaPasswordBloc>().add(
                                ResetPasswordEvent(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    otp: otpController.text));
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
