import 'package:flutter/material.dart';
import 'package:solusi_penjualan_pangan/model/produk.dart';
import 'package:solusi_penjualan_pangan/page/widget/header.dart';
import 'package:solusi_penjualan_pangan/page/widget/product_card.dart';

class HomePenjual extends StatefulWidget {
  const HomePenjual({super.key});

  @override
  State<HomePenjual> createState() => _HomePenjualState();
}

class _HomePenjualState extends State<HomePenjual> {
  Product product1 = Product(
      id: '1',
      name: 'Product A',
      image: 'image_url_a',
      price: 19.99,
      isAvailabel: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const HeaderWidget(),
        // Expanded(
        //   child: ListView.builder(
        //     itemCount: 4, // Loop 4 times
        //     itemBuilder: (context, index) {
        //       return GridView.builder(
        //         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //           crossAxisCount: 2,
        //           crossAxisSpacing: 8.0,
        //           mainAxisSpacing: 10,
        //         ),
        //         shrinkWrap: true,
        //         physics: const NeverScrollableScrollPhysics(),
        //         itemBuilder: (context, productIndex) {
        //           return ProductCardView(
        //             product: product1,
        //           );
        //         },
        //       );
        //     },
        //   ),
        // ),
      ],
    ));
  }
}
