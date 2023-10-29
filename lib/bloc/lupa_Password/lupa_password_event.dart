part of 'lupa_password_bloc.dart';

class LupaPasswordEvent extends Equatable {
  final String email;
  const LupaPasswordEvent({required this.email});

  @override
  List<Object> get props => [email];
}

class ResetPasswordEvent extends LupaPasswordEvent {
  final String otp;
  final String password;
  const ResetPasswordEvent({
    required super.email,
    required this.password,
    required this.otp
  });

  @override
  List<Object> get props => [email,password,otp];
}
