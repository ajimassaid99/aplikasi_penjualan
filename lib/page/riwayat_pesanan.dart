import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solusi_penjualan_pangan/bloc/riwayat/riwayat_bloc.dart';
import 'package:solusi_penjualan_pangan/page/widget/sidebar.dart';

class RiwayatPesananList extends StatefulWidget {
  const RiwayatPesananList({super.key});

  @override
  State<RiwayatPesananList> createState() => _RiwayatPesananListState();
}

class _RiwayatPesananListState extends State<RiwayatPesananList> {
  void initState() {
    super.initState();
    context.read<RiwayatBloc>().add(const GetRiwayatEvent());
  }

  Future<void> _refreshData() async {
    context
        .read<RiwayatBloc>()
        .add(const GetRiwayatEvent()); // Event untuk memperbarui data
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'Gagal':
        return Colors.red;
      case 'Berhasil':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Riwayat"),
        centerTitle: true,
        backgroundColor: const Color(0xFF22692D),
      ),
      body: BlocBuilder<RiwayatBloc, RiwayatState>(
        builder: (context, state) {
          if (state is RiwayatLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is RiwayatSuccess) {
            return RefreshIndicator(
              onRefresh: _refreshData,
              child: ListView.builder(
                itemCount: state.data.length,
                itemBuilder: (context, index) {
                  final pesanan = state.data[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 8, horizontal: 16), // Memberikan margin luar
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: Colors.grey), // Menambahkan border
                      borderRadius:
                          BorderRadius.circular(8), // Mengatur border radius
                    ),
                    child: ListTile(
                      title: Text(pesanan['metode']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Nomor Pesanan: ${pesanan['id']}'),
                          Text('Harga: ${pesanan['jumlah_bayar'].toString()}'),
                        ],
                      ),
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: getStatusColor(pesanan['status']),
                        ),
                        child: Text(
                          pesanan['status'],
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: _refreshData,
            child: const Center(
              child: Text("Data Kosong"),
            ),
          );
        },
      ),
      drawer: Sidebar(), // Anda dapat menambahkan drawer jika diperlukan
    );
  }
}
