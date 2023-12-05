import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:solusi_penjualan_pangan/model/produk.dart';
import 'package:solusi_penjualan_pangan/model/produkget.dart';
import 'package:solusi_penjualan_pangan/util/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'keranjang_event.dart';
part 'keranjang_state.dart';

class KeranjangBloc extends Bloc<KeranjangEvent, KeranjangState> {
  List<Map<String, dynamic>> cart = [];
  KeranjangBloc() : super(KeranjangInitial()) {
    on<KeranjangEvent>((event, emit) {
      emit(KeranjangLoading());
      emit(StoreKeranjang(cart));
    });
    on<Pesan>((event, emit) async {
      final preferences = await SharedPreferences.getInstance();
      try {
        emit(KeranjangLoading());
        String user_id = preferences.getString('userId') ?? '';
        final List<Map<String, dynamic>> data =
            await supabase.from('pesanan').insert([
          {
            'metode': event.metode,
            'jumlah_bayar': event.jumlah_bayar,
            'status': "menunggu di Proses",
            'user_id':user_id
          }
        ]).select();

        int id = data[0]['id'];
        List<Map<String, dynamic>> updatedData = event.data.map((obj) {
          Map<String, dynamic> updatedObj = Map.from(obj);
          updatedObj['user_id'] = user_id;
          updatedObj['pesanan_id'] = id;
          return updatedObj;
        }).toList();
        final List<Map<String, dynamic>> dataDetail =
            await supabase.from('pesanan_detail').insert(updatedData).select();
        emit(KeranjangSuccessed());
      } catch (e) {
        print(e);
        emit(KeranjangFailed());
        emit(StoreKeranjang(cart));
      }
    });
    on<Increment>((event, emit) {
      emit(KeranjangLoading());
      int index = cart.indexWhere((item) => item['id'] == event.id);

      if (index == -1) {
        cart.add({'id': event.id, 'value': 1, 'product': event.product});
      } else {
        cart[index]['value'] += 1;
      }
      print(cart);

      emit(StoreKeranjang(cart));
    });
    on<decrement>((event, emit) {
      emit(KeranjangLoading());
      int index = cart.indexWhere((item) => item['id'] == event.id);

      if (index == -1) {
        cart.add({'id': event.id, 'value': 0, 'product': event.product});
      } else {
        if (cart[index]['value'] != 0) {
          cart[index]['value'] -= 1;
        }
      }
      print(cart);

      emit(StoreKeranjang(cart));
    });
  }
}
