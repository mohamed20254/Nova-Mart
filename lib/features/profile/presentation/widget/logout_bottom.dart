import 'package:ecomerc_app_with_admin/core/theme/widget/app_widget.dart';
import 'package:ecomerc_app_with_admin/core/theme/widget/custom_looding.dart';
import 'package:ecomerc_app_with_admin/features/auth/presentation/bloc/auth_cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/responsive/app_size.dart';
import '../../../../core/routing/app_routing.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../l10n/app_localizations.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginFailureState) {
          AppWidget.showsnackbar(context, state.message);
        }
        if (state is LogoutSuccessState) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRouting.login,
            (route) => false,
          );
        }
        if (state is LogoutLoadingState) {
          LoadingOverlay.show(context);
        } else {
          LoadingOverlay.hide();
        }
      },
      child: SizedBox(
        width: AppSize.width(context),
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(10),
            ),
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(
                    AppLocalizations.of(context)!.logout,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  content: Text(
                    AppLocalizations.of(context)!.logoutDesc,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),

                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(AppLocalizations.of(context)!.cancel),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(10),
                        ),
                      ),
                      onPressed: () {
                        context.read<AuthCubit>().logout();
                      },
                      child: Text(AppLocalizations.of(context)!.confirm),
                    ),
                  ],
                );
              },
            );
          },
          child: Text(
            AppLocalizations.of(context)!.logout,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: AppTheme.isdark(context) ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
