import 'package:dartz/dartz.dart';
import 'package:ecomerc_app_with_admin/core/error/failure.dart';
import 'package:ecomerc_app_with_admin/features/Home/domain/entity/product_entity.dart';
import 'package:flutter/widgets.dart';

abstract class FavoritRepo {
  Future<void> addFav({
    required final ProductEntity product,
    required final BuildContext contex,
  });
  Future<void> removeFav({
    required final int id,
    required final BuildContext context,
  });
  Future<Either<Failure, List<ProductEntity>>> getFavorites();
  Future<bool> isFav({required final int id});
}
