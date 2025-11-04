import 'package:ecomerc_app_with_admin/features/Home/presentation/screen/main_screeen.dart';
import 'package:ecomerc_app_with_admin/features/auth/domain/usecase/listen_auth_state_usecase.dart';
import 'package:ecomerc_app_with_admin/features/auth/presentation/screen/login_screen.dart';
import 'package:ecomerc_app_with_admin/features/auth/presentation/screen/verification_email.dart';
import 'package:ecomerc_app_with_admin/features/onboarding/presentation/onbording_screen.dart';
import 'package:flutter/material.dart';

import '../local_storage/first_time.dart';

class AuthStateChange extends StatelessWidget {
  final ListenAuthStateUsecase listen;

  const AuthStateChange({super.key, required this.listen});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: listen.call(),
      builder: (context, snapshot) {
        if (IsFirstTime.getFirstTime()) return OnbordingScreen();

        final user = snapshot.data;
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        if (user == null) return LoginScreen();
        if (!user.emailVerified) return VerificationEmail(email: user.email!);
        return MainScreeen();
      },
    );
  }
}
