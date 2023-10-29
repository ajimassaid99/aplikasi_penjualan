part of 'lupa_password_bloc.dart';

class LupaPasswordState extends Equatable {
  const LupaPasswordState();
  
  @override
  List<Object> get props => [];
}

class LupaPasswordInitial extends LupaPasswordState {}
class LupaPasswordSucces extends LupaPasswordState {}
class LupaPasswordLoading extends LupaPasswordState {}
class LupaPasswordError extends LupaPasswordState {}