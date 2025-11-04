import 'package:dartz/dartz.dart';
import 'package:ecomerc_app_with_admin/features/auth/domain/repo/user_reposatory.dart';

import '../../../../core/error/failure.dart';
import '../entitty/user_entitiy.dart';

class SignupUsecase {
  final UserReposatory repo;
  SignupUsecase(this.repo);

  Future<Either<Failure, UserEntity>> call({
    required final String name,
    required final String email,
    required final String password,
    required final String phone,
  }) async {
    return repo.creatAccount(
      name: name,
      email: email,
      password: password,
      phone: phone,
    );
  }
}
