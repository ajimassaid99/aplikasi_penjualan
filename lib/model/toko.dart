import 'package:flutter/material.dart';

class StoreModel {
  final int id;
  final DateTime createdAt;
  final String namaToko;
  final String alamatToko;
  final String noHp;
  final String email;
  final String hariOperational;
  final String jamBuka;
  final String jamTutup;
  final String imageUrl;
  final String userId;

  StoreModel({
    required this.id,
    required this.createdAt,
    required this.namaToko,
    required this.alamatToko,
    required this.noHp,
    required this.email,
    required this.hariOperational,
    required this.jamBuka,
    required this.jamTutup,
    required this.imageUrl,
    required this.userId,
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
      id: json['id'] as int,
      createdAt: DateTime.parse(json['created_at']),
      namaToko: json['nama_toko'] as String,
      alamatToko: json['alamat_toko'] as String,
      noHp: json['no_hp'] as String,
      email: json['email'] as String,
      hariOperational: json['hari_operational'] as String,
      jamBuka: json['jam_buka'].toString(),
      jamTutup: json['jam_tutup'].toString(),
      imageUrl: json['image_url']?? 'https://asset.kompas.com/crops/FDAcmidsNYJDL80i55bj7pbXqyk=/95x0:939x563/750x500/data/photo/2022/07/10/62ca309364500.jpeg',
      userId: json['user_id'] as String,
    );
  }

}
