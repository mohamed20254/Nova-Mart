import 'package:ecomerc_app_with_admin/features/cart/domain/entity/cart_entity.dart';
import 'package:hive_flutter/adapters.dart';

abstract class CartLocalDataSourc {
  Future<void> add({required final CartItem cartitem});
  Future<List<CartItem>> getcart();
  Future<void> removeitem({required final int id});
}

class CartLocalDataSourcesImpl implements CartLocalDataSourc {
  final Box _box;

  CartLocalDataSourcesImpl({required Box box}) : _box = box;

  @override
  Future<void> add({required CartItem cartitem}) async {
    final data = await getcart();
    final list = data
        .where((element) => element.product.id == cartitem.product.id)
        .toList();
    if (list.isEmpty) {
      await _box.add(cartitem.toJson());
    }
  }

  @override
  Future<List<CartItem>> getcart() async {
    final data = _box.values.toList();
    if (data.isNotEmpty) {
      return data
          .map((e) => CartItem.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    } else {
      return <CartItem>[];
    }
  }

  @override
  Future<void> removeitem({required final int id}) async {
    final data = await getcart();
    final int index = data.indexWhere((element) => element.product.id == id);
    await _box.deleteAt(index);
  }
}
