import 'dart:io';
import 'dart:math';
import 'package:intl/intl.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:solusi_penjualan_pangan/util/constants.dart';

part 'sing_up_event.dart';
part 'sing_up_state.dart';

class SingUpBloc extends Bloc<SingUpEvent, SingUpState> {
  SingUpBloc() : super(SingUpInitial()) {
    on<SingUpEventPembeli>((event, emit) async {
      try {
        emit(SingUpLoading());
        await supabase.auth.signUp(
          email: event.email,
          password: event.password,
          data: {
            'noHP': event.noHp,
            'role': 'pembeli',
            'alamat': event.alamat,
            'username': event.username,
          },
        );
        emit(SingUpSucces());
      } catch (e) {
        emit(SingUpError());
      }
    });
    on<SingUpPenjualEvent>((event, emit) async {
      try {
        emit(SingUpLoading());
        final res = await supabase.auth.signUp(
          email: event.email,
          password: event.password,
          data: {
            'noHP': event.noHp,
            'role': 'penjual',
            'alamat': event.alamat,
            'username': event.username,
          },
        );
        if (res.user?.id != null) {
          String path = '';
          if (event.imageUrl != null) {
            path = await supabase.storage.from('profile').upload(
                  res.user?.id ?? '',
                  File(event.imageUrl!),
                );
          }
          print("WKWKWKK12$path");
          final res2 = await supabase.from('toko').insert({
            'nama_toko': event.username,
            'alamat_toko': event.alamat,
            'no_hp': event.noHp,
            'email': event.email,
            'hari_operational': event.hari,
            'jam_buka': convertTimeOfDayToTimetz(event.jamBuka),
            'jam_tutup': convertTimeOfDayToTimetz(event.jamTutup),
            'user_id': res.user?.id ?? '',
            'image_url': path
          });
          print("WKWKWKWKWK23 $res2");
        }

        emit(SingUpSucces());
      } catch (e) {
        print("WKWKWKWKWK23 $e");
        emit(SingUpError());
      }
    });
  }
  String convertTimeOfDayToTimetz(TimeOfDay timeOfDay) {
    // Get the current date
    DateTime now = DateTime.now();

    // Convert TimeOfDay to DateTime
    DateTime dateTime = DateTime(
        now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);

    String formattedTimetz = DateFormat('HH:mm').format(dateTime);

    return formattedTimetz;
  }
}
