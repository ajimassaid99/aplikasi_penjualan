import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solusi_penjualan_pangan/bloc/riwayat/riwayat_bloc.dart';
import 'package:solusi_penjualan_pangan/page/input_saran.dart';
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

  void _updateStatus(int nomorPesanan) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update Status'),
          content: const Text('Choose an action:'),
          actions: [
            TextButton(
              onPressed: () {
                // Dispatch an event to update the status to "Proses"
                context.read<RiwayatBloc>().add(UpdateStatusEvent(
                      nomorPesanan,
                      'DiTerima',
                    ));
                Navigator.of(context).pop(); // Close the pop-up
              },
              child: const Text('Terima'),
            ),
            TextButton(
              onPressed: () {
                // Dispatch an event to update the status to "Tolak"
                context.read<RiwayatBloc>().add(UpdateStatusEvent(
                      nomorPesanan,
                      'Di Batalkan',
                    ));
                Navigator.of(context).pop(); // Close the pop-up
              },
              child: const Text('Batalkan'),
            ),
          ],
        );
      },
    );
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'Di Tolak':
        return Colors.red;
      case 'Selesai':
        return Colors.green;
      case 'Di Batalkan':
        return Colors.yellow;
      case 'menunggu di Proses':
        return Colors.orange;
      case 'Dikirim':
        return Colors.blue;
      case 'DiTerima':
        return Colors.blue;
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
                          vertical: 8, horizontal: 16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListTile(
                          title: Text(pesanan['metode']),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Nomor Pesanan: ${pesanan['id']}'),
                              Text(
                                  'Harga: ${pesanan['jumlah_bayar'].toString()}'),
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
                          onTap: () {
                            if (pesanan['status'] == 'Dikirim') {
                              _updateStatus(pesanan['id']);
                            }
                            if (pesanan['status'] == 'DiTerima') {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Saran'),
                                    content: const Text(
                                        'Barang sudah anda Terima. Ayo Beri Saran kepada penjual!'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  InputSaranPage(
                                                idPesanan: pesanan['id'],
                                                idToko: pesanan['toko_id'],
                                              ),
                                            ),
                                          );
                                        },
                                        child: const Text('Beri Saran'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); // Close the pop-up
                                        },
                                        child: const Text('Kembali'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          }));
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
      drawer: Sidebar(),
    );
  }
}
