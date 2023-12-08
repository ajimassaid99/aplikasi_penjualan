import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:solusi_penjualan_pangan/model/produk.dart';
import 'package:solusi_penjualan_pangan/util/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'tambah_produk_event.dart';
part 'tambah_produk_state.dart';

class TambahProdukBloc extends Bloc<TambahProdukEvent, TambahProdukState> {
  TambahProdukBloc() : super(TambahProdukInitial()) {
    on<LoadProdukEvent>((event, emit) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      try {
        emit(TambahProdukLoading());
        int idToko = await prefs.getInt("userToko") ?? 0;
        final response = await supabase
            .from('produk')
            .select('id, nama_produk, harga_produk, isTersedia, url_image')
            .eq('toko_id', idToko)
            .execute();

        // Check if the request was successful (status code 200)
        if (response.status == 200) {
          final data = response.data as List<dynamic>;

          // Convert the list of dynamic to a list of Product
          final List<Product> products =
              data.map((item) => Product.fromJson(item)).toList();

          emit(TambahProdukSucces(product: products));
        } else {
          emit(TambahProdukError('Failed to load products'));
        }
      } catch (e) {
        emit(TambahProdukError(e.toString()));
      }
    });
    on<createProdukEvent>((event, emit) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      try {
        emit(TambahProdukLoading());
        int idToko = await prefs.getInt("userToko") ?? 0;
        String userId = await prefs.getString("userId") ?? '0';

        final avatarFile = File(event.image);
        final String path = await supabase.storage.from('gambar produk').upload(
              '${event.nama_produk}-$userId.png',
              avatarFile,
            );
        if (path != '') {
          final String publicUrl = supabase.storage
              .from('gambar produk')
              .getPublicUrl('${event.nama_produk}-$userId.png');
          if (publicUrl != '') {
            await supabase.from('produk').insert({
              'nama_produk': event.nama_produk,
              'harga_produk': event.harga_produk,
              'url_image': publicUrl,
              'toko_id': idToko
            });
            emit(TambahProdukSuccesed());
          }
        }
      } catch (e) {
        emit(TambahProdukError(e.toString()));
      }
    });
    on<IsTersediaProdukEvent>((event, emit) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      try {
        emit(TambahProdukLoading());
        await supabase
            .from('produk')
            .update({'isTersedia': event.isTersedia}).match({'id': event.id});
        add(LoadProdukEvent());
      } catch (e) {
        emit(TambahProdukError(e.toString()));
      }
    });
  }
}
