import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solusi_penjualan_pangan/bloc/store/store_bloc.dart';
import 'package:solusi_penjualan_pangan/model/toko.dart';
import 'package:solusi_penjualan_pangan/page/hamalan_toko.dart';
import 'package:solusi_penjualan_pangan/page/widget/sidebar.dart';

class HomePembeli extends StatefulWidget {
  @override
  _HomePembeliState createState() => _HomePembeliState();
}

class _HomePembeliState extends State<HomePembeli> {
  final List<Map<String, dynamic>> topItems = [
    {
      'name': 'donat',
      'image':
          'https://img.kurio.network/xICgRXknzD91eylETkDBDuvkD5k=/1200x1200/filters:quality(80)/https://kurio-img.kurioapps.com/22/07/26/593c9c0d-27ee-4c68-b98d-5dfb68aa30a2.jpg'
    },
    {
      'name': 'serabi',
      'image':
          'https://paxelmarket.co/wp-content/uploads/2022/04/WhatsApp-Image-2022-05-12-at-1.18.31-PM-1.jpeg'
    },
    {
      'name': 'roti goreng',
      'image':
          'https://img-global.cpcdn.com/recipes/3ab7412e338f9da5/680x482cq70/roti-goreng-terenak-yg-pernah-sy-makan-foto-resep-utama.jpg'
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
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => CheckoutPage(),
                      //   ),
                      // );
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
