import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solusi_penjualan_pangan/bloc/keranjang/keranjang_bloc.dart';
import 'package:solusi_penjualan_pangan/bloc/store_detail/store_detail_bloc.dart';
import 'package:solusi_penjualan_pangan/page/checkout.dart';

class StorePage extends StatefulWidget {
  final int id;

  const StorePage({super.key, required this.id});
  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  bool isBolehChekout = false;
  void initState() {
    super.initState();
    context.read<StoreDetailBloc>().add(GetStoreDetailEvent(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreDetailBloc, StoreDetailState>(
      builder: (context, state) {
        if (state is StoreDetailSucces) {
          return Scaffold(
            appBar: AppBar(
              title: Text(state.data.namaToko),
              backgroundColor: const Color(0xFF22692D),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Jam Buka: ${state.data.jamBuka}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Alamat: ${state.data.alamatToko}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Menu',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: state.allMenu.take(4).map((menu) {
                      return Card(
                        elevation: 3,
                        child: Column(
                          children: <Widget>[
                            Image.network(
                              menu.imageUrl,
                              height: 100,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    menu.namaProduk,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        'Rp. ${menu.hargaProduk.toString()}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Daftar Menu Lainnya',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // List untuk menu yang lain
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: state.allMenu.map((menu) {
                      return ListTile(
                        leading: Image.network(
                          menu.imageUrl,
                          height: 40,
                          width: 40,
                          fit: BoxFit.cover,
                        ),
                        title: Text(menu.namaProduk),
                        subtitle: Text('Rp.${menu.hargaProduk.toString()}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () {
                                context
                                    .read<KeranjangBloc>()
                                    .add(decrement(id: menu.id,product: menu));
                                setState(() {
                                  isBolehChekout = true;
                                });
                              },
                            ),
                            BlocBuilder<KeranjangBloc, KeranjangState>(
                              builder: (context, state) {
                                if (state is StoreKeranjang) {
                                  isBolehChekout = state.data.isNotEmpty &&
                                      state.data
                                          .any((item) => item['value'] > 0);
                                  int index = state.data.indexWhere(
                                      (item) => item['id'] == menu.id);
                                  if (index != -1) {
                                    return Text(
                                        state.data[index]['value'].toString());
                                  }
                                  return const Text('0');
                                }
                                return const Text('0');
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                context
                                    .read<KeranjangBloc>()
                                    .add(Increment(id: menu.id,product: menu));
                              },
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            floatingActionButton: Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              child: FloatingActionButton.extended(
                label: Text("checkout"),
                onPressed: () {
                  if (isBolehChekout) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CheckoutPage(toko_id: widget.id,)));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Silahkan pilih menu terlebih dahulu'),
                      ),
                    );
                  }
                },
              ),
            ),
          );
        }
        if (state is StoreDetailLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return const Center(
          child: Text("Data Toko Tidak Di temukan"),
        );
      },
    );
  }
}
