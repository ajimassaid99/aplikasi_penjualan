part of 'keranjang_bloc.dart';

class KeranjangState extends Equatable {
  const KeranjangState();
  
  @override
  List<Object> get props => [];
}

class KeranjangInitial extends KeranjangState {}
class KeranjangLoading extends KeranjangState {}

class StoreKeranjang extends KeranjangState {
   final List<Map<String,dynamic>> data;

  const StoreKeranjang(
    this.data,
  );

  @override
  List<Object> get props => [data];
}