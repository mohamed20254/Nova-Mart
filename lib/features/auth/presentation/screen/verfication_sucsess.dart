import 'package:ecomerc_app_with_admin/core/constant/app_icons.dart';
import 'package:ecomerc_app_with_admin/core/responsive/app_size.dart';
import 'package:ecomerc_app_with_admin/core/routing/app_routing.dart';
import 'package:ecomerc_app_with_admin/features/auth/presentation/widget/custom_button_signup.dart';
import 'package:ecomerc_app_with_admin/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerficationSucsess extends StatelessWidget {
  const VerficationSucsess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsetsGeometry.all(12),
        child: Column(
          children: [
            SizedBox(height: AppSize.hight(context) * 0.06),
            Image.asset(AppIcons.sucsess, height: 200.h),
            SizedBox(height: AppSize.hight(context) * 0.01),
            Text(
              AppLocalizations.of(context)!.verifySuccessTitle,
              style: Theme.of(context).textTheme.titleSmall,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppSize.hight(context) * 0.01),
            Text(
              AppLocalizations.of(context)!.verifySuccessSubtitle,
              style: Theme.of(context).textTheme.labelLarge,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppSize.hight(context) * 0.04),
            CustomButtonSignup(
              text: AppLocalizations.of(context)!.continueText,
              onPressed: () {
                // go to home screen
                Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRouting.mainScreen,
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
