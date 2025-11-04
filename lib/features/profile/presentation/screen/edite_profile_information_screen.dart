import 'package:ecomerc_app_with_admin/core/responsive/app_size.dart';
import 'package:ecomerc_app_with_admin/core/theme/app_theme.dart';
import 'package:ecomerc_app_with_admin/features/auth/presentation/bloc/user_cubit/user_cubit.dart';
import 'package:ecomerc_app_with_admin/features/profile/presentation/widget/show_bottom_sheet_edit.dart';
import 'package:ecomerc_app_with_admin/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class EditeProfileInformationScreen extends StatefulWidget {
  const EditeProfileInformationScreen({super.key});

  @override
  State<EditeProfileInformationScreen> createState() =>
      _EditeProfileInformationScreenState();
}

class _EditeProfileInformationScreenState
    extends State<EditeProfileInformationScreen> {
  late final TextEditingController controler;
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  @override
  void initState() {
    controler = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.profile,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsetsGeometry.all(12.w),
            child: Column(
              children: [
                SizedBox(height: AppSize.spacehight3(context)),
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50.w,
                        child: Icon(Iconsax.user_copy, size: 50.w),
                      ),
                      SizedBox(height: AppSize.spacehight2(context)),
                      Text(
                        "Profile Information",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: AppSize.spacehight2(context)),
                Divider(),
                SizedBox(height: AppSize.spacehight2(context)),

                _customInf(
                  context,
                  ontap: () {
                    myshowbottomSheet(
                      context,
                      hint: AppLocalizations.of(context)!.name,
                      key: key,
                      controler: controler,
                      name: true,
                    );
                  },
                  title: AppLocalizations.of(context)!.name,
                  subTitle: state is UsersuccessState
                      ? state.userEntity.displayName
                      : "Empety",
                ),
                _customInf(
                  context,
                  ontap: () {},
                  title: AppLocalizations.of(context)!.email,
                  subTitle: state is UsersuccessState
                      ? state.userEntity.email
                      : "Empety",
                ),
                _customInf(
                  context,
                  ontap: () {
                    myshowbottomSheet(
                      context,
                      hint: AppLocalizations.of(context)!.phoneNumber,
                      key: key,
                      controler: controler,
                      phone: true,
                    );
                  },
                  title: AppLocalizations.of(context)!.phoneNumber,
                  subTitle: state is UsersuccessState
                      ? state.userEntity.phone ?? "Empety"
                      : "Empety",
                ),
                _customInf(
                  context,
                  ontap: () {},
                  title: "createdAt",
                  subTitle: state is UsersuccessState
                      ? state.userEntity.createdAt.toString()
                      : "Empety",
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Row _customInf(
    BuildContext context, {
    required void Function() ontap,
    required String title,
    required String subTitle,
  }) {
    return Row(
      children: [
        SizedBox(
          width: 110.w,
          child: Text(
            title,
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
              color: AppTheme.isdark(context) ? Colors.white70 : Colors.black87,
            ),
          ),
        ),
        SizedBox(
          width: 190.w,
          child: Text(
            subTitle,
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
              color: AppTheme.isdark(context) ? Colors.white : Colors.black,
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        IconButton(
          onPressed: ontap,
          icon: Icon(Icons.arrow_forward_ios_outlined, size: 20.w),
        ),
      ],
    );
  }
}
