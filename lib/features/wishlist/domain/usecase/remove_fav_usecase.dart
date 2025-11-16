import 'package:flutter/widgets.dart';

import '../repo/favorit_repo.dart';

class RemoveFavUsecase {
  final FavoritRepo repo;

  RemoveFavUsecase({required this.repo});
  Future<void> call({
    required final int id,
    required final BuildContext context,
  }) async {
    repo.removeFav(id: id, context: context);
  }
}
