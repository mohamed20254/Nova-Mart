import 'package:bloc/bloc.dart';
import 'package:ecomerc_app_with_admin/features/Home/domain/entity/product_entity.dart';
import 'package:ecomerc_app_with_admin/features/Home/domain/usecaes/get_all_product_use_case.dart';
import 'package:equatable/equatable.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final GetAllPeoudictUseCase getAllPeoudictUseCase;
  ProductCubit(this.getAllPeoudictUseCase) : super(ProductInitial());

  bool hasmore = true;
  int lastId = 0;
  final List<ProductEntity> products = [];
  bool islodingloadMore = false;

  Future<void> getProduct({final bool isloademore = false}) async {
    if (!hasmore && isloademore) return;
    if (!isloademore) {
      lastId = 0;
      products.clear();
      hasmore = true;
      emit(ProductLodingState());
    } else {
      islodingloadMore = true;
      emit(ProductSuccessState(products: products));
    }

    final res = await getAllPeoudictUseCase.call(limit: 10, lastId: lastId);
    res.fold((failure) => emit(ProductFailureState(messige: failure.messige)), (
      newproduct,
    ) {
      if (newproduct.isEmpty) {
        hasmore = false;
        islodingloadMore = false;
      } else {
        products.addAll(newproduct);
        lastId = products.last.id;
        islodingloadMore = false;
        emit(ProductSuccessState(products: List.from(products)));
      }
    });
  }
}
