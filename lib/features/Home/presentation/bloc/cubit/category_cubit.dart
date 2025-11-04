import 'package:bloc/bloc.dart';
import 'package:ecomerc_app_with_admin/features/Home/data/model/catogry_model.dart';
import 'package:ecomerc_app_with_admin/features/Home/domain/usecaes/get_category_usecse.dart';
import 'package:equatable/equatable.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final GetCategoryUsecse categoryUseCase;
  CategoryCubit(this.categoryUseCase) : super(CategoryInitial()) {
    getcategoy();
  }

  Future<void> getcategoy() async {
    emit(CategoryLoding());
    final res = await categoryUseCase.call();
    res.fold(
      (failure) => emit(CategoryFailure(messige: failure.messige)),
      (categores) => emit(CategorySuccess(categores: categores)),
    );
  }
}
