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
