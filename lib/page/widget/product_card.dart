import 'package:flutter/material.dart';
import 'package:solusi_penjualan_pangan/model/produk.dart';

class ProductCardView extends StatelessWidget {
  const ProductCardView({
    Key? key,
    required this.product,
    this.imageAlignment = Alignment.bottomCenter,
  }) : super(key: key);

  final Product product;
  final Alignment imageAlignment;

  @override
  Widget build(BuildContext context) {
    final priceValue = product.price;

    return SizedBox(
      width: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Tersedia:'),
              Switch(
                value: product.isAvailabel,
                onChanged: (value) {
                },
              ),
            ],
          ),
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              SizedBox(
                height: 100,
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  product.image,
                  alignment: imageAlignment,
                  fit: BoxFit.cover,
                ),
              ),
              if (product
                  .isAvailabel) // Show a badge if the product is available
                Container(
                  padding: const EdgeInsets.all(4),
                  color: Colors.green,
                  child: const Text(
                    'Available',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            child: Text(
              '${product.name}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          Row(
            children: [
              Text(
                '$priceValue €',
                maxLines: 1,
                overflow: TextOverflow.clip,
                softWrap: false,
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.amber,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
