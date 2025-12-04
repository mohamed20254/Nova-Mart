import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:ecomerc_app_with_admin/core/error/failure.dart';
import 'package:ecomerc_app_with_admin/features/orders/data/model/order_model.dart';
import 'package:ecomerc_app_with_admin/features/orders/domain/usecase/watch_orders_usecase.dart';
import 'package:equatable/equatable.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit(this.watchOrdersUsecase) : super(OrderInitial()) {
    watchOrder();
  }
  final WatchOrdersUsecase watchOrdersUsecase;
  StreamSubscription<Either<Failure, List<OrderModel>>>? _sub;
  void watchOrder() {
    emit(OrderLoding());
    _sub?.cancel();
    _sub = watchOrdersUsecase.call().listen(
      (final event) {
        event.fold(
          (final failuer) =>
              isClosed ? null : emit(OrderFailure(message: failuer.messige)),
          (final orders) => isClosed ? null : emit(OrderLoaded(orders: orders)),
        );
      },
      onError: (final error) {
        if (!isClosed) {
          emit(OrderFailure(message: error.toString()));
        }
      },
    );
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
