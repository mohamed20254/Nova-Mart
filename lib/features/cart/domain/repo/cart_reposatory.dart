import 'package:dartz/dartz.dart';
import 'package:ecomerc_app_with_admin/core/error/failure.dart';
import 'package:ecomerc_app_with_admin/features/Home/data/model/catogry_model.dart';
import 'package:ecomerc_app_with_admin/features/cart/domain/entity/cart_entity.dart';

abstract class CartReposatory {
  Future<Either<Failure, List<CartItem>>> getCart();
  Future<void> removeitem({required final int id});
  Future<void> add({required final CartItem cartitem});
}
