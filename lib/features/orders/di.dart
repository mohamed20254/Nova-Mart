import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomerc_app_with_admin/features/orders/data/dataSources/order_remote_ds.dart';
import 'package:ecomerc_app_with_admin/features/orders/data/repo_impl/order_repo_impl.dart';
import 'package:ecomerc_app_with_admin/features/orders/domain/repo/order_repo.dart';
import 'package:ecomerc_app_with_admin/features/orders/domain/usecase/watch_orders_usecase.dart';
import 'package:ecomerc_app_with_admin/features/orders/presentation/bloc/cubit/order_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';

Future<void> injectOrder(final GetIt sl) async {
  // data Sources
  sl.registerLazySingleton<OrderRemoteDs>(
    () => OrderRemoteDSImpl(firestore: sl<FirebaseFirestore>()),
  );

  // repo
  sl.registerLazySingleton<OrderReposatory>(
    () => OrderRepoImpl(remote: sl<OrderRemoteDs>()),
  );

  //usecase
  sl.registerLazySingleton<WatchOrdersUsecase>(
    () => WatchOrdersUsecase(repo: sl<OrderReposatory>()),
  );

  // cubit
  sl.registerFactory<OrderCubit>(() => OrderCubit(sl<WatchOrdersUsecase>()));
}
