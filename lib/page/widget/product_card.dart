import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:solusi_penjualan_pangan/model/produk.dart';

class ProductItem extends StatefulWidget {
  final Product product;
  final NumberFormat formatter =
      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ');

  ProductItem({Key? key, required this.product}) : super(key: key);

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Tersedia"),
              Switch(
                value: widget.product.isAvailable,
                activeColor:
                    widget.product.isAvailable ? Colors.green : Colors.red,
                onChanged: (value) {
                  setState(() {
                    // widget.product.isAvailable = value;
                  });
                },
              ),
            ],
          ),
          Expanded(
            // Gunakan Expanded di sini
            child: SizedBox(
              width: 110,
              child: Image.network(
                widget.product.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            widget.product.name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            widget.formatter.format(widget.product.price),
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
