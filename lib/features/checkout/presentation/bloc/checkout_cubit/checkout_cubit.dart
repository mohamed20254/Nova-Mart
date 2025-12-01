import 'package:bloc/bloc.dart';
import 'package:ecomerc_app_with_admin/features/checkout/domain/usecase/send_order_usecase.dart';
import 'package:ecomerc_app_with_admin/features/orders/data/model/order_model.dart';
import 'package:equatable/equatable.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit(this.sendOrderUsecase) : super(CheckoutInitial());
  final SendOrderUsecase sendOrderUsecase;
  Future<void> sendOrder(final OrderModel order) async {
    emit(Checkoutlodaing());
    final res = await sendOrderUsecase.call(order);
    res.fold(
      (final falure) {
        if (!isClosed) {
          emit(CheckoutFailure(message: falure.messige));
        }
      },
      (final order) {
        if (!isClosed) {
          emit(Checkoutfinish(order: order));
        }
      },
    );
  }
}
