import 'package:ecomerc_app_with_admin/features/Home/domain/entity/product_entity.dart';

class ProductModel extends ProductEntity {
  final String creationAt;
  final String updatedAt;

  ProductModel({
    required this.creationAt,
    required this.updatedAt,
    required super.id,
    required super.title,
    required super.description,
    required super.price,
    required super.discountPercentage,
    required super.categoryid,
    required super.brand,
    required super.color,
    required super.sizes,
    required super.stock,
    required super.images,
    required super.rating,
  });
  factory ProductModel.fromJson(Map<String, dynamic> jsondata) {
    return ProductModel(
      creationAt: jsondata["creationAt"] ?? "",
      id: jsondata["id"] ?? 0,
      title: jsondata["title"] ?? "",
      description: jsondata["description"] ?? "",
      price: (jsondata["price"] as num?)?.toDouble() ?? 0.0,
      discountPercentage:
          (jsondata["discountPercentage"] as num?)?.toDouble() ?? 0.0,
      categoryid: jsondata["categoryid"] ?? "",
      brand: jsondata["brand"] ?? "",
      color: jsondata["color"] != null
          ? List<String>.from(jsondata["color"])
          : [],
      sizes: jsondata["sizes"] != null
          ? List<String>.from(jsondata["sizes"])
          : [],
      stock: jsondata["stock"] ?? 0,
      images: jsondata["images"] != null
          ? List<String>.from(jsondata["images"])
          : [],
      rating: (jsondata["rating"] as num?)?.toDouble() ?? 0.0,
      updatedAt: jsondata["updatedAt"] ?? "",
    );
  }
  Map<String, dynamic> tojson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "categoryid": categoryid,
      "price": price,
      "discountPercentage": discountPercentage,
      "rating": rating,
      "stock": stock,
      "brand": brand,
      "images": images,
      "creationAt": creationAt,
      "updatedAt": updatedAt,
      "size": sizes,
      "color": color,
    };
  }
}
