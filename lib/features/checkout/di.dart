import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomerc_app_with_admin/features/checkout/data/data_sources/checkout_remote_data_sources.dart';
import 'package:ecomerc_app_with_admin/features/checkout/data/repo_impl/checkout_repo_impl.dart';
import 'package:ecomerc_app_with_admin/features/checkout/domain/repo/checkout_repo.dart';
import 'package:ecomerc_app_with_admin/features/checkout/domain/usecase/send_order_usecase.dart';
import 'package:ecomerc_app_with_admin/features/checkout/presentation/bloc/checkout_cubit/checkout_cubit.dart';
import 'package:get_it/get_it.dart';

Future<void> injectCheckOut(final GetIt sl) async {
  // datasources
  sl.registerLazySingleton<CheckoutRemoteDataSources>(
    () => CheckoutRemoteDataSourcesImpl(firestore: sl<FirebaseFirestore>()),
  );

  // reposatory

  sl.registerLazySingleton<CheckoutRepo>(
    () => CheckoutRepoImpl(remote: sl<CheckoutRemoteDataSources>()),
  );

  //usecase
  sl.registerFactory<SendOrderUsecase>(
    () => SendOrderUsecase(sl<CheckoutRepo>()),
  );

  //cubit
  sl.registerFactory<CheckoutCubit>(
    () => CheckoutCubit(sl<SendOrderUsecase>()),
  );
}
