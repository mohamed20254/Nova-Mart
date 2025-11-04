import 'package:dartz/dartz.dart';
import 'package:ecomerc_app_with_admin/features/auth/domain/repo/user_reposatory.dart';

import '../../../../core/error/failure.dart';
import '../entitty/user_entitiy.dart' show UserEntity;

class GetUserUsecase {
  final UserReposatory repo;

  GetUserUsecase({required this.repo});
  Future<Either<Failure, UserEntity>> call() async {
    return await repo.getUserLocalOrFetch();
  }
}
