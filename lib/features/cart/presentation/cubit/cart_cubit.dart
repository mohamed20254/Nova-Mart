import 'package:bloc/bloc.dart';
import 'package:ecomerc_app_with_admin/features/cart/domain/entity/cart_entity.dart';
import 'package:ecomerc_app_with_admin/features/cart/domain/use_case/add_item_cart_usecase.dart';
import 'package:ecomerc_app_with_admin/features/cart/domain/use_case/get_cart_usecase.dart';
import 'package:ecomerc_app_with_admin/features/cart/domain/use_case/remove_item_usecase.dart';
import 'package:equatable/equatable.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final GetCartUsecase getCartUsecase;
  final RemoveItemUsecase removeItemUsecase;
  final AddItemCartUsecase addItemCartUsecase;

  CartCubit({
    required this.getCartUsecase,
    required this.removeItemUsecase,
    required this.addItemCartUsecase,
  }) : super(CartInitial());

  Future<void> getcart() async {
    emit(CartLoding());
    final res = await getCartUsecase.call();
    res.fold(
      (l) => emit(CartFailure(message: l.messige)),
      (r) => emit(CartLoaded(List.from(r))),
    );
  }

  //==================add item
  Future<void> addItem(final CartItem cartitem) async {
    await addItemCartUsecase.call(cartitem: cartitem);
    getcart();
  }

  Future<void> removeItem({required final int id}) async {
    await removeItemUsecase.call(id: id);
    getcart();
  }
}
