import 'package:ecomerc_app_with_admin/features/cart/domain/entity/cart_entity.dart';
import 'package:ecomerc_app_with_admin/features/cart/domain/repo/cart_reposatory.dart';

class AddItemCartUsecase {
  final CartReposatory repo;

  AddItemCartUsecase({required this.repo});
  Future<void> call({required final CartItem cartitem}) async {
    return await repo.add(cartitem: cartitem);
  }
}
