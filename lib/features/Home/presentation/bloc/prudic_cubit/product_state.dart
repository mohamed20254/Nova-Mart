part of 'product_cubit.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

final class ProductInitial extends ProductState {}

final class ProductLodingState extends ProductState {}

final class ProductSuccessState extends ProductState {
  final List<ProductEntity> products;

  const ProductSuccessState({required this.products});
  @override
  List<Object> get props => [products];
}

final class ProductFailureState extends ProductState {
  final String messige;

  const ProductFailureState({required this.messige});
  @override
  List<Object> get props => [messige];
}

final class Productloadmore extends ProductState {}
