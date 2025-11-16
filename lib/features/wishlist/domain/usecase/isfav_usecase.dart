import 'package:ecomerc_app_with_admin/features/wishlist/domain/repo/favorit_repo.dart';

class IsfavUsecase {
  final FavoritRepo repo;

  IsfavUsecase({required this.repo});
  Future<bool> call({required final int id}) async {
    return repo.isFav(id: id);
  }
}
