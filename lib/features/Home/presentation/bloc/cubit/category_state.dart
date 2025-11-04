part of 'category_cubit.dart';

sealed class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object?> get props => [];
}

final class CategoryInitial extends CategoryState {}

final class CategoryLoding extends CategoryState {}

final class CategorySuccess extends CategoryState {
  final List<CatogryModel> categores;

  const CategorySuccess({required this.categores});
  @override
  List<Object?> get props => [categores];
}

final class CategoryFailure extends CategoryState {
  final String messige;

  const CategoryFailure({required this.messige});
  @override
  List<Object?> get props => [messige];
}
