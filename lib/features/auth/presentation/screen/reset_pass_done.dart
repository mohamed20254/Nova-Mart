import 'package:ecomerc_app_with_admin/core/constant/app_lottie.dart';
import 'package:ecomerc_app_with_admin/core/responsive/app_size.dart';
import 'package:ecomerc_app_with_admin/core/routing/app_routing.dart';
import 'package:ecomerc_app_with_admin/core/theme/widget/app_widget.dart';
import 'package:ecomerc_app_with_admin/features/auth/presentation/bloc/auth_cubit/auth_cubit.dart';
import 'package:ecomerc_app_with_admin/features/auth/presentation/widget/custom_button_signup.dart';
import 'package:ecomerc_app_with_admin/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/constant/string.dart';

class ResetPassDone extends StatelessWidget {
  final String email;
  const ResetPassDone({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.close))],
      ),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is RestetPassFailuerState) {
            if (state.message.contains(AppStrings.nowInternete)) {
              AppWidget.showsnackbarNoInternete(context);
            } else {
              AppWidget.showsnackbar(context, state.message);
            }
          }
          if (state is RestetPassSuccessState) {
            AppWidget.showsnackbar(context, "Send Sucsess");
          }
        },
        child: Padding(
          padding: EdgeInsetsGeometry.all(12),
          child: Column(
            children: [
              SizedBox(height: AppSize.hight(context) * 0.02),
              Lottie.asset(AppLottie.verfi, height: 200.h),
              SizedBox(height: AppSize.hight(context) * 0.01),
              Text(
                AppLocalizations.of(context)!.resetLinkSentTitle,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: AppSize.hight(context) * 0.02),
              Text(email, style: Theme.of(context).textTheme.bodySmall),
              SizedBox(height: AppSize.hight(context) * 0.02),
              Text(
                AppLocalizations.of(context)!.resetLinkSentSubtitle,
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppSize.hight(context) * 0.04),
              CustomButtonSignup(
                text: AppLocalizations.of(context)!.done,
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRouting.login,
                    (route) => false,
                  );
                },
              ),
              SizedBox(height: AppSize.hight(context) * 0.04),
              TextButton(
                onPressed: () async {
                  await context.read<AuthCubit>().restetPassword(email);
                },
                child: Text(AppLocalizations.of(context)!.resendEmail),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
