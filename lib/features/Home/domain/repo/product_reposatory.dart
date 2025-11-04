import 'package:dartz/dartz.dart';
import 'package:ecomerc_app_with_admin/core/error/failure.dart';
import 'package:ecomerc_app_with_admin/features/Home/data/model/catogry_model.dart';
import 'package:ecomerc_app_with_admin/features/Home/domain/entity/product_entity.dart';

abstract class ProductReposatory {
  Future<Either<Failure, List<CatogryModel>>> getCategory();
  Future<Either<Failure, List<ProductEntity>>> getallProduct({
    required final int limit,
    required int lastId,
  });
}
