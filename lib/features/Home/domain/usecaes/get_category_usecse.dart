import 'package:dartz/dartz.dart';
import 'package:ecomerc_app_with_admin/core/error/failure.dart';
import 'package:ecomerc_app_with_admin/features/Home/data/model/catogry_model.dart';
import 'package:ecomerc_app_with_admin/features/Home/domain/repo/product_reposatory.dart';

class GetCategoryUsecse {
  final ProductReposatory productRepo;

  GetCategoryUsecse({required this.productRepo});
  Future<Either<Failure, List<CatogryModel>>> call() async {
    return await productRepo.getCategory();
  }
}
