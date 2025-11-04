import 'package:dartz/dartz.dart';
import 'package:ecomerc_app_with_admin/core/error/failure.dart';
import 'package:ecomerc_app_with_admin/features/auth/domain/entitty/user_entitiy.dart';
import 'package:ecomerc_app_with_admin/features/auth/domain/repo/user_reposatory.dart';

class LoginUsecase {
  final UserReposatory userreposatoyimpl;
  LoginUsecase(this.userreposatoyimpl);
  Future<Either<Failure, UserEntity>> call(
    final String email,
    final String password,
  ) async {
    return userreposatoyimpl.login(email: email, password: password);
  }
}
