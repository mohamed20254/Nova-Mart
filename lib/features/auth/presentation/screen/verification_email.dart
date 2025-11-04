import 'package:ecomerc_app_with_admin/core/constant/app_lottie.dart';
import 'package:ecomerc_app_with_admin/core/responsive/app_size.dart';
import 'package:ecomerc_app_with_admin/core/theme/widget/app_widget.dart';
import 'package:ecomerc_app_with_admin/features/auth/presentation/bloc/auth_cubit/auth_cubit.dart';
import 'package:ecomerc_app_with_admin/features/auth/presentation/bloc/timer_cubit/cubit/timer_cubit.dart';
import 'package:ecomerc_app_with_admin/features/auth/presentation/widget/custom_button_signup.dart';
import 'package:ecomerc_app_with_admin/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/routing/app_routing.dart';

class VerificationEmail extends StatefulWidget {
  final String email;

  const VerificationEmail({super.key, required this.email});

  @override
  State<VerificationEmail> createState() => _VerificationEmailState();
}

class _VerificationEmailState extends State<VerificationEmail> {
  late final TimerCubit _timerCubit;
  @override
  void initState() {
    context.read<AuthCubit>().autoCheckEmailVerification();
    context.read<AuthCubit>().sendEmailVerifi();
    context.read<TimerCubit>().startResendTimer();
    _timerCubit = context.read<TimerCubit>();
    super.initState();
  }

  @override
  void dispose() {
    _timerCubit.stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is CheckESuccessState) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRouting.verficationsucess,
              (route) => false,
            );
          } else if (state is CheckEVfailureState) {
            AppWidget.showsnackbar(context, state.message);
          } else if (state is SendESuccessState) {
            AppWidget.showsnackbar(context, "Sent successfully");
          } else if (state is SendEVfailureState) {
            AppWidget.showsnackbar(context, state.message);
          }
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close),
                    ),
                  ],
                ),
                SizedBox(height: AppSize.hight(context) * 0.01),
                Lottie.asset(AppLottie.verfi, height: 250.h),
                Text(
                  AppLocalizations.of(context)!.verifyTitle,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(height: AppSize.hight(context) * 0.01),
                Text(
                  widget.email,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(height: AppSize.hight(context) * 0.01),
                Text(
                  AppLocalizations.of(context)!.verifySubtitle,
                  style: Theme.of(context).textTheme.labelLarge,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: AppSize.hight(context) * 0.02),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    return Stack(
                      children: [
                        CustomButtonSignup(
                          text: state is CheckEVLoadingState
                              ? ""
                              : AppLocalizations.of(context)!.continueText,
                          onPressed: () {
                            context.read<AuthCubit>().checkEmail();
                          },
                        ),
                        state is CheckEVLoadingState
                            ? Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 1,

                                  color: Colors.white,
                                ),
                              )
                            : SizedBox(),
                      ],
                    );
                  },
                ),

                BlocBuilder<TimerCubit, TimerState>(
                  builder: (context, state) {
                    if (state is ResendEmailTimerState) {
                      return TextButton(
                        onPressed: state.canResend
                            ? () async {
                                await context
                                    .read<AuthCubit>()
                                    .sendEmailVerifi();
                                await context
                                    .read<TimerCubit>()
                                    .startResendTimer();
                              }
                            : null,
                        child: Text(
                          state.canResend
                              ? AppLocalizations.of(context)!.resendEmail
                              : state.secondsLeft.toString(),
                          style: Theme.of(context).textTheme.bodyMedium!,
                        ),
                      );
                    }
                    return TextButton(
                      onPressed: () async {
                        await context.read<AuthCubit>().sendEmailVerifi();
                        await context.read<TimerCubit>().startResendTimer();
                      },

                      child: Text(
                        AppLocalizations.of(context)!.resendEmail,
                        style: Theme.of(context).textTheme.bodyMedium!,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
