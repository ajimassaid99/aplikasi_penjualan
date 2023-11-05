import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solusi_penjualan_pangan/bloc/register/sing_up_bloc.dart';
import 'package:solusi_penjualan_pangan/page/login.dart';
import 'package:solusi_penjualan_pangan/page/welcome.dart';
import 'package:image_picker/image_picker.dart';

class RegisterPenjualPage extends StatefulWidget {
  const RegisterPenjualPage({super.key});

  @override
  State<RegisterPenjualPage> createState() => _RegisterPenjualPageState();
}

class _RegisterPenjualPageState extends State<RegisterPenjualPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  bool isLoading = false;
  String selectedOpeningDay = 'Setiap Hari';
  String? _selectedImage;
  TimeOfDay? selectedOpeningTime;
  TimeOfDay? selectedClosingTime;

  Future<void> _selectOpeningTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedOpeningTime ?? TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        selectedOpeningTime = picked;
      });
    }
  }

  Future<void> _selectClosingTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedClosingTime ?? TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        selectedClosingTime = picked;
      });
    }
  }

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
                    const Text(
                      'Daftar',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Itim',
                        letterSpacing: 0.0,
                        color: Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _pickImage();
                      },
                      child: _selectedImage != null
                          ? Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: FileImage(File(_selectedImage!)),
                                  fit: BoxFit
                                      .cover, // This will fill the container while maintaining the aspect ratio
                                ),
                              ),
                            )
                          : Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/person.png'),
                                  fit: BoxFit
                                      .cover, // This will fill the container while maintaining the aspect ratio
                                ),
                              ),
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
                            'Nama Toko',
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
                        hintText: 'Masukkan Toko',
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
                            'Alamat Toko',
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
                        hintText: 'Masukkan Alamat Toko Anda',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (text) {
                        addressController.text = text;
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
                        phoneController.text = text;
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Hari Operasional',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Itim',
                            letterSpacing: 0.0,
                            color: Colors.black,
                          ),
                        ),
                        DropdownButton<String>(
                          value: selectedOpeningDay,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedOpeningDay = newValue!;
                            });
                          },
                          items: <String>[
                            'Setiap Hari',
                            'Hari Kerja',
                            'Weekend',
                            'jumat libur',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Row(
                      children: [
                        Text(
                          'Jam Operasional',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Itim',
                            letterSpacing: 0.0,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ListTile(
                            subtitle: Text(
                              selectedOpeningTime?.format(context) ??
                                  'Jam Buka',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Itim',
                                letterSpacing: 0.0,
                                color: Colors.blue,
                              ),
                            ),
                            onTap: () {
                              _selectOpeningTime(context);
                            },
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: ListTile(
                            subtitle: Text(
                              selectedClosingTime?.format(context) ??
                                  'Jam Tutup',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Itim',
                                letterSpacing: 0.0,
                                color: Colors.blue,
                              ),
                            ),
                            onTap: () {
                              _selectClosingTime(context);
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if(state is !SingUpLoading){
                          context.read<SingUpBloc>().add(SingUpPenjualEvent(
                            email: emailController.text,
                            noHp: phoneController.text,
                            alamat: addressController.text,
                            password: passwordController.text,
                            username: usernameController.text,
                            hari: selectedOpeningDay,
                            imageUrl: _selectedImage,
                            jamBuka: selectedOpeningTime!,
                            jamTutup: selectedClosingTime!,));
                        }
                        
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(
                            0xFF22692D), // Warna latar belakang sesuai dengan kode warna yang diberikan
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              0), 
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

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = pickedFile.path;
      });
    }
  }
}
