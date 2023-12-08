import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solusi_penjualan_pangan/bloc/riwayat/riwayat_bloc.dart';

class InputSaranPage extends StatefulWidget {
  final int idPesanan;
  final int idToko;
  const InputSaranPage({Key? key, required this.idPesanan, required this.idToko}) : super(key: key);

  @override
  _InputSaranPageState createState() => _InputSaranPageState();
}

class _InputSaranPageState extends State<InputSaranPage> {
  TextEditingController _saranController = TextEditingController();

  @override
  void dispose() {
    _saranController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Saran'),
        backgroundColor: const Color(0xFF22692D),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _saranController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Masukkan saran Anda',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context
                    .read<RiwayatBloc>()
                    .add(SaranEvent(widget.idPesanan, _saranController.text,widget.idToko));
                Navigator.of(context).pop();
              },
              child: const Text('Kirim'),
            ),
          ],
        ),
      ),
    );
  }
}
