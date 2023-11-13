part of 'tambah_produk_bloc.dart';

class TambahProdukState extends Equatable {
  @override
  List<Object> get props => [];
}

class TambahProdukInitial extends TambahProdukState {}

class TambahProdukSucces extends TambahProdukState {
  final List<Product> product;
  TambahProdukSucces({required this.product});
  @override
  List<Object> get props => [product];
}

class TambahProdukLoading extends TambahProdukState {}
class TambahProdukSuccesed extends TambahProdukState{}

class TambahProdukError extends TambahProdukState {
  final String errorMessage;

  TambahProdukError(
    this.errorMessage,
  );

  @override
  List<Object> get props => [errorMessage];
}
