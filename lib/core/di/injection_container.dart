import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomerc_app_with_admin/features/Home/di.dart';
import 'package:ecomerc_app_with_admin/features/auth/auth_injection.dart';
import 'package:ecomerc_app_with_admin/features/auth/domain/usecase/listen_auth_state_usecase.dart';
import 'package:ecomerc_app_with_admin/features/cart/di.dart';
import 'package:ecomerc_app_with_admin/features/wishlist/di.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../helper/intial_screen.dart';

final sl = GetIt.instance; //ervice locator
Future<void> init() async {
  await Hive.initFlutter();
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  await authinjection(sl);
  sl.registerLazySingleton<AuthStateChange>(
    () => AuthStateChange(listen: sl<ListenAuthStateUsecase>()),
  );
  await injectFav(sl);
  await diPrudict(sl);
  await injectcart(sl);
}
