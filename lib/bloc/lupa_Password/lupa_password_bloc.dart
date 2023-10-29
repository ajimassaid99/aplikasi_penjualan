import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'lupa_password_event.dart';
part 'lupa_password_state.dart';

class LupaPasswordBloc extends Bloc<LupaPasswordEvent, LupaPasswordState> {
  final supabase = Supabase.instance.client;
  LupaPasswordBloc() : super(LupaPasswordInitial()) {
    on<LupaPasswordEvent>((event, emit) async {
      try {
        emit(LupaPasswordLoading());
        await supabase.auth.resetPasswordForEmail(event.email);
        print("Berhasil");
        emit(LupaPasswordSucces());
      } catch (e) {
        emit(LupaPasswordError());
        print(e.toString());
      }
    });
    on<ResetPasswordEvent>((event, emit) async {
      try {
        emit(LupaPasswordLoading());
        final recovery = await supabase.auth.verifyOTP(
          email: event.email,
          token: event.otp,
          type: OtpType.recovery,
        );
        await supabase.auth.updateUser(
          UserAttributes(password: event.password),
        );
        emit(LupaPasswordSucces());
      } catch (e) {
        emit(LupaPasswordError());
      }
    });
  }
}
