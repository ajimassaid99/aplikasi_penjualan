part of 'store_detail_bloc.dart';

sealed class StoreDetailState extends Equatable {
  const StoreDetailState();
  
  @override
  List<Object> get props => [];
}

 class StoreDetailInitial extends StoreDetailState {}
 class StoreDetailLoading extends StoreDetailState {}

class StoreDetailSucces extends StoreDetailState {
   final StoreModel data;
   final List<ProductModel> allMenu;

  const StoreDetailSucces(
    this.data,
    this.allMenu
  );

  @override
  List<Object> get props => [data,allMenu];
}

class StoreDetailFailed extends StoreDetailState {
   final String errorMessage;

  const StoreDetailFailed(
    this.errorMessage,
  );

  @override
  List<Object> get props => [errorMessage];
}

