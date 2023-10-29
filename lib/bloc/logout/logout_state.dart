part of 'logout_bloc.dart';

class LogoutState extends Equatable {
  const LogoutState();
  
  @override
  List<Object> get props => [];
}

class LogoutInitial extends LogoutState {}
class LogoutSucces extends LogoutState {}
class LogoutLoading extends LogoutState {}
class LogoutError extends LogoutState {}
