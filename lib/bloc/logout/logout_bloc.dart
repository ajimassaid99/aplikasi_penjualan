import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:solusi_penjualan_pangan/util/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'logout_event.dart';
part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  LogoutBloc() : super(LogoutInitial()) {
    on<LogoutEvent>((event, emit) async {
      try {
        emit(LogoutLoading());
        await supabase.auth.signOut();
        print("JALAN0");
        final preferences = await SharedPreferences.getInstance();
        print("JALAN1");
        preferences.remove('userRole');
        preferences.remove('userphone');
        preferences.remove('userName');
        preferences.remove('userAddres');
        print("JALAN2");
        emit(LogoutSucces());
      } catch (e) {
        emit(LogoutError());
      }
    });
  }
}
