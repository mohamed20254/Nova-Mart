import 'package:dartz/dartz.dart';
import 'package:ecomerc_app_with_admin/core/error/failure.dart';
import 'package:ecomerc_app_with_admin/features/checkout/domain/repo/checkout_repo.dart';
import 'package:ecomerc_app_with_admin/features/orders/data/model/order_model.dart';

class SendOrderUsecase {
  SendOrderUsecase(this.repo);
  final CheckoutRepo repo;
  Future<Either<Failure, OrderModel>> call(final OrderModel order) async {
    return repo.sendorder(order);
  }
}
