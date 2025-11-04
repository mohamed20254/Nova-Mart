import 'package:ecomerc_app_with_admin/core/routing/app_routing.dart';
import 'package:ecomerc_app_with_admin/features/auth/presentation/bloc/user_cubit/user_cubit.dart';
import 'package:ecomerc_app_with_admin/features/profile/presentation/widget/custom_clipper_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../core/constant/app_images.dart';
import '../../../../core/responsive/app_size.dart';
import '../../../../l10n/app_localizations.dart';

class HeaderAccount extends StatelessWidget {
  const HeaderAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomClipperProfile(),
      child: Container(
        padding: EdgeInsets.all(10),
        height: AppSize.hight(context) * 0.23,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withValues(alpha: 0.95),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.account,
                style: Theme.of(
                  context,
                ).textTheme.titleSmall!.copyWith(color: Colors.white),
              ),
              SizedBox(height: AppSize.spacehight1(context)),
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white70,
                    radius: 25.w,
                    child: Icon(Iconsax.user_copy, size: 25.w),
                  ),
                  SizedBox(width: AppSize.spacewWidth4(context)),
                  BlocBuilder<UserCubit, UserState>(
                    builder: (context, state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state is UsersuccessState
                                ? state.userEntity.displayName
                                : "Name",
                            style: Theme.of(context).textTheme.bodyMedium!
                                .copyWith(color: Colors.white),
                          ),
                          Text(
                            state is UsersuccessState
                                ? state.userEntity.email
                                : "Email",
                            style: Theme.of(context).textTheme.labelLarge!
                                .copyWith(color: Colors.white60),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      );
                    },
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      //!======================================================edite profile
                      Navigator.pushNamed(context, AppRouting.editeprofile);
                    },
                    icon: Icon(Iconsax.edit, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
