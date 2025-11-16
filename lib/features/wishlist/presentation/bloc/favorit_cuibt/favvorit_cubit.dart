import 'package:bloc/bloc.dart';
import 'package:ecomerc_app_with_admin/features/Home/domain/entity/product_entity.dart';
import 'package:ecomerc_app_with_admin/features/wishlist/domain/usecase/add_fav_use_case.dart';
import 'package:ecomerc_app_with_admin/features/wishlist/domain/usecase/get_favorits_usecase.dart';
import 'package:ecomerc_app_with_admin/features/wishlist/domain/usecase/isfav_usecase.dart';
import 'package:ecomerc_app_with_admin/features/wishlist/domain/usecase/remove_Fav_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

part 'favvorit_state.dart';

class FavvoritCubit extends Cubit<FavvoritState> {
  final GetFavoritsUsecase getFavoritsUsecase;
  final IsfavUsecase isfavUsecase;
  final RemoveFavUsecase removeFavUsecase;
  final AddFavUseCase addFavUseCase;

  FavvoritCubit({
    required this.getFavoritsUsecase,
    required this.isfavUsecase,
    required this.removeFavUsecase,
    required this.addFavUseCase,
  }) : super(FavvoritInitial());
  Future<void> getFavorits() async {
    emit(Favvorlodaing());
    final res = await getFavoritsUsecase.call();
    res.fold(
      (l) => emit(Favvorfailure(message: l.messige)),
      (r) => emit(Favvorloaded(favorits: List.from(r))),
    );
  }

  Future<void> addFav({
    required final ProductEntity product,
    required final BuildContext context,
  }) async {
    await addFavUseCase.call(product: product, contex: context);
    await getFavorits();
  }

  Future<void> removeFav({
    required final int id,
    required final BuildContext context,
  }) async {
    await removeFavUsecase.call(id: id, context: context);
    await getFavorits();
  }

  Future<bool> isfav({required final int id}) async {
    return isfavUsecase.call(id: id);
  }

  Future<void> toogle({
    required final int id,
    required final BuildContext context,
    required final ProductEntity product,
  }) async {
    if (await isfav(id: id)) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        removeFav(id: id, context: context);
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        addFav(product: product, context: context);
      });
    }
  }
}
