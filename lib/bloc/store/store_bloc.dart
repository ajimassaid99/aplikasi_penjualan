import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:solusi_penjualan_pangan/model/toko.dart';
import 'package:solusi_penjualan_pangan/util/constants.dart';

part 'store_event.dart';
part 'store_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  StoreBloc() : super(StoreInitial()) {
    on<GetStoreEvent>((event, emit) async {
      try {
        emit(StoreLoading());

        final response = await supabase.from('toko').select().execute();

        if (response.data != null) {
          final List<StoreModel> listStore = (response.data as List)
              .map((item) => StoreModel.fromJson(item as Map<String, dynamic>))
              .toList();

          emit(StoreSucces(listStore));
        } else {
          emit(StoreFailed("Data tidak ditemukan"));
        }
      } catch (e) {
        print(e);
        emit(StoreFailed("Gagal Mengambil Data"));
      }
    });
   
  }
}
