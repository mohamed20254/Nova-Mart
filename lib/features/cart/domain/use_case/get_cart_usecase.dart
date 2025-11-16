import 'package:dartz/dartz.dart';
import 'package:ecomerc_app_with_admin/core/error/failure.dart';
import 'package:ecomerc_app_with_admin/features/cart/domain/entity/cart_entity.dart';
import 'package:ecomerc_app_with_admin/features/cart/domain/repo/cart_reposatory.dart';

class GetCartUsecase {
  final CartReposatory repo;

  GetCartUsecase({required this.repo});
  Future<Either<Failure, List<CartItem>>> call() async {
    return await repo.getCart();
  }
}
