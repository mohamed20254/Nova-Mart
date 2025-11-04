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
}
