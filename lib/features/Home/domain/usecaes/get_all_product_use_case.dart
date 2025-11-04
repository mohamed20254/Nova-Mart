import 'package:dartz/dartz.dart';
import 'package:ecomerc_app_with_admin/core/error/failure.dart';

import 'package:ecomerc_app_with_admin/features/Home/domain/entity/product_entity.dart';
import 'package:ecomerc_app_with_admin/features/Home/domain/repo/product_reposatory.dart';

class GetAllPeoudictUseCase {
  final ProductReposatory productRepo;
  const GetAllPeoudictUseCase(this.productRepo);
  Future<Either<Failure, List<ProductEntity>>> call({
    required final int limit,
    required final int lastId,
  }) async {
    return await productRepo.getallProduct(lastId: lastId, limit: limit);
  }
}
