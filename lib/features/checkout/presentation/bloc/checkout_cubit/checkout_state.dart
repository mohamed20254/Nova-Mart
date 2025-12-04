part of 'checkout_cubit.dart';

sealed class CheckoutState extends Equatable {
  const CheckoutState();

  @override
  List<Object> get props => [];
}

final class CheckoutInitial extends CheckoutState {}

final class Checkoutfinish extends CheckoutState {
  const Checkoutfinish({required this.order});

  final OrderModel order;
  @override
  List<Object> get props => [order];
}

final class Checkoutlodaing extends CheckoutState {}

final class CheckoutFailure extends CheckoutState {
  const CheckoutFailure({required this.message});

  final String message;
  @override
  List<Object> get props => [message];
}
