part of 'keranjang_bloc.dart';

class KeranjangEvent extends Equatable {
  const KeranjangEvent();

  @override
  List<Object> get props => [];
}

class Increment extends KeranjangEvent {
  final int id;
  final ProductModel product;
  const Increment({required this.id, required this.product});

  @override
  List<Object> get props => [];
}

class decrement extends KeranjangEvent {
  final int id;
  final ProductModel product;
  const decrement({required this.id, required this.product});

  @override
  List<Object> get props => [];
}

class Pesan extends KeranjangEvent {
  final String metode;
  final int jumlah_bayar;
  final int tokoId;
  final List<Map<String, dynamic>> data;
  const Pesan(
      {required this.metode, required this.jumlah_bayar, required this.data, required this.tokoId});

  @override
  List<Object> get props => [];
}
