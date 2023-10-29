import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:solusi_penjualan_pangan/util/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginUserEvent>((event, emit) async {
      try {
        emit(LoginLoading());
        final res = await supabase.auth.signInWithPassword(
          email: event.email,
          password: event.password,
        );
        if (res.user?.userMetadata?['role'] == 'pembeli') {
          final preferences = await SharedPreferences.getInstance();
          preferences.setString(
              'userRole', res.user?.userMetadata?['role'] ?? '');
          preferences.setString(
              'userphone', res.user?.userMetadata?['noHP'] ?? '');
          preferences.setString(
              'userName', res.user?.userMetadata?['username'] ?? '');
          preferences.setString(
              'userAddres', res.user?.userMetadata?['alamat'] ?? '');
          emit(LoginSucces());
        } else {
          await supabase.auth.signOut();
          emit(LoginError(
              "Email Anda Terdaftar Sebagai Penjual Silahkan login Sebagai Penjual"));
        }
      } catch (e) {
        print(e.toString());
        emit(LoginError("Email Atau Password Salah"));
      }
    });
    on<LoginPenjualEvent>((event, emit) async {
      try {
        emit(LoginLoading());
        final res = await supabase.auth.signInWithPassword(
          email: event.email,
          password: event.password,
        );
        if (res.user?.userMetadata?['role'] == 'penjual') {
          final preferences = await SharedPreferences.getInstance();
          preferences.setString(
              'userRole', res.user?.userMetadata?['role'] ?? '');
          preferences.setString(
              'userphone', res.user?.userMetadata?['noHP'] ?? '');
          preferences.setString(
              'userName', res.user?.userMetadata?['username'] ?? '');
          preferences.setString(
              'userAddres', res.user?.userMetadata?['alamat'] ?? '');
          emit(LoginSucces());
        } else {
          await supabase.auth.signOut();
          emit(LoginError(
              "Email Anda Terdaftar Sebagai Pembeli Silahkan login Sebagai Penjual"));
        }
      } catch (e) {
        print(e.toString());
        emit(LoginError(e.toString()));
      }
    });
  }
}
