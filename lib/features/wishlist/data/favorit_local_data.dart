import 'package:ecomerc_app_with_admin/core/theme/widget/app_widget.dart';
import 'package:ecomerc_app_with_admin/features/Home/domain/entity/product_entity.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/adapters.dart';

abstract class FavoritLocalData {
  Future<void> addFav({
    required final ProductEntity prodcut,
    required final BuildContext context,
  });
  Future<List<ProductEntity>> getFavorits();
  Future<bool> isFavorit({required final int id});
  Future<void> removeFav({
    required final int id,
    required final BuildContext context,
  });
}

class FavoritLocalDataImpl implements FavoritLocalData {
  final Box _box;

  FavoritLocalDataImpl({required Box box}) : _box = box;
  //==================add
  @override
  Future<void> addFav({
    required ProductEntity prodcut,
    required BuildContext context,
  }) async {
    final data = await getFavorits();
    if (data.any((element) => element.id == prodcut.id)) {
      return;
    }
    await _box.add(prodcut.tojson());
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => AppWidget.showsnackbar(context, "Item has been added"),
    );
  }

  //==================getalldata In The box
  @override
  Future<List<ProductEntity>> getFavorits() async {
    final data = _box.values.toList();

    if (data.isNotEmpty) {
      return data
          .map((e) => ProductEntity.fromjson(Map<String, dynamic>.from(e)))
          .toList();
    } else {
      return <ProductEntity>[];
    }
  }

  //-----------------------------cheack element
  @override
  Future<bool> isFavorit({required int id}) async {
    final data = _box.values.toList();
    if (data.isNotEmpty) {
      final item = data.where((element) => element["id"] == id).toList();
      return item.isNotEmpty ? true : false;
    } else {
      return false;
    }
  }

  //-----------------------------------remove element
  @override
  Future<void> removeFav({
    required int id,
    required BuildContext context,
  }) async {
    final favorits = _box.values.toList();
    final index = favorits.indexWhere((element) => element["id"] == id);
    if (index != -1) {
      await _box.deleteAt(index);
    } else {
      AppWidget.showsnackbar(context, "Item not found");
    }
  }
}
