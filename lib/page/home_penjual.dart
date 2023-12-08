import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:solusi_penjualan_pangan/bloc/tambah_product/tambah_produk_bloc.dart';
import 'package:solusi_penjualan_pangan/model/produk.dart';
import 'package:solusi_penjualan_pangan/page/tambah_produk.dart';
import 'package:solusi_penjualan_pangan/page/widget/product_card.dart';
import 'package:solusi_penjualan_pangan/page/widget/product_item_shimmer.dart';
import 'package:solusi_penjualan_pangan/page/widget/sidebar.dart';

class HomePenjual extends StatefulWidget {
  const HomePenjual({Key? key}) : super(key: key);

  @override
  State<HomePenjual> createState() => _HomePenjualState();
}

class _HomePenjualState extends State<HomePenjual> {
  @override
  void initState() {
    super.initState();
    context.read<TambahProdukBloc>().add(const LoadProdukEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TambahProdukBloc, TambahProdukState>(
      builder: (context, state) {
        if (state is TambahProdukLoading) {
          // Shimmer loading effect
          return _buildShimmerLoading();
        } else if (state is TambahProdukSucces) {
          if (state.product.isEmpty) {
            return _buildErrorState("Data Produk Kosong");
          }
          // Actual content with loaded products
          return _buildContent(state.product);
        }
        return _buildErrorState("DataProduk Kosong");
      },
    );
  }

  Widget _buildShimmerLoading() {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
        backgroundColor: const Color(0xFF22692D),
      ),
      drawer: Sidebar(),
      body: Column(
        children: [
          // const HeaderWidget(),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(""),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TambahProdukPage(),
                    ),
                  );
                },
                child: const Text(
                  'Tambah Product',
                  style: TextStyle(
                    color: Color(0xFF22692D),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Jumlah kolom dalam grid
                  crossAxisSpacing: 1.0, // Spasi antar kolom
                ),
                itemCount: 6, // Number of shimmer cells
                itemBuilder: (context, index) {
                  return ProductItemShimmer();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(List<Product> productList) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
        backgroundColor: const Color(0xFF22692D),
      ),
      drawer: Sidebar(),
      body: Column(
        children: [
          // const HeaderWidget(),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(""),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TambahProdukPage(),
                    ),
                  );
                },
                child: const Text(
                  'Tambah Product',
                  style: TextStyle(
                    color: Color(0xFF22692D),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Jumlah kolom dalam grid
                crossAxisSpacing: 1.0, // Spasi antar kolom
              ),
              itemCount: productList.length,
              itemBuilder: (context, index) {
                return ProductItem(
                  product: productList[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String errorMessage) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
        backgroundColor: const Color(0xFF22692D),
      ),
      drawer: Sidebar(),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(""),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TambahProdukPage(),
                    ),
                  );
                },
                child: const Text(
                  'Tambah Product',
                  style: TextStyle(
                    color: Color(0xFF22692D),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 100,
          ),
          const Icon(
            Icons.error,
            size: 50,
            color: Colors.red,
          ),
          const SizedBox(height: 10),
          Text(
            errorMessage,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
