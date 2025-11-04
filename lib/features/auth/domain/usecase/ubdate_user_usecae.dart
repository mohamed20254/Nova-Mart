import 'package:dartz/dartz.dart';
import 'package:ecomerc_app_with_admin/core/error/failure.dart';
import 'package:ecomerc_app_with_admin/features/auth/domain/repo/user_reposatory.dart';

class UbdateUserUsecae {
  final UserReposatory userReposatoryIml;
  const UbdateUserUsecae(this.userReposatoryIml);
  Future<Either<Failure, void>> call(
    final String? name,
    final String? phone,
  ) async {
    return userReposatoryIml.updateUser(name: name, phone: phone);
  }
}
