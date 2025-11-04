import 'package:dartz/dartz.dart';
import 'package:ecomerc_app_with_admin/core/error/failure.dart';
import 'package:ecomerc_app_with_admin/features/auth/domain/repo/user_reposatory.dart';

class ResetPasswordUsecase {
  final UserReposatory userReposatoryImpl;
  ResetPasswordUsecase(this.userReposatoryImpl);

  Future<Either<Failure, void>> call(String email) async {
    return await userReposatoryImpl.resetPassword(email);
  }
}
