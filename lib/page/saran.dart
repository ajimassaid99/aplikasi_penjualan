import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solusi_penjualan_pangan/bloc/saran/saran_bloc.dart';
import 'package:solusi_penjualan_pangan/page/widget/sidebar.dart';

class SaranList extends StatefulWidget {
  const SaranList({super.key});

  @override
  State<SaranList> createState() => _SaranListState();
}

class _SaranListState extends State<SaranList> {
  void initState() {
    super.initState();
    context.read<SaranBloc>().add(const GetSaranEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Saran'),
        centerTitle: true,
        backgroundColor: const Color(0xFF22692D),
      ),
      drawer: Sidebar(),
      body: BlocBuilder<SaranBloc, SaranState>(
        builder: (context, state) {
          List data = [];
          if (state is SaranLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is SaranSuccesd) {
            data = state.data;
          }
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final saran = data[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                elevation: 3,
                child: ListTile(
                  title: Text(
                    saran['nama_pembeli'] ?? '',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(saran['saran']),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
