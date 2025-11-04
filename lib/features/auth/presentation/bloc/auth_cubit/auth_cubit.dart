import 'package:bloc/bloc.dart';
import 'package:ecomerc_app_with_admin/features/auth/domain/entitty/user_entitiy.dart';
import 'package:ecomerc_app_with_admin/features/auth/domain/usecase/google_signin_usecase.dart';
import 'package:ecomerc_app_with_admin/features/auth/domain/usecase/login_usecase.dart';
import 'package:ecomerc_app_with_admin/features/auth/domain/usecase/logout_usecase.dart';
import 'package:ecomerc_app_with_admin/features/auth/domain/usecase/reset_password_usecase.dart';
import 'package:ecomerc_app_with_admin/features/auth/domain/usecase/send_verification_email_useacse.dart';
import 'package:ecomerc_app_with_admin/features/auth/domain/usecase/signup_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../domain/usecase/check_emil_verifiy_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignupUsecase signuphsecase;
  final CheckEmilVerifiyUsecase checkEmailVerifiyUsecase;
  final SendVerificationEmailUseacse sendVerificationEmailUseacse;
  final LoginUsecase loginUsecase;
  final LogoutUsecase logoutUsecase;
  final GoogleSigninUsecase googleSigninUsecase;
  final ResetPasswordUsecase resetpassUsecase;
  final LogoutUsecase logoutusecase;
  AuthCubit({
    required this.logoutusecase,
    required this.resetpassUsecase,
    required this.googleSigninUsecase,
    required this.signuphsecase,
    required this.checkEmailVerifiyUsecase,
    required this.sendVerificationEmailUseacse,
    required this.loginUsecase,
    required this.logoutUsecase,
  }) : super(AuthInitial());

  // ================================signup
  Future<void> createAccount({
    required final String name,
    required final String email,
    required final String password,
    required final String phone,
  }) async {
    emit(SignupLoadingState());
    final res = await signuphsecase.call(
      name: name,
      email: email,
      password: password,
      phone: phone,
    );
    res.fold(
      (failuer) => emit(SignupFailureState(failuer.messige)),
      (user) => emit(SignupSuccessState(user)),
    );
  }

  //-----------------------------check email verifiy
  Future<void> checkEmail() async {
    emit(CheckEVLoadingState());
    final res = await checkEmailVerifiyUsecase.call();
    res.fold(
      (failuer) => emit(CheckEVfailureState(failuer.messige)),
      (user) => emit(CheckESuccessState(user)),
    );
  }

  //----------------------------send email
  Future<void> sendEmailVerifi() async {
    final res = await sendVerificationEmailUseacse.call();
    res.fold(
      (l) => emit(SendEVfailureState(l.messige)),
      (r) => emit(SendESuccessState()),
    );
  } //---------------------------autoCheckEmailVerification

  Future<void> autoCheckEmailVerification() async {
    for (int i = 0; i < 10; i++) {
      final res = await checkEmailVerifiyUsecase.call();
      bool isVerified = false;
      res.fold(
        (failure) {
          isVerified = false;
        },
        (user) {
          emit(CheckESuccessState(user));
          isVerified = true;
        },
      );
      if (isVerified) return;
      await Future.delayed(const Duration(seconds: 5));
    }
    emit(CheckEVfailureState('Email not verified yet'));
  }

  //-----------------------------updatefirestore
  Future<void> userupdate() async {
    checkEmailVerifiyUsecase.call();
  }

  //-------------------------------login
  Future<void> login({
    required final String email,
    required final String password,
  }) async {
    emit(LoginLoadingState());
    final res = await loginUsecase.call(email, password);
    res.fold(
      (failuer) => emit(LoginFailureState(failuer.messige)),
      (user) => emit(LoginSuccessState(user)),
    );
  }

  //----------------------google sign in
  Future<void> googleSign() async {
    emit(GoogleLoadinState());
    final res = await googleSigninUsecase.call();
    res.fold(
      (failuer) => emit(GoogleFailuerState(message: failuer.messige)),
      (user) => emit(GoogleSuccessState(user)),
    );
  }

  Future<void> restetPassword(String email) async {
    emit(RestetPassLoadingState());
    final res = await resetpassUsecase.call(email);
    res.fold(
      (l) => emit(RestetPassFailuerState(l.messige)),
      (r) => emit(RestetPassSuccessState()),
    );
  }

  Future<void> logout() async {
    emit(LogoutLoadingState());
    final res = await logoutUsecase.call();

    res.fold(
      (failuer) => emit(LogoutFailuerState(failuer.messige)),
      (r) => emit(LogoutSuccessState()),
    );
  }
}
