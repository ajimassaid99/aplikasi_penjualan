part of 'keranjang_bloc.dart';

class KeranjangEvent extends Equatable {
  const KeranjangEvent();

  @override
  List<Object> get props => [];
}

class Increment extends KeranjangEvent {
  final int id;
  const Increment({required this.id});

  @override
  List<Object> get props => [];
}
class decrement extends KeranjangEvent {
  final int id;
  const decrement({required this.id});

  @override
  List<Object> get props => [];
}