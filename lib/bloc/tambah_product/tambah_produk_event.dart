part of 'tambah_produk_bloc.dart';

class TambahProdukEvent extends Equatable {
  const TambahProdukEvent();
  @override
  List<Object?> get props => [];
}

class LoadProdukEvent extends TambahProdukEvent {
  
  const LoadProdukEvent();
  @override
  List<Object?> get props => [];
}
class IsTersediaProdukEvent extends TambahProdukEvent {
  final bool isTersedia;
  final int id;
  const IsTersediaProdukEvent({required this.isTersedia, required this.id});
  @override
  List<Object?> get props => [];
}
class createProdukEvent extends TambahProdukEvent {
  final String image;
  final String nama_produk;
  final String harga_produk;
  const createProdukEvent({required  this.image, required this.nama_produk,required this.harga_produk});
  @override
  List<Object?> get props => [image, nama_produk, harga_produk];
}
