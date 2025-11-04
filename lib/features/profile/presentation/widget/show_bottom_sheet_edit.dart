import 'package:ecomerc_app_with_admin/core/helper/app_validate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../core/responsive/app_size.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../auth/presentation/bloc/user_cubit/user_cubit.dart';
import '../../../auth/presentation/widget/custom_textformfield.dart';
import 'ccustom_clipper_edit_profile.dart';

PersistentBottomSheetController myshowbottomSheet(
  context, {
  final bool name = false,
  final bool phone = false,
  required final GlobalKey<FormState> key,
  required final TextEditingController controler,

  required final String hint,
}) {
  return showBottomSheet(
    enableDrag: true,
    context: context,
    builder: (context) {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppTheme.isdark(context) ? Colors.white : Colors.black,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        height: AppSize.hight(context) * 0.5,
        padding: EdgeInsets.all(12.w),

        child: Form(
          key: key,
          child: Column(
            children: [
              ClipPath(
                clipper: CustomClipprofile(),
                child: Container(
                  width: double.infinity,
                  height: 20,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color.fromARGB(255, 97, 151, 245),
                        Theme.of(context).primaryColor,
                        const Color.fromARGB(255, 9, 47, 112),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: AppSize.spacehight3(context)),
              MyTextFormField(
                controller: controler,
                validator: phone
                    ? AppValidators.validatePhone
                    : AppValidators.validateName,
                prefixicon: Icon(Iconsax.user_copy),
                label: hint,
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: AppSize.spacehight2(context)),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(8.0),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),

                  onPressed: () async {
                    if (key.currentState!.validate()) {
                      if (name) {
                        context.read<UserCubit>().ubdateUser(
                          name: controler.text,
                        );
                        Navigator.pop(context);
                        controler.clear();
                      }
                      if (phone) {
                        context.read<UserCubit>().ubdateUser(
                          phone: controler.text,
                        );

                        Navigator.maybePop(context);
                        controler.clear();
                      }
                    }
                  },
                  child: BlocBuilder<UserCubit, UserState>(
                    builder: (context, state) {
                      return state is Userlodingstate
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text(
                              AppLocalizations.of(context)!.submit,
                              style: Theme.of(context).textTheme.bodyMedium!
                                  .copyWith(color: Colors.white),
                            );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
