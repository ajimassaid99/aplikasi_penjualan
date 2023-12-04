part of 'store_bloc.dart';

class StoreState extends Equatable {
  const StoreState();
  
  @override
  List<Object> get props => [];
}

class StoreInitial extends StoreState {}
class StoreLoading extends StoreState {}
class StoreSucces extends StoreState {
   final List<StoreModel> data;

  const StoreSucces(
    this.data,
  );

  @override
  List<Object> get props => [data];
}

class StoreFailed extends StoreState {
   final String errorMessage;

  const StoreFailed(
    this.errorMessage,
  );

  @override
  List<Object> get props => [errorMessage];
}
