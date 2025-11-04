import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomerc_app_with_admin/features/Home/data/datasourcs/product_remot_data_sources.dart';
import 'package:ecomerc_app_with_admin/features/Home/data/datasourcs/prudic_local_data_sources.dart';
import 'package:ecomerc_app_with_admin/features/Home/data/rpeo_impl/prodict_reposatory_impll.dart';
import 'package:ecomerc_app_with_admin/features/Home/domain/repo/product_reposatory.dart';
import 'package:ecomerc_app_with_admin/features/Home/domain/usecaes/get_all_product_use_case.dart';
import 'package:ecomerc_app_with_admin/features/Home/domain/usecaes/get_category_usecse.dart';
import 'package:ecomerc_app_with_admin/features/Home/presentation/bloc/cubit/category_cubit.dart';
import 'package:ecomerc_app_with_admin/features/Home/presentation/bloc/prudic_cubit/product_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> diPrudict(GetIt sl) async {
  final Box box = await Hive.openBox("prudict");
  //datasources
  sl.registerLazySingleton<PrudicLocalDataSources>(
    () => PrudicLocalDataSourcesIpml(box),
  );
  sl.registerLazySingleton<ProductRemotDataSources>(
    () => ProductRemotDataSourcesImpl(firestore: sl<FirebaseFirestore>()),
  );

  // ===================================repo
  sl.registerLazySingleton<ProductReposatory>(
    () => ProdictReposatoryImpll(
      local: sl<PrudicLocalDataSources>(),
      remote: sl<ProductRemotDataSources>(),
    ),
  );

  //========================Use Cases
  sl.registerLazySingleton<GetCategoryUsecse>(
    () => GetCategoryUsecse(productRepo: sl<ProductReposatory>()),
  );
  sl.registerLazySingleton<GetAllPeoudictUseCase>(
    () => GetAllPeoudictUseCase(sl<ProductReposatory>()),
  );

  //=======================================cubit
  sl.registerFactory<CategoryCubit>(
    () => CategoryCubit(sl<GetCategoryUsecse>()),
  );
  sl.registerFactory<ProductCubit>(
    () => ProductCubit(sl<GetAllPeoudictUseCase>()),
  );
}
