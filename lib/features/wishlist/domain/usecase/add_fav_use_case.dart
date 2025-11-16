import 'package:ecomerc_app_with_admin/features/wishlist/domain/repo/favorit_repo.dart';
import 'package:flutter/widgets.dart';

import '../../../Home/domain/entity/product_entity.dart';

class AddFavUseCase {
  final FavoritRepo repo;

  AddFavUseCase({required this.repo});
  Future<void> call({
    required final ProductEntity product,
    required final BuildContext contex,
  }) async {
    repo.addFav(product: product, contex: contex);
  }
}
