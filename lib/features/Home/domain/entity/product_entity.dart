class ProductEntity {
  final int id;
  final String title;
  final String description;
  final double price;
  final double discountPercentage;
  final String categoryid;
  final String brand;
  final List<String> color;
  final List<String> sizes;
  final int stock;
  final List<String> images;
  final double rating;

  ProductEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.categoryid,
    required this.brand,
    required this.color,
    required this.sizes,
    required this.stock,
    required this.images,
    required this.rating,
  });
  factory ProductEntity.fromjson(Map<String, dynamic> json) {
    return ProductEntity(
      id: json["id"] ?? 0,
      title: json["title"] ?? "",
      description: json["description"] ?? "",
      price: json["price"] ?? 0.0,
      discountPercentage: json["discountPercentage"] ?? 0.0,
      categoryid: json["categoryid"] ?? "",
      brand: json["brand"] ?? "",
      color: json["color"] ?? [],
      sizes: json["sizes"] ?? [],
      stock: json["stock"] ?? 0,
      images: json["images"] ?? [],
      rating: json["rating"] ?? 0.0,
    );
  }
  Map<String, dynamic> tojson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "price": price,
      "discountPercentage": discountPercentage,

      "categoryid": categoryid,
      "brand": brand,
      "color": color,
      "sizes": sizes,
      "stock": stock,
      "images": images,
      "rating": rating,
    };
  }
}
