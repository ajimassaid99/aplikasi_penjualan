class Pesanan {
  final String metode;
  final int nomorPesanan;
  final int jumlah_bayar;
  final String status;

  Pesanan({
    required this.metode,
    required this.nomorPesanan,
    required this.jumlah_bayar,
    required this.status,
  });

  factory Pesanan.fromJson(Map<String, dynamic> json) {
    return Pesanan(
      metode: json['metode'] ?? '',
      nomorPesanan: json['id'] ?? '',
      jumlah_bayar: json['jumlah_bayar'],
      status: json['status'] ?? '',
    );
  }
}
