import 'package:dartz/dartz.dart';
import 'package:ecomerc_app_with_admin/core/error/failure.dart';
import 'package:ecomerc_app_with_admin/features/orders/data/model/order_model.dart';

abstract class CheckoutRepo {
  Future<Either<Failure, OrderModel>> sendorder(final OrderModel order);
}
