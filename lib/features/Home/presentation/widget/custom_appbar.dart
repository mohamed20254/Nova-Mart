import 'package:ecomerc_app_with_admin/core/theme/widget/app_widget.dart';
import 'package:ecomerc_app_with_admin/features/Home/presentation/widget/padge_card.dart';
import 'package:ecomerc_app_with_admin/features/auth/presentation/bloc/user_cubit/user_cubit.dart';
import 'package:ecomerc_app_with_admin/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppLocalizations.of(context)!.gooddayforshopping,
              style: Theme.of(
                context,
              ).textTheme.labelLarge!.copyWith(color: Colors.white70),
            ),
            BlocConsumer<UserCubit, UserState>(
              listener: (context, state) {
                if (state is UserFailureState) {
                  AppWidget.showsnackbar(context, state.messige);
                }
              },

              builder: (context, state) {
                return Text(
                  state is UsersuccessState
                      ? state.userEntity.displayName
                      : "name",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(color: Colors.white),
                );
              },
            ),
          ],
        ),
        Spacer(),
        PadgeCard(),
      ],
    );
  }
}
