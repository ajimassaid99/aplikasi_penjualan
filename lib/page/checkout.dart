// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solusi_penjualan_pangan/bloc/keranjang/keranjang_bloc.dart';
import 'package:solusi_penjualan_pangan/model/produkget.dart';

import 'package:solusi_penjualan_pangan/page/pesanan_berhasil.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({
    Key? key,
  }) : super(key: key);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String address = 'Nama Jalan, Kota';
  String paymentOption = 'Tunai';

  double subtotal = 0;
  List<Map<String, dynamic>> cart = [];

  void initState() {
    super.initState();
    context.read<KeranjangBloc>().add(KeranjangEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<KeranjangBloc, KeranjangState>(
      builder: (context, state) {
        if (state is KeranjangLoading) {
          subtotal = 0;
        }
        if (state is StoreKeranjang) {
          subtotal = 0;
          cart = [];
          for (var data in state.data) {
            subtotal += data['product'].hargaProduk * data['value'];
            cart.add(
                {'produk_id': data['product'].id, 'jumlah': data['value']});
          }

          return Scaffold(
            appBar: AppBar(
              title: const Text('Checkout'),
              backgroundColor: const Color(0xFF22692D),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Alamat:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Implementasi untuk mengedit alamat
                        },
                        child: const Text(
                          'Edit',
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    address,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Detail Pesanan:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Menampilkan daftar item dengan jumlah, harga per item, dan sub total per item
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      ProductModel product = state.data[index]['product'];

                      double subTotalItem = product.hargaProduk *
                          double.parse(state.data[index]['value'].toString());

                      subtotal += subTotalItem;

                      return ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(product.namaProduk),
                            Text(product.hargaProduk.toString())
                          ],
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Jumlah: ${state.data[index]['value']}'),
                            Text(subTotalItem.toStringAsFixed(2))
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total Harga Item:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${subtotal}', // Menampilkan total harga per item
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Pembayaran:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  RadioListTile(
                    title: const Text('Tunai'),
                    value: 'Tunai',
                    groupValue: paymentOption,
                    onChanged: (String? value) {
                      setState(() {
                        paymentOption = value!;
                      });
                    },
                  ),
                  RadioListTile(
                    title: const Text('Non-Tunai'),
                    value: 'Non-Tunai',
                    groupValue: paymentOption,
                    onChanged: (String? value) {
                      setState(() {
                        paymentOption = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Aksi untuk menyelesaikan pembelian

                      context.read<KeranjangBloc>().add(Pesan(
                          metode: "Tunai",
                          jumlah_bayar: subtotal.toInt(),
                          data: cart));
                    },
                    child: const Text('Beli Sekarang'),
                  ),
                ],
              ),
            ),
          );
        }
        return SizedBox();
      },
      listener: (BuildContext context, KeranjangState state) {
        if (state is KeranjangSuccessed) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => PesananBerhasil()));
        }
        if (state is KeranjangFailed) {
          WidgetsBinding.instance!.addPostFrameCallback((_) {
            // Tampilkan dialog saat membangun widget jika keadaan adalah KeranjangFailed
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Gagal membuat pesanan'),
                  content: Text(
                      'Pesan atau informasi tambahan tentang kegagalan pesanan.'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pop(); // Tutup dialog saat tombol ditekan
                      },
                      child: Text('Tutup'),
                    ),
                  ],
                );
              },
            );
          });
        }
      },
    );
  }
}
