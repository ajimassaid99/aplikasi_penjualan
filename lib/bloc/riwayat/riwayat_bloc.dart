import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solusi_penjualan_pangan/model/pesanan.dart';
import 'package:solusi_penjualan_pangan/util/constants.dart';

part 'riwayat_event.dart';
part 'riwayat_state.dart';

class RiwayatBloc extends Bloc<RiwayatEvent, RiwayatState> {
  RiwayatBloc() : super(RiwayatInitial()) {
    on<GetRiwayatEvent>((event, emit) async {
      final preferences = await SharedPreferences.getInstance();
      try {
        emit(RiwayatLoading());
        String user_id = preferences.getString('userId') ?? '';

        final data =
            await supabase.from('pesanan').select().eq('user_id', user_id);
        print(data);
        emit(RiwayatSuccess(data.reversed.toList()));
      } catch (e) {
        print(e);
        emit(RiwayatFailed());
      }
    });

    on<GetPesananEvent>((event, emit) async {
      final preferences = await SharedPreferences.getInstance();
      try {
        emit(RiwayatLoading());
        int toko_id = preferences.getInt('userToko') ?? 0;

        final data = await supabase
            .from('pesanan')
            .select()
            .eq('toko_id', toko_id)
            .eq('status', 'menunggu di Proses')
            .execute();

        final List<Map<String, dynamic>> pesananData =
            (data.data as List<dynamic>).cast<Map<String, dynamic>>();

        final List<Pesanan> dataPesanan =
            pesananData.map((item) => Pesanan.fromJson(item)).toList();

        emit(pesananSuccess(dataPesanan.reversed.toList()));
      } catch (e) {
        print(e);
        emit(RiwayatFailed());
      }
    });
    on<GetPesananRiwayatEvent>((event, emit) async {
      final preferences = await SharedPreferences.getInstance();
      try {
        emit(RiwayatLoading());
        int toko_id = preferences.getInt('userToko') ?? 0;

        final data = await supabase
            .from('pesanan')
            .select()
            .eq('toko_id', toko_id)
            .neq('status', 'menunggu di Proses')
            .execute();

        final List<Map<String, dynamic>> pesananData =
            (data.data as List<dynamic>).cast<Map<String, dynamic>>();

        final List<Pesanan> dataPesanan =
            pesananData.map((item) => Pesanan.fromJson(item)).toList();

        emit(pesananSuccess(dataPesanan.reversed.toList()));
      } catch (e) {
        print(e);
        emit(RiwayatFailed());
      }
    });
    on<UpdateStatusEvent>((event, emit) async {
      try {
        emit(RiwayatLoading());
        await supabase
            .from('pesanan')
            .update({'status': event.status}).eq('id', event.id);
        if (event.status == 'Dalam Proses') {
          add(GetPesananEvent());
        } else if (event.status == 'Dikirim') {
          add(GetPesananRiwayatEvent());
        } else {
          add(GetRiwayatEvent());
        }
      } catch (e) {
        print(e);
        emit(RiwayatFailed());
      }
    });
    on<SaranEvent>((event, emit) async {
      final preferences = await SharedPreferences.getInstance();
      try {
        emit(RiwayatLoading());
        String nama = preferences.getString('userName') ?? '';
        await supabase.from('saran').insert({
          'nama_pembeli': nama,
          'pesanan_id': event.id,
          'saran': event.saran,
          'toko_id': event.toko_id  
        });
        await supabase
            .from('pesanan')
            .update({'status': "Selesai"}).eq('id', event.id);

        add(GetRiwayatEvent());
      } catch (e) {
        print(e);
        emit(RiwayatFailed());
      }
    });
  }
}
