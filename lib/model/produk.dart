class Product {
  final String id;
  final String name;
  final String image;
  final double price;
  final bool isAvailabel;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.isAvailabel
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      name: json['name'] as String,
      image: json['image'] as String,
      price: (json['price'] as num).toDouble(),
      isAvailabel:  json['isAvailabe']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'price': price,
      'isAvailabel':isAvailabel
    };
  }
}
