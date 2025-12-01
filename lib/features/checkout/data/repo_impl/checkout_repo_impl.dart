import 'package:dartz/dartz.dart';
import 'package:ecomerc_app_with_admin/core/error/failure.dart';
import 'package:ecomerc_app_with_admin/core/error/firebaseauth_exception.dart';
import 'package:ecomerc_app_with_admin/features/checkout/data/data_sources/checkout_remote_data_sources.dart';
import 'package:ecomerc_app_with_admin/features/checkout/domain/repo/checkout_repo.dart';
import 'package:ecomerc_app_with_admin/features/orders/data/model/order_model.dart';
import 'package:firebase_core/firebase_core.dart';

class CheckoutRepoImpl implements CheckoutRepo {
  CheckoutRepoImpl({required this.remote});

  final CheckoutRemoteDataSources remote;
  @override
  Future<Either<Failure, OrderModel>> sendorder(final OrderModel order) async {
    try {
      final data = await remote.sendorder(order);
      return right(data);
    } on FirebaseException catch (e) {
      return left(Failure(MyFirebaseAuthException(e.code).message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
