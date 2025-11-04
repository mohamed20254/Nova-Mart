import 'package:dartz/dartz.dart';
import 'package:ecomerc_app_with_admin/core/constant/string.dart';
import 'package:ecomerc_app_with_admin/core/error/failure.dart';
import 'package:ecomerc_app_with_admin/core/error/firebase_exception.dart';
import 'package:ecomerc_app_with_admin/core/error/firebaseauth_exception.dart';
import 'package:ecomerc_app_with_admin/core/helper/internt_connection.dart';
import 'package:ecomerc_app_with_admin/features/auth/data/datasources/auth_local_data_sources.dart';
import 'package:ecomerc_app_with_admin/features/auth/data/datasources/outh_remote_datasourcse.dart';
import 'package:ecomerc_app_with_admin/features/auth/data/model/user_mode.dart';
import 'package:ecomerc_app_with_admin/features/auth/domain/entitty/user_entitiy.dart';
import 'package:ecomerc_app_with_admin/features/auth/domain/repo/user_reposatory.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserReposatoryImpl implements UserReposatory {
  final OuthRemoteDatasourcse remot;
  final AuthLocalDataSources local;

  UserReposatoryImpl({required this.remot, required this.local});
  //------------------------create account

  @override
  Future<Either<Failure, UserEntity>> creatAccount({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    try {
      final UserModel user = await remot.creatAccount(
        name: name,
        email: email,
        password: password,
        phone: phone,
      );
      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(Failure(MyFirebaseAuthException(e.code).message));
    } on FirebaseException catch (e) {
      return Left(Failure(MyFirebaseServiceException(e.code).message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
  //-----------------------cheack email verfi

  @override
  Future<Either<Failure, UserEntity?>> cheackemailverificaion() async {
    try {
      final UserModel user = await remot.cheackemailverificaion();
      return Right(user);
    } on FirebaseException catch (e) {
      return Left(Failure(MyFirebaseServiceException(e.code).message));
    } on Exception catch (e) {
      return Left(Failure(e.toString()));
    }
  }
  //---------------------------------lofin

  @override
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final UserModel user = await remot.login(
        password: password,
        email: email,
      );
      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(Failure(MyFirebaseAuthException(e.code).message));
    } on FirebaseException catch (e) {
      return Left(Failure(MyFirebaseServiceException(e.code).message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  //---------------------------------logout
  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await remot.logout();
      return right(null);
    } on Exception catch (e) {
      return left(Failure(e.toString()));
    }
  }

  //---------------------------------send Email verfi
  @override
  Future<Either<Failure, void>> sendEmailVerification() async {
    try {
      await remot.sendEmailVerification();
      return right(null);
    } on Exception catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Stream<User?> listenToAuthState() {
    return remot.listenToAuthState();
  }

  @override
  Future<Either<Failure, UserEntity>> googleSignin() async {
    if (await TinterneteConnction.instance.isConnected()) {
      try {
        final UserModel userModel = await remot.googlesignin();
        return right(userModel);
      } on FirebaseAuthException catch (e) {
        return left(Failure((MyFirebaseAuthException(e.code).message)));
      } on FirebaseException catch (e) {
        return Left(Failure(MyFirebaseServiceException(e.code).message));
      } catch (e) {
        return left(Failure(e.toString()));
      }
    } else {
      return left(Failure(AppStrings.nowInternete));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword(String email) async {
    if (await TinterneteConnction.instance.isConnected()) {
      try {
        await remot.resetPAssword(email);
        return right(null);
      } on FirebaseAuthException catch (e) {
        return left(Failure(MyFirebaseAuthException(e.code).message));
      } on FirebaseException catch (e) {
        return Left(Failure(MyFirebaseServiceException(e.code).message));
      } catch (e) {
        return left(Failure(e.toString()));
      }
    } else {
      return left(Failure(AppStrings.nowInternete));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getUserLocalOrFetch() async {
    final UserModel? data = await local.getUserlocal(remot.uid);
    if (data != null) {
      return right(data);
    }
    try {
      final dataremot = await remot.fatchUser();
      local.cacheUser(dataremot);
      return right(dataremot);
    } on FirebaseException catch (e) {
      return left(Failure(MyFirebaseServiceException(e.code).message));
    } catch (e) {
      return left(Failure(MyFirebaseServiceException(e.toString()).message));
    }
  }

  @override
  Future<Either<Failure, void>> updateUser({
    final String? name,
    final String? phone,
  }) async {
    try {
      local.updateUser(remot.uid, name: name, phone: phone);
      return right(null);
    } on FirebaseException catch (e) {
      return left(Failure(MyFirebaseServiceException(e.code).message));
    } catch (e) {
      return left(Failure(MyFirebaseServiceException(e.toString()).message));
    }
  }
}
