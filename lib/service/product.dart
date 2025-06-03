class Product {
  final int id;
  final String title;
  final String imagePath;
  final String description;
  final String price;

  Product({
    required this.id,
    required this.title,
    required this.imagePath,
    required this.description,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      price: json['price'],
      id: json['id'],
      title: json['title'],
      imagePath: json['image_path'],
      description: json['description'] ?? '',
    );
  }
}
