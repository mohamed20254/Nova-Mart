import 'package:dartz/dartz.dart';
import 'package:ecomerc_app_with_admin/core/error/failure.dart';
import 'package:ecomerc_app_with_admin/features/orders/data/model/order_model.dart';
import 'package:ecomerc_app_with_admin/features/orders/domain/repo/order_repo.dart';

class WatchOrdersUsecase {
  WatchOrdersUsecase({required this.repo});

  final OrderReposatory repo;

  Stream<Either<Failure, List<OrderModel>>> call() {
    return repo.getOrders();
  }
}
