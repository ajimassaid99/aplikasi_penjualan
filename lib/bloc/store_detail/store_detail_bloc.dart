import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:solusi_penjualan_pangan/model/produkget.dart';
import 'package:solusi_penjualan_pangan/model/toko.dart';
import 'package:solusi_penjualan_pangan/util/constants.dart';

part 'store_detail_event.dart';
part 'store_detail_state.dart';

class StoreDetailBloc extends Bloc<StoreDetailEvent, StoreDetailState> {
  StoreDetailBloc() : super(StoreDetailInitial()) {
    List<Map<String, dynamic>> cart = [];
    
    on<GetStoreDetailEvent>((event, emit) async {
      try {
        emit(StoreDetailLoading());

        final response =
            await supabase.from('toko').select().eq('id', event.id);
        final responseMenu = await supabase
            .from('produk')
            .select()
            .eq('toko_id', event.id)
            .execute();
        print(responseMenu);

        if (!response.isEmpty) {
          final StoreModel store = StoreModel.fromJson(response[0]);
          final List<ProductModel> listProduk = (responseMenu.data as List)
              .map(
                  (item) => ProductModel.fromJson(item as Map<String, dynamic>))
              .toList();

          emit(StoreDetailSucces(store, listProduk));
        } else {
          emit(StoreDetailFailed("Data tidak ditemukan"));
        }
      } catch (e) {
        print(e);
        emit(StoreDetailFailed("Gagal Mengambil Data"));
      }
    });
  }
}
