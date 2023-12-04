class ProductModel {
  final int id;
  final DateTime createdAt;
  final String namaProduk;
  final int hargaProduk;
  final String imageUrl;
  final bool isTersedia;
  final int tokoId;

  ProductModel({
    required this.id,
    required this.createdAt,
    required this.namaProduk,
    required this.hargaProduk,
    required this.imageUrl,
    required this.isTersedia,
    required this.tokoId,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int,
      createdAt: DateTime.parse(json['created_at']),
      namaProduk: json['nama_produk'] as String,
      hargaProduk: json['harga_produk'] as int,
      imageUrl: json['url_image'] as String,
      isTersedia: json['isTersedia'] as bool,
      tokoId: json['toko_id'] as int,
    );
  }
}
