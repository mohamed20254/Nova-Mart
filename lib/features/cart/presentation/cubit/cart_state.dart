part of 'cart_cubit.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

final class CartInitial extends CartState {}

final class CartLoding extends CartState {}

final class CartLoaded extends CartState {
  final List<CartItem> data;
  const CartLoaded(this.data);
  @override
  List<Object> get props => [data];
}

final class CartFailure extends CartState {
  final String message;

  const CartFailure({required this.message});
  @override
  List<Object> get props => [message];
}
