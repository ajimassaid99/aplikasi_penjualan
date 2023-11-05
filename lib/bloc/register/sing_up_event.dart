part of 'sing_up_bloc.dart';

class SingUpEvent extends Equatable {
  final String email;
  final String username;
  final String password;
  final String noHp;
  final String alamat;

  const SingUpEvent(
      {required this.email,
      required this.noHp,
      required this.alamat,
      required this.password,
      required this.username});

  @override
  List<Object> get props => [email, username, password, noHp, alamat];
}
class SingUpEventPembeli extends SingUpEvent {
  

  const SingUpEventPembeli(
      {required super.email,
      required super.noHp,
      required super.alamat,
      required super.password,
      required super.username,});

  @override
  List<Object> get props => [email, username, password, noHp, alamat];
}

class SingUpPenjualEvent extends SingUpEvent {
  final String hari;
  final TimeOfDay jamBuka;
  final TimeOfDay jamTutup;
  final String? imageUrl;

  const SingUpPenjualEvent(
      {required super.email,
      required super.noHp,
      required super.alamat,
      required super.password,
      required super.username,
      required this.hari,
      required this.jamBuka,
      required this.jamTutup,
      this.imageUrl});

  @override
  List<Object> get props =>
      [email, username, password, noHp, alamat, hari, jamBuka, jamTutup];
}
