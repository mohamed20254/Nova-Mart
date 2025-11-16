import '../../../Home/domain/entity/product_entity.dart';

class CartItem {
  final ProductEntity product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  double get totalPrice => product.price * quantity;
  CartItem ubdatequantity(quantity) {
    return CartItem(product: product, quantity: quantity);
  }

  Map<String, dynamic> toJson() {
    return {"product": product.tojson(), "quantity": quantity};
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product: ProductEntity.fromjson(
        Map<String, dynamic>.from(json["product"]),
      ),
      quantity: json["quantity"],
    );
  }
}
