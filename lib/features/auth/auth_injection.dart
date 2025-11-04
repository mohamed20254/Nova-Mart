import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomerc_app_with_admin/features/auth/data/datasources/auth_local_data_sources.dart';
import 'package:ecomerc_app_with_admin/features/auth/data/datasources/outh_remote_datasourcse.dart';
import 'package:ecomerc_app_with_admin/features/auth/data/repo_impl/user_reposatory_impl.dart';
import 'package:ecomerc_app_with_admin/features/auth/domain/repo/user_reposatory.dart';
import 'package:ecomerc_app_with_admin/features/auth/domain/usecase/check_emil_verifiy_usecase.dart';
import 'package:ecomerc_app_with_admin/features/auth/domain/usecase/get_user_usecase.dart';
import 'package:ecomerc_app_with_admin/features/auth/domain/usecase/google_signin_usecase.dart';
import 'package:ecomerc_app_with_admin/features/auth/domain/usecase/listen_auth_state_usecase.dart';
import 'package:ecomerc_app_with_admin/features/auth/domain/usecase/login_usecase.dart';
import 'package:ecomerc_app_with_admin/features/auth/domain/usecase/logout_usecase.dart';
import 'package:ecomerc_app_with_admin/features/auth/domain/usecase/reset_password_usecase.dart';
import 'package:ecomerc_app_with_admin/features/auth/domain/usecase/send_verification_email_useacse.dart';
import 'package:ecomerc_app_with_admin/features/auth/domain/usecase/signup_usecase.dart';
import 'package:ecomerc_app_with_admin/features/auth/domain/usecase/ubdate_user_usecae.dart';
import 'package:ecomerc_app_with_admin/features/auth/presentation/bloc/auth_cubit/auth_cubit.dart';
import 'package:ecomerc_app_with_admin/features/auth/presentation/bloc/user_cubit/user_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

Future<void> authinjection(GetIt sl) async {
  //datasources
  //remotedatatsources
  sl.registerLazySingleton<OuthRemoteDatasourcse>(
    () => OuthRemoteDatasourcseImpl(
      firebaseouth: sl<FirebaseAuth>(),
      firebasstore: sl<FirebaseFirestore>(),
    ),
  );
  //   local data sources
  final box = await Hive.openBox("user");
  sl.registerLazySingleton<AuthLocalDataSources>(
    () => AuthlocalDataSourcesImpl(box: box),
  );

  //-----------------------------------------reposatory
  sl.registerLazySingleton<UserReposatory>(
    () => UserReposatoryImpl(
      remot: sl<OuthRemoteDatasourcse>(),
      local: sl<AuthLocalDataSources>(),
    ),
  );

  //------------------------------------------ usecase
  sl.registerLazySingleton<SignupUsecase>(
    () => SignupUsecase(sl<UserReposatory>()),
  );
  sl.registerLazySingleton<CheckEmilVerifiyUsecase>(
    () => CheckEmilVerifiyUsecase(sl<UserReposatory>()),
  );
  sl.registerLazySingleton<SendVerificationEmailUseacse>(
    () => SendVerificationEmailUseacse(sl<UserReposatory>()),
  );
  sl.registerLazySingleton<ListenAuthStateUsecase>(
    () => ListenAuthStateUsecase(sl<UserReposatory>()),
  );
  sl.registerLazySingleton<LoginUsecase>(
    () => LoginUsecase(sl<UserReposatory>()),
  );
  sl.registerLazySingleton<LogoutUsecase>(
    () => LogoutUsecase(sl<UserReposatory>()),
  );
  sl.registerLazySingleton<GoogleSigninUsecase>(
    () => GoogleSigninUsecase(sl<UserReposatory>()),
  );
  sl.registerLazySingleton<ResetPasswordUsecase>(
    () => ResetPasswordUsecase(sl<UserReposatory>()),
  );
  sl.registerLazySingleton<GetUserUsecase>(
    () => GetUserUsecase(repo: sl<UserReposatory>()),
  );
  sl.registerLazySingleton<UbdateUserUsecae>(
    () => UbdateUserUsecae(sl<UserReposatory>()),
  );

  //--------------------------------Cubit
  sl.registerFactory<AuthCubit>(
    () => AuthCubit(
      signuphsecase: sl<SignupUsecase>(),
      checkEmailVerifiyUsecase: sl<CheckEmilVerifiyUsecase>(),
      sendVerificationEmailUseacse: sl<SendVerificationEmailUseacse>(),
      loginUsecase: sl<LoginUsecase>(),
      logoutUsecase: sl<LogoutUsecase>(),
      googleSigninUsecase: sl<GoogleSigninUsecase>(),
      resetpassUsecase: sl<ResetPasswordUsecase>(),
      logoutusecase: sl<LogoutUsecase>(),
    ),
  );
  sl.registerFactory<UserCubit>(
    () => UserCubit(
      getUserUsecase: sl<GetUserUsecase>(),
      updateUserUsecase: sl<UbdateUserUsecae>(),
    ),
  );
}
