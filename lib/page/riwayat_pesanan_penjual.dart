import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solusi_penjualan_pangan/bloc/riwayat/riwayat_bloc.dart';
import 'package:solusi_penjualan_pangan/model/pesanan.dart';
import 'package:solusi_penjualan_pangan/page/widget/sidebar.dart';

class PesananListRiwayat extends StatefulWidget {
  const PesananListRiwayat({super.key});

  @override
  State<PesananListRiwayat> createState() => _PesananListRiwayatState();
}

class _PesananListRiwayatState extends State<PesananListRiwayat> {
  void initState() {
    super.initState();
    context.read<RiwayatBloc>().add(const GetPesananRiwayatEvent());
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
                      'Dikirim',
                    ));
                Navigator.of(context).pop(); // Close the pop-up
              },
              child: const Text('kirim'),
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
      case 'Dibatalkan':
        return Colors.red;
      case 'Proses':
      case 'Dalam Proses':
        return Colors.orange;
      case 'Dikirim':
        return Colors.blue;
      case 'Selesai':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RiwayatBloc, RiwayatState>(
      builder: (context, state) {
        if (state is RiwayatLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        List<Pesanan> data = [];
        if (state is pesananSuccess) {
          data = state.data;
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text("Pesanan"),
            centerTitle: true,
            backgroundColor: const Color(0xFF22692D),
          ),
          body: ListView.separated(
            itemCount: data.length,
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
            itemBuilder: (context, index) {
              final pesanan = data[index];
              return ListTile(
                title: Text(pesanan.metode),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Nomor Pesanan: ${pesanan.nomorPesanan}'),
                    Text('Harga: ${pesanan.jumlah_bayar}'),
                  ],
                ),
                onTap: () {
                  if (pesanan.status == 'Dalam Proses') {
                    _updateStatus(pesanan.nomorPesanan);
                  }
                },
                trailing: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: getStatusColor(pesanan.status),
                  ),
                  child: Text(
                    pesanan.status,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              );
            },
          ),
          drawer: Sidebar(),
        );
      },
    );
  }
}
