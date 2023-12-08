part of 'riwayat_bloc.dart';

class RiwayatEvent extends Equatable {
  const RiwayatEvent();

  @override
  List<Object> get props => [];
}
class GetRiwayatEvent extends RiwayatEvent {
  const GetRiwayatEvent();

  @override
  List<Object> get props => [];
}
class GetPesananEvent extends RiwayatEvent {
  const GetPesananEvent();

  @override
  List<Object> get props => [];
}
class GetPesananRiwayatEvent extends RiwayatEvent {
  const GetPesananRiwayatEvent();

  @override
  List<Object> get props => [];
}
class UpdateStatusEvent extends RiwayatEvent {
  final int id;
  final String status;
  const UpdateStatusEvent(this.id, this.status);

  @override
  List<Object> get props => [];
}
class SaranEvent extends RiwayatEvent {
  final int id;
  final String saran;
  final int toko_id;
  const SaranEvent(this.id, this.saran, this.toko_id);

  @override
  List<Object> get props => [];
}
