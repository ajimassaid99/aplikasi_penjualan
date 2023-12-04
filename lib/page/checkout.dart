import 'package:flutter/material.dart';
import 'package:solusi_penjualan_pangan/page/pesanan_berhasil.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String address = 'Nama Jalan, Kota';
  String paymentOption = 'Tunai';
  List<String> items = ['Item 1', 'Item 2', 'Item 3'];
  List<int> itemQuantities = [2, 1, 3];
  List<double> itemPrices = [10.0, 15.0, 8.0];

  @override
  Widget build(BuildContext context) {
    double totalItemsPrice = 0;
    for (int i = 0; i < items.length; i++) {
      totalItemsPrice += itemQuantities[i] * itemPrices[i];
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
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                double subTotal = itemQuantities[index] * itemPrices[index];
                return ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(items[index]),
                      Text(itemPrices[index].toString())
                    ],
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Jumlah: ${itemQuantities[index]}'),
                      Text(subTotal.toStringAsFixed(2))
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
                  '\$${totalItemsPrice.toStringAsFixed(2)}', // Menampilkan total harga per item
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PesananBerhasil()));
              },
              child: const Text('Beli Sekarang'),
            ),
          ],
        ),
      ),
    );
  }
}
