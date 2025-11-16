part of 'favvorit_cubit.dart';

sealed class FavvoritState extends Equatable {
  const FavvoritState();

  @override
  List<Object> get props => [];
}

final class FavvoritInitial extends FavvoritState {}

final class Favvorlodaing extends FavvoritState {}

final class Favvorfailure extends FavvoritState {
  final String message;

  const Favvorfailure({required this.message});
  @override
  List<Object> get props => [message];
}

final class Favvorloaded extends FavvoritState {
  final List<ProductEntity> favorits;

  const Favvorloaded({required this.favorits});
  @override
  List<Object> get props => [favorits];
}
