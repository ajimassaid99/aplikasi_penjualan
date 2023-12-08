// ignore_for_file: camel_case_types

part of 'riwayat_bloc.dart';

class RiwayatState extends Equatable {
  const RiwayatState();
  
  @override
  List<Object> get props => [];
}

class RiwayatInitial extends RiwayatState {}
class RiwayatLoading extends RiwayatState {}
class RiwayatFailed extends RiwayatState {}
class RiwayatSuccess extends RiwayatState {
  final List data;

  const RiwayatSuccess(
    this.data,
  );

  @override
  List<Object> get props => [data];
}
class pesananSuccess extends RiwayatState {
  final List<Pesanan> data;

  const pesananSuccess(
    this.data,
  );

  @override
  List<Object> get props => [data];
}
