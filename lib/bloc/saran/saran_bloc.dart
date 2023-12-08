import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:solusi_penjualan_pangan/util/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'saran_event.dart';
part 'saran_state.dart';

class SaranBloc extends Bloc<SaranEvent, SaranState> {
  SaranBloc() : super(SaranInitial()) {
    on<GetSaranEvent>((event, emit) async {
      final preferences = await SharedPreferences.getInstance();
      try {
        emit(SaranLoading());
        int toko_id = preferences.getInt('userToko') ?? 0;
        final response = await supabase
            .from('saran')
            .select()
            .eq('toko_id', toko_id);
        print(response);
        emit(SaranSuccesd(response));
      } catch (e) {
        emit(SaranFailed());
      }
    });
  }
}
