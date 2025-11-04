import 'package:dartz/dartz.dart';
import 'package:ecomerc_app_with_admin/core/error/failure.dart';
import 'package:ecomerc_app_with_admin/features/auth/domain/entitty/user_entitiy.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class UserReposatory {
  Future<Either<Failure, UserEntity>> creatAccount({
    required final String name,
    required final String email,
    required final String password,
    required final String phone,
  });
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, void>> sendEmailVerification();

  Future<Either<Failure, void>> logout();

  Future<Either<Failure, UserEntity?>> cheackemailverificaion();

  Stream<User?> listenToAuthState();

  Future<Either<Failure, UserEntity>> googleSignin();
  Future<Either<Failure, void>> resetPassword(String email);
  Future<Either<Failure, UserEntity>> getUserLocalOrFetch();
  Future<Either<Failure, void>> updateUser({
    final String? name,
    final String? phone,
  });
}
