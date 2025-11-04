import 'package:ecomerc_app_with_admin/core/constant/app_icons.dart';
import 'package:ecomerc_app_with_admin/core/constant/app_images.dart';
import 'package:ecomerc_app_with_admin/core/constant/string.dart';
import 'package:ecomerc_app_with_admin/core/helper/app_validate.dart';
import 'package:ecomerc_app_with_admin/core/responsive/app_size.dart';
import 'package:ecomerc_app_with_admin/core/routing/app_routing.dart';
import 'package:ecomerc_app_with_admin/core/theme/app_theme.dart';
import 'package:ecomerc_app_with_admin/core/theme/widget/app_widget.dart';
import 'package:ecomerc_app_with_admin/core/theme/widget/custom_looding.dart';
import 'package:ecomerc_app_with_admin/features/auth/presentation/bloc/auth_cubit/auth_cubit.dart';
import 'package:ecomerc_app_with_admin/features/auth/presentation/widget/coustom_socile.dart';
import 'package:ecomerc_app_with_admin/features/auth/presentation/widget/custom_textformfield.dart';
import 'package:ecomerc_app_with_admin/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailcontroler = TextEditingController();
  final TextEditingController passwordControler = TextEditingController();
  ValueNotifier<bool> rememper = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRouting.mainScreen,
              (route) => false,
            );
          } else if (state is LoginFailureState) {
            if (state.message.contains("user-unveifi")) {
              Navigator.pushNamed(
                context,
                AppRouting.verfivation,
                arguments: emailcontroler.text,
              );
            } else {
              AppWidget.showsnackbar(context, state.message);
            }
          } else if (state is GoogleSuccessState) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRouting.mainScreen,
              (route) => false,
            );
          } else if (state is GoogleFailuerState) {
            if (state.message.contains(AppStrings.nowInternete)) {
              AppWidget.showsnackbarNoInternete(context);
            } else {
              AppWidget.showsnackbar(context, state.message);
            }
          }
          if (state is GoogleLoadinState) {
            LoadingOverlay.show(context);
          } else {
            LoadingOverlay.hide();
          }
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(AppIcons.logo, height: 100.h),
                    Text(
                      AppLocalizations.of(context)!.loginTitle,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      AppLocalizations.of(context)!.loginSubtitle,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    SizedBox(height: AppSize.hight(context) * 0.03),
                    MyTextFormField(
                      controller: emailcontroler,
                      validator: AppValidators.validateEmail,
                      label: AppLocalizations.of(context)!.email,
                      keyboardType: TextInputType.emailAddress,
                      obsqurtext: false,
                      prefixicon: Icon(Icons.email_outlined),
                    ),
                    SizedBox(height: AppSize.hight(context) * 0.02),
                    MyTextFormField(
                      controller: passwordControler,
                      validator: AppValidators.validatePassword,
                      label: AppLocalizations.of(context)!.password,
                      keyboardType: TextInputType.text,
                      obsqurtext: true,
                      prefixicon: Icon(Icons.lock_outline_rounded),
                    ),
                    SizedBox(height: AppSize.hight(context) * 0.02),
                    _forgetpass(context),
                    SizedBox(height: AppSize.hight(context) * 0.03),
                    _builbottom(context),
                    SizedBox(height: AppSize.hight(context) * 0.02),

                    _orsigin(context),
                    SizedBox(height: AppSize.hight(context) * 0.02),
                    _socile(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row _socile(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () async {
            await context.read<AuthCubit>().googleSign();
          },
          child: customSocil(
            context,
            child: Image.asset(AppImages.google, height: 40.h),
          ),
        ),
        SizedBox(width: AppSize.width(context) * 0.03),
        InkWell(
          onTap: () {},
          child: customSocil(
            context,
            child: Icon(
              FontAwesomeIcons.facebookF,
              color: Theme.of(context).primaryColor,
              size: 40.h,
            ),
          ),
        ),
      ],
    );
  }

  Row _orsigin(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 2,
          width: 50.w,
          decoration: BoxDecoration(
            color: AppTheme.isdark(context) ? Colors.white54 : Colors.black45,
          ),
        ),
        Text(
          "  ${AppLocalizations.of(context)!.orSignInWith}  ",
          style: Theme.of(context).textTheme.labelLarge,
        ),
        Container(
          height: 2,
          width: 50.w,
          decoration: BoxDecoration(
            color: AppTheme.isdark(context) ? Colors.white54 : Colors.black45,
          ),
        ),
      ],
    );
  }

  SizedBox _builbottom(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          SizedBox(
            width: AppSize.width(context),
            child: FilledButton(
              style: FilledButton.styleFrom(
                padding: EdgeInsets.all(9.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(12),
                ),
                backgroundColor: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  context.read<AuthCubit>().login(
                    email: emailcontroler.text,
                    password: passwordControler.text,
                  );
                }
              },
              child: Text(
                AppLocalizations.of(context)!.signInNow,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: AppSize.hight(context) * 0.01),
          SizedBox(
            width: AppSize.width(context),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.all(9.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, AppRouting.signUp);
              },
              child: Text(
                AppLocalizations.of(context)!.signupTitle,
                style: Theme.of(context).textTheme.bodyMedium!,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row _forgetpass(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
          valueListenable: rememper,
          builder: (context, value, child) {
            return Checkbox(
              activeColor: Theme.of(context).primaryColor,
              value: value,
              onChanged: (value) {
                rememper.value = !rememper.value;
              },
            );
          },
        ),
        Text(
          AppLocalizations.of(context)!.rememberMe,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Spacer(),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRouting.forrgetpass);
          },
          child: Text(
            AppLocalizations.of(context)!.forgotPassword,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      ],
    );
  }
}
