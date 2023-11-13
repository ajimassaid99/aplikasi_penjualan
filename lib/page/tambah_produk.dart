import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solusi_penjualan_pangan/bloc/register/sing_up_bloc.dart';
import 'package:solusi_penjualan_pangan/bloc/tambah_product/tambah_produk_bloc.dart';
import 'package:solusi_penjualan_pangan/page/dashboard_penjual.dart';
import 'package:solusi_penjualan_pangan/page/welcome.dart';
import 'package:image_picker/image_picker.dart';

class TambahProdukPage extends StatefulWidget {
  const TambahProdukPage({super.key});

  @override
  State<TambahProdukPage> createState() => _TambahProdukPageState();
}

class _TambahProdukPageState extends State<TambahProdukPage> {
  final TextEditingController namaProdukController = TextEditingController();
  final TextEditingController hargaProdukController = TextEditingController();
  String? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TambahProdukBloc, TambahProdukState>(
      listener: (context, state) {
        print(state);
        if (state is TambahProdukSuccesed) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const DashboardPenjualPage()),
          );
        }
        if (state is TambahProdukError) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Produk gagal Di Buat. Silakan coba lagi.'),
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
                      'Tambah Produk',
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
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/product.png'),
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
                            'Nama Produk',
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
                      controller: namaProdukController,
                      decoration: const InputDecoration(
                        hintText: 'Masukkan Nama Produk',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (text) {
                        namaProdukController.text = text;
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Harga',
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
                      controller: hargaProdukController,
                      decoration: const InputDecoration(
                        hintText: 'Masukkan Harga',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (text) {
                        hargaProdukController.text = text;
                      },
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (state is! TambahProdukLoading) {
                          context
                              .read<TambahProdukBloc>()
                              .add(createProdukEvent(
                                harga_produk: hargaProdukController.text,
                                nama_produk: namaProdukController.text,
                                image: _selectedImage!,
                              ));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors
                            .black, // Warna latar belakang sesuai dengan kode warna yang diberikan
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                          side: const BorderSide(
                              width: 2,
                              color: Colors
                                  .transparent), // Ketebalan border (untuk memberikan ukuran)
                        ),
                        minimumSize: const Size(380, 45),
                      ),
                      child: state is TambahProdukLoading
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
