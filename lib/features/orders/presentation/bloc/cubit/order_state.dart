part of 'order_cubit.dart';

sealed class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

final class OrderInitial extends OrderState {}

final class OrderLoding extends OrderState {}

final class OrderLoaded extends OrderState {
  const OrderLoaded({required this.orders});

  final List<OrderModel> orders;

  @override
  List<Object> get props => [orders];
}

final class OrderFailure extends OrderState {
  const OrderFailure({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
