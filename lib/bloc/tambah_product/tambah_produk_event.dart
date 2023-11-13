part of 'tambah_produk_bloc.dart';

class TambahProdukEvent extends Equatable {
  const TambahProdukEvent();
  @override
  List<Object?> get props => [];
}

class LoadProdukEvent extends TambahProdukEvent {
  final String tokoId;
  const LoadProdukEvent({required  this.tokoId});
  @override
  List<Object?> get props => [tokoId];
}
class createProdukEvent extends TambahProdukEvent {
  final String image;
  final String nama_produk;
  final String harga_produk;
  const createProdukEvent({required  this.image, required this.nama_produk,required this.harga_produk});
  @override
  List<Object?> get props => [image, nama_produk, harga_produk];
}
