import 'package:ecomerc_app_with_admin/features/cart/domain/repo/cart_reposatory.dart';

class RemoveItemUsecase {
  final CartReposatory repo;

  RemoveItemUsecase({required this.repo});
  Future<void> call({required final int id}) async {
    return await repo.removeitem(id: id);
  }
}
