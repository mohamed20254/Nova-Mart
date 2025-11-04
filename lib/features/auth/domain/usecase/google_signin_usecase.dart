import 'package:dartz/dartz.dart';
import 'package:ecomerc_app_with_admin/core/error/failure.dart';
import 'package:ecomerc_app_with_admin/features/auth/domain/entitty/user_entitiy.dart';
import 'package:ecomerc_app_with_admin/features/auth/domain/repo/user_reposatory.dart';

class GoogleSigninUsecase {
  final UserReposatory userrepo;
  GoogleSigninUsecase(this.userrepo);
  Future<Either<Failure, UserEntity>> call() async {
    return await userrepo.googleSignin();
  }
}
