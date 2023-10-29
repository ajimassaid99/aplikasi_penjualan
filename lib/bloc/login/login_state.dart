part of 'login_bloc.dart';

class LoginState extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class LoginInitial extends LoginState {}

class LoginSucces extends LoginState {}

class LoginLoading extends LoginState {}

class LoginError extends LoginState {
  final String errorMessage;

  LoginError(
    this.errorMessage,
  );

  @override
  List<Object?> get props => [errorMessage];
}
