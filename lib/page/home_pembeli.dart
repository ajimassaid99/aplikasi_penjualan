import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solusi_penjualan_pangan/bloc/store/store_bloc.dart';
import 'package:solusi_penjualan_pangan/model/toko.dart';
import 'package:solusi_penjualan_pangan/page/checkout.dart';
import 'package:solusi_penjualan_pangan/page/hamalan_toko.dart';
import 'package:solusi_penjualan_pangan/page/widget/sidebar.dart';

class HomePembeli extends StatefulWidget {
  @override
  _HomePembeliState createState() => _HomePembeliState();
}

class _HomePembeliState extends State<HomePembeli> {
  final List<Map<String, dynamic>> topItems = [
    {
      'name': 'sate',
      'image':
          'https://asset.kompas.com/crops/FDAcmidsNYJDL80i55bj7pbXqyk=/95x0:939x563/750x500/data/photo/2022/07/10/62ca309364500.jpeg'
    },
    {
      'name': 'soto',
      'image':
          'https://d1vbn70lmn1nqe.cloudfront.net/prod/wp-content/uploads/2023/07/17043644/Praktis-dan-Simpel-Ini-Resep-Soto-Ayam-Lamongan-yang-Menggugah-Selera-.jpg.webp'
    },
    {
      'name': 'bakso',
      'image':
          'https://awsimages.detik.net.id/community/media/visual/2023/03/29/mantap-ini-5-bakso-gepeng-enak-berkuah-gurih-segar-buat-buka-puasa-3_43.png?w=600&q=90'
    },
  ];

  void initState() {
    super.initState();
    context.read<StoreBloc>().add(const GetStoreEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
        backgroundColor: const Color(0xFF22692D),
      ),
      drawer: Sidebar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(Icons.maps_home_work),
                    SizedBox(width: 5),
                    Text(
                      "Sumatra",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CheckoutPage(),
                        ),
                      );
                    },
                    child: const Text('Edit'))
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Terlaris',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 150,
              child: ListView.builder(
                itemCount: topItems.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    width: 120,
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          topItems[index]['image'],
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          topItems[index]['name'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Daftar Toko',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            BlocBuilder<StoreBloc, StoreState>(
              builder: (context, state) {
                if (state is StoreLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is StoreSucces) {
                  final List<StoreModel> storeList = state.data;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: storeList
                        .map((store) => ListTile(
                              title: Text(store.namaToko),
                              leading: const Icon(Icons.store),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            StorePage(id: store.id)));
                              },
                            ))
                        .toList(),
                  );
                }
                if (state is StoreFailed) {
                  return Center(
                    child: Text('Gagal memuat daftar toko.'),
                  );
                }
                return Container(); // Or display other widgets if needed
              },
            ),
          ],
        ),
      ),
    );
  }
}
