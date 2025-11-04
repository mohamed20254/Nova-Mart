import 'package:dartz/dartz.dart';
import 'package:ecomerc_app_with_admin/features/auth/domain/repo/user_reposatory.dart';

import '../../../../core/error/failure.dart';

class SendVerificationEmailUseacse {
  final UserReposatory userReposatoryimpl;

  SendVerificationEmailUseacse(this.userReposatoryimpl);

  Future<Either<Failure, void>> call() async {
    return await userReposatoryimpl.sendEmailVerification();
  }
}
