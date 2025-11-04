import 'package:dartz/dartz.dart';
import 'package:ecomerc_app_with_admin/core/error/failure.dart';
import 'package:ecomerc_app_with_admin/features/auth/domain/repo/user_reposatory.dart';

class LogoutUsecase {
  final UserReposatory userreposatory;
  const LogoutUsecase(this.userreposatory);
  Future<Either<Failure, void>> call() async {
    return userreposatory.logout();
  }
}
