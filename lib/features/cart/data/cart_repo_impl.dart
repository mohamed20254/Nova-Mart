import 'package:dartz/dartz.dart';
import 'package:ecomerc_app_with_admin/core/error/failure.dart';
import 'package:ecomerc_app_with_admin/features/cart/data/cart_local_data_sourc.dart';
import 'package:ecomerc_app_with_admin/features/cart/domain/entity/cart_entity.dart';
import 'package:ecomerc_app_with_admin/features/cart/domain/repo/cart_reposatory.dart';

class CartRepoImpl implements CartReposatory {
  final CartLocalDataSourc local;

  CartRepoImpl({required this.local});

  @override
  Future<void> add({required CartItem cartitem}) async {
    await local.add(cartitem: cartitem);
  }

  @override
  Future<void> removeitem({required int id}) async {
    local.removeitem(id: id);
  }

  @override
  Future<Either<Failure, List<CartItem>>> getCart() async {
    try {
      final cart = await local.getcart();
      if (cart.isEmpty) {
        return left(Failure("There are no items in the cart"));
      }
      return right(cart);
    } on Exception catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
