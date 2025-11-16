import 'package:dartz/dartz.dart';
import 'package:ecomerc_app_with_admin/core/error/failure.dart';
import 'package:ecomerc_app_with_admin/core/theme/widget/app_widget.dart';
import 'package:ecomerc_app_with_admin/features/Home/domain/entity/product_entity.dart';
import 'package:ecomerc_app_with_admin/features/wishlist/data/favorit_local_data.dart';
import 'package:ecomerc_app_with_admin/features/wishlist/domain/repo/favorit_repo.dart';
import 'package:flutter/widgets.dart';

class FavoritRepoEmpl implements FavoritRepo {
  final FavoritLocalData local;

  FavoritRepoEmpl({required this.local});

  @override
  Future<void> addFav({
    required ProductEntity product,
    required BuildContext contex,
  }) async {
    try {
      await local.addFav(prodcut: product, context: contex);
    } on Exception catch (e) {
      WidgetsBinding.instance.addPersistentFrameCallback(
        (timeStamp) => AppWidget.showsnackbar(contex, e.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getFavorites() async {
    try {
      final favorits = await local.getFavorits();
      if (favorits.isNotEmpty) {
        return right(favorits);
      } else {
        return left(Failure("There are no items in the favorites"));
      }
    } on Exception catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<bool> isFav({required int id}) async {
    try {
      return await local.isFavorit(id: id);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> removeFav({
    required int id,
    required BuildContext context,
  }) async {
    try {
      await local.removeFav(id: id, context: context);
    } catch (e) {
      WidgetsBinding.instance.addPersistentFrameCallback(
        (timeStamp) => AppWidget.showsnackbar(context, e.toString()),
      );
    }
  }
}
