import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:ecomerc_app_with_admin/core/error/failure.dart';
import 'package:ecomerc_app_with_admin/features/orders/data/dataSources/order_remote_ds.dart';
import 'package:ecomerc_app_with_admin/features/orders/data/model/order_model.dart';
import 'package:ecomerc_app_with_admin/features/orders/domain/repo/order_repo.dart';

class OrderRepoImpl implements OrderReposatory {
  OrderRepoImpl({required this.remote});

  final OrderRemoteDs remote;
  @override
  Stream<Either<Failure, List<OrderModel>>> getOrders() {
    final controller = StreamController<Either<Failure, List<OrderModel>>>();
    final subscription = remote.watchOrders().listen(
      (final event) {
        controller.add(right(event));
      },
      onError: (final error) {
        controller.add(left(error));
      },
      cancelOnError: false,
    );
    controller.onCancel = () {
      subscription.cancel();
      controller.close();
    };
    return controller.stream;
  }
}
