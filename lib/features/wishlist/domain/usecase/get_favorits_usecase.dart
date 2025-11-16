import 'package:dartz/dartz.dart';
import 'package:ecomerc_app_with_admin/core/error/failure.dart';
import 'package:ecomerc_app_with_admin/features/Home/domain/entity/product_entity.dart';
import 'package:ecomerc_app_with_admin/features/wishlist/domain/repo/favorit_repo.dart';

class GetFavoritsUsecase {
  final FavoritRepo repo;
  GetFavoritsUsecase(this.repo);
  Future<Either<Failure, List<ProductEntity>>> call() async {
    return await repo.getFavorites();
  }
}
