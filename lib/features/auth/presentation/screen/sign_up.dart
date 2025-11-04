import 'package:ecomerc_app_with_admin/core/constant/app_images.dart'
    show AppImages;
import 'package:ecomerc_app_with_admin/core/helper/app_validate.dart';
import 'package:ecomerc_app_with_admin/core/responsive/app_size.dart';
import 'package:ecomerc_app_with_admin/core/theme/app_theme.dart';
import 'package:ecomerc_app_with_admin/core/theme/widget/app_widget.dart';
import 'package:ecomerc_app_with_admin/features/auth/presentation/bloc/auth_cubit/auth_cubit.dart';
import 'package:ecomerc_app_with_admin/features/auth/presentation/widget/coustom_socile.dart';
import 'package:ecomerc_app_with_admin/features/auth/presentation/widget/custom_button_signup.dart';
import 'package:ecomerc_app_with_admin/features/auth/presentation/widget/custom_textformfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../core/routing/app_routing.dart';
import '../../../../l10n/app_localizations.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  ValueNotifier<bool> isprivecy = ValueNotifier(false);
  ValueNotifier<bool> isError = ValueNotifier(false);
  final TextEditingController emailcontroler = TextEditingController();
  final TextEditingController firestcontroler = TextEditingController();
  final TextEditingController lastControler = TextEditingController();
  final TextEditingController phoneControler = TextEditingController();
  final TextEditingController passwordControler = TextEditingController();
  final TextEditingController userNameControler = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SignupSuccessState) {
          Navigator.pushNamed(
            context,
            AppRouting.verfivation,
            arguments: emailcontroler.text,
          );
        } else if (state is SignupFailureState) {
          final currentUser = FirebaseAuth.instance.currentUser;

          if (state.message ==
              'The email is already registered. Please try signing in.') {
            if (currentUser != null && !currentUser.emailVerified) {
              Navigator.of(
                context,
              ).pushNamed(AppRouting.verfivation, arguments: currentUser.email);
            } else {
              AppWidget.showsnackbar(
                context,
                "This email is already registered. Please log in instead.",
              );
            }
          } else {
            AppWidget.showsnackbar(context, state.message);
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(elevation: 0.0),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.letsCreateYourAccount,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  SizedBox(height: AppSize.hight(context) * 0.02),
                  _buildTextFormFiled(context),

                  SizedBox(height: AppSize.hight(context) * 0.02),
                  _buildchecbox(context),
                  _buildbutton(context),
                  SizedBox(height: AppSize.hight(context) * 0.02),
                  _orsigin(context),
                  SizedBox(height: AppSize.hight(context) * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      customSocil(
                        context,
                        child: Image.asset(AppImages.google, height: 40.h),
                      ),
                      SizedBox(width: AppSize.width(context) * 0.03),
                      customSocil(
                        context,
                        child: Icon(
                          FontAwesomeIcons.facebookF,
                          color: Theme.of(context).primaryColor,
                          size: 40.h,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row _buildchecbox(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
          valueListenable: isprivecy,
          builder: (context, isvalue, child) {
            return ValueListenableBuilder(
              valueListenable: isError,
              builder: (context, iserrorvaluo, child) {
                return Checkbox(
                  checkColor: Colors.white,
                  focusColor: Theme.of(context).primaryColor,

                  isError: iserrorvaluo,
                  value: isvalue,
                  onChanged: (value) {
                    isprivecy.value = !isprivecy.value;
                    if (iserrorvaluo) {
                      isError.value = false;
                    }
                  },
                );
              },
            );
          },
        ),
        Text(
          "${AppLocalizations.of(context)!.iAgreeTo}  ",
          style: Theme.of(context).textTheme.labelLarge,
        ),
        Text(
          AppLocalizations.of(context)!.privacyPolicy,
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
            fontWeight: FontWeight.w800,
            color: Theme.of(context).primaryColor,
            decorationColor: Theme.of(context).primaryColor,
            decoration: TextDecoration.combine([TextDecoration.underline]),
          ),
        ),
        Text(
          " ${AppLocalizations.of(context)!.and} ",
          style: Theme.of(context).textTheme.labelLarge,
        ),
        Text(
          AppLocalizations.of(context)!.termsOfUse,
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
            fontWeight: FontWeight.w800,
            color: Theme.of(context).primaryColor,
            decorationColor: Theme.of(context).primaryColor,
            decoration: TextDecoration.combine([TextDecoration.underline]),
          ),
        ),
      ],
    );
  }

  ValueListenableBuilder _buildbutton(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isprivecy,
      builder: (context, value, child) {
        return CustomButtonSignup(
          text: AppLocalizations.of(context)!.signupTitle,
          onPressed: () {
            if (formkey.currentState!.validate()) {
              if (value) {
                context.read<AuthCubit>().createAccount(
                  name: "${firestcontroler.text} ${lastControler.text}",
                  email: emailcontroler.text,
                  password: passwordControler.text,
                  phone: phoneControler.text,
                );
              } else {
                isError.value = true;
              }
            }
          },
        );
      },
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
          "  ${AppLocalizations.of(context)!.orSignInWith} ",
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

  Column _buildTextFormFiled(context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: MyTextFormField(
                controller: firestcontroler,
                label: AppLocalizations.of(context)!.firstName,
                keyboardType: TextInputType.name,
                prefixicon: Icon(Ionicons.person_outline),
              ),
            ),
            SizedBox(width: AppSize.width(context) * 0.02),
            Expanded(
              child: MyTextFormField(
                controller: lastControler,
                label: AppLocalizations.of(context)!.secondName,
                keyboardType: TextInputType.name,
                prefixicon: Icon(Ionicons.person_outline),
                validator: AppValidators.validateName,
              ),
            ),
          ],
        ),
        SizedBox(height: AppSize.hight(context) * 0.02),
        MyTextFormField(
          controller: userNameControler,
          label: AppLocalizations.of(context)!.username,
          keyboardType: TextInputType.name,
          prefixicon: Icon(Ionicons.person_add_outline),
          validator: AppValidators.validateName,
        ),
        SizedBox(height: AppSize.hight(context) * 0.02),
        MyTextFormField(
          controller: emailcontroler,
          label: AppLocalizations.of(context)!.email,
          keyboardType: TextInputType.emailAddress,
          prefixicon: Icon(Ionicons.mail_open_outline),
          validator: AppValidators.validateEmail,
        ),
        SizedBox(height: AppSize.hight(context) * 0.02),
        MyTextFormField(
          controller: phoneControler,
          label: AppLocalizations.of(context)!.phoneNumber,
          keyboardType: TextInputType.phone,
          prefixicon: Icon(Icons.local_phone_outlined),
          validator: AppValidators.validatePhone,
        ),
        SizedBox(height: AppSize.hight(context) * 0.02),
        MyTextFormField(
          controller: passwordControler,
          label: AppLocalizations.of(context)!.password,
          keyboardType: TextInputType.text,
          prefixicon: Icon(Ionicons.lock_closed_outline),
          validator: AppValidators.validatePassword,
          obsqurtext: true,
        ),
      ],
    );
  }
}
