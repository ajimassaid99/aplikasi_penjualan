class Product {
  final int id;
  final String name;
  final String image;
  final int price;
  final bool isAvailable;

  Product(
      {required this.id,
      required this.name,
      required this.image,
      required this.price,
      required this.isAvailable});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'],
        name: json['nama_produk'],
        image: json['url_image'],
        price: json['harga_produk'],
        isAvailable: json['isTersedia']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama_produk': name,
      'url_image': image,
      'harga_produk': price,
      'isTersedia': isAvailable
    };
  }
}
