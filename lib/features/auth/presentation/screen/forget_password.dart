import 'package:ecomerc_app_with_admin/core/constant/string.dart';
import 'package:ecomerc_app_with_admin/core/helper/app_validate.dart';
import 'package:ecomerc_app_with_admin/core/responsive/app_size.dart';
import 'package:ecomerc_app_with_admin/core/routing/app_routing.dart';
import 'package:ecomerc_app_with_admin/core/theme/widget/app_widget.dart';
import 'package:ecomerc_app_with_admin/features/auth/presentation/bloc/auth_cubit/auth_cubit.dart';
import 'package:ecomerc_app_with_admin/features/auth/presentation/widget/custom_button_signup.dart';
import 'package:ecomerc_app_with_admin/features/auth/presentation/widget/custom_textformfield.dart';
import 'package:ecomerc_app_with_admin/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController emailControler;
  @override
  void initState() {
    emailControler = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.all(8.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(height: AppSize.hight(context) * 0.01),
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
                SizedBox(height: AppSize.hight(context) * 0.03),
                Text(
                  AppLocalizations.of(context)!.forgetPasswordTitle,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(height: AppSize.hight(context) * 0.02),
                Text(
                  AppLocalizations.of(context)!.forgetPasswordSubtitle,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                SizedBox(height: AppSize.hight(context) * 0.04),
                MyTextFormField(
                  validator: AppValidators.validateEmail,
                  controller: emailControler,
                  label: AppLocalizations.of(context)!.email,
                  keyboardType: TextInputType.emailAddress,
                  prefixicon: Icon(Ionicons.mail_outline),
                ),
                SizedBox(height: AppSize.hight(context) * 0.02),
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is RestetPassFailuerState) {
                      if (state.message.contains(AppStrings.nowInternete)) {
                        AppWidget.showsnackbarNoInternete(context);
                      } else {
                        AppWidget.showsnackbar(context, state.message);
                      }
                    }
                    if (state is RestetPassSuccessState) {
                      Navigator.pushNamed(
                        context,
                        AppRouting.resetpassdone,
                        arguments: emailControler.text,
                      );
                    }
                  },
                  builder: (context, state) {
                    return SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          padding: EdgeInsets.all(5),
                          backgroundColor: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(12),
                          ),
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            context.read<AuthCubit>().restetPassword(
                              emailControler.text,
                            );
                          }
                        },
                        child: state is RestetPassLoadingState
                            ? CircularProgressIndicator(color: Colors.white)
                            : Text(
                                AppLocalizations.of(context)!.submit,
                                style: Theme.of(context).textTheme.bodyMedium!
                                    .copyWith(color: Colors.white),
                              ),
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
