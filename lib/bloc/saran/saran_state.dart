part of 'saran_bloc.dart';

sealed class SaranState extends Equatable {
  const SaranState();
  
  @override
  List<Object> get props => [];
}

class SaranInitial extends SaranState {}
class SaranLoading extends SaranState {}
class SaranFailed extends SaranState {}
class SaranSuccesd extends SaranState {
   final List data;

  const SaranSuccesd(
    this.data,
  );

  @override
  List<Object> get props => [data];
}
