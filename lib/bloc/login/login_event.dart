part of 'login_bloc.dart';

class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  List<Object?> get props => [];
}

class LoginUserEvent extends LoginEvent {
  final String email;
  final String password;
  const LoginUserEvent({required  this.email, required this.password});
  @override
  List<Object?> get props => [email,password];
}
class LoginPenjualEvent extends LoginEvent {
  final String email;
  final String password;
  const LoginPenjualEvent({required  this.email, required this.password});
  @override
  List<Object?> get props => [email,password];
}


