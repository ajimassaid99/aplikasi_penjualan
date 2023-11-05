import 'package:flutter/material.dart';
import 'package:solusi_penjualan_pangan/page/widget/header.dart';

class HomePenjual extends StatefulWidget {
  const HomePenjual({super.key});

  @override
  State<HomePenjual> createState() => _HomePenjualState();
}

class _HomePenjualState extends State<HomePenjual> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [HeaderWidget()],
    ));
  }
}
