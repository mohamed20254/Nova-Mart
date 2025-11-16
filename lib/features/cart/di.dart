import 'package:ecomerc_app_with_admin/core/di/injection_container.dart';
import 'package:ecomerc_app_with_admin/features/cart/data/cart_local_data_sourc.dart';
import 'package:ecomerc_app_with_admin/features/cart/data/cart_repo_impl.dart';
import 'package:ecomerc_app_with_admin/features/cart/domain/repo/cart_reposatory.dart';
import 'package:ecomerc_app_with_admin/features/cart/domain/use_case/add_item_cart_usecase.dart';
import 'package:ecomerc_app_with_admin/features/cart/domain/use_case/get_cart_usecase.dart';
import 'package:ecomerc_app_with_admin/features/cart/domain/use_case/remove_item_usecase.dart';
import 'package:ecomerc_app_with_admin/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

Future<void> injectcart(GetIt di) async {
  ///hive
  final box = await Hive.openBox("cart");
  //data sources
  sl.registerLazySingleton<CartLocalDataSourc>(
    () => CartLocalDataSourcesImpl(box: box),
  );

  //repo
  sl.registerLazySingleton<CartReposatory>(
    () => CartRepoImpl(local: sl<CartLocalDataSourc>()),
  );

  //usecse
  sl.registerLazySingleton<GetCartUsecase>(
    () => GetCartUsecase(repo: sl<CartReposatory>()),
  );
  sl.registerLazySingleton<AddItemCartUsecase>(
    () => AddItemCartUsecase(repo: sl<CartReposatory>()),
  );
  sl.registerLazySingleton<RemoveItemUsecase>(
    () => RemoveItemUsecase(repo: sl<CartReposatory>()),
  );

  ///cubit
  sl.registerFactory<CartCubit>(
    () => CartCubit(
      addItemCartUsecase: sl<AddItemCartUsecase>(),
      getCartUsecase: sl<GetCartUsecase>(),
      removeItemUsecase: sl<RemoveItemUsecase>(),
    ),
  );
}
