import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
        emit(RiwayatSuccess(data));
      } catch (e) {
        print(e);
        emit(RiwayatFailed());
      }
    });
  }
}
