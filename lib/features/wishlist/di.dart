import 'package:ecomerc_app_with_admin/features/wishlist/data/favorit_local_data.dart';
import 'package:ecomerc_app_with_admin/features/wishlist/data/favorit_repo_empl.dart';
import 'package:ecomerc_app_with_admin/features/wishlist/domain/repo/favorit_repo.dart';
import 'package:ecomerc_app_with_admin/features/wishlist/domain/usecase/add_fav_use_case.dart';
import 'package:ecomerc_app_with_admin/features/wishlist/domain/usecase/get_favorits_usecase.dart';
import 'package:ecomerc_app_with_admin/features/wishlist/domain/usecase/isfav_usecase.dart';

import 'package:ecomerc_app_with_admin/features/wishlist/presentation/bloc/favorit_cuibt/favvorit_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import 'domain/usecase/remove_Fav_usecase.dart';

Future<void> injectFav(GetIt sl) async {
  //hive
  final box = await Hive.openBox("favorit");

  // data sources
  sl.registerLazySingleton<FavoritLocalData>(
    () => FavoritLocalDataImpl(box: box),
  );

  //repo
  sl.registerLazySingleton<FavoritRepo>(
    () => FavoritRepoEmpl(local: sl<FavoritLocalData>()),
  );

  //UseCse
  ///get
  sl.registerLazySingleton<GetFavoritsUsecase>(
    () => GetFavoritsUsecase(sl<FavoritRepo>()),
  );
  sl.registerLazySingleton<AddFavUseCase>(
    () => AddFavUseCase(repo: sl<FavoritRepo>()),
  );
  sl.registerLazySingleton<RemoveFavUsecase>(
    () => RemoveFavUsecase(repo: sl<FavoritRepo>()),
  );
  sl.registerLazySingleton<IsfavUsecase>(
    () => IsfavUsecase(repo: sl<FavoritRepo>()),
  );

  //cubit
  sl.registerFactory<FavvoritCubit>(
    () => FavvoritCubit(
      getFavoritsUsecase: sl<GetFavoritsUsecase>(),
      isfavUsecase: sl<IsfavUsecase>(),
      removeFavUsecase: sl<RemoveFavUsecase>(),
      addFavUseCase: sl<AddFavUseCase>(),
    ),
  );
}
