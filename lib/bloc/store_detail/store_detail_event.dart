part of 'store_detail_bloc.dart';

class StoreDetailEvent extends Equatable {
  const StoreDetailEvent();

  @override
  List<Object> get props => [];
}

class GetStoreDetailEvent extends StoreDetailEvent {
  final int id;
  const GetStoreDetailEvent({required this.id});

  @override
  List<Object> get props => [];
}

