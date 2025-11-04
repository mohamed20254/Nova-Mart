import 'package:ecomerc_app_with_admin/core/di/injection_container.dart';
import 'package:ecomerc_app_with_admin/core/local_storage/first_time.dart';
import 'package:ecomerc_app_with_admin/features/Home/data/model/product_model.dart';
import 'package:ecomerc_app_with_admin/features/Home/presentation/bloc/cubit/category_cubit.dart';
import 'package:ecomerc_app_with_admin/features/Home/presentation/bloc/prudic_cubit/product_cubit.dart';
import 'package:ecomerc_app_with_admin/features/Home/presentation/screen/home_scrren.dart';
import 'package:ecomerc_app_with_admin/features/Home/presentation/screen/main_screeen.dart';
import 'package:ecomerc_app_with_admin/features/Home/presentation/screen/prudic_detils_screen.dart';
import 'package:ecomerc_app_with_admin/features/auth/presentation/bloc/timer_cubit/cubit/timer_cubit.dart';
import 'package:ecomerc_app_with_admin/features/auth/presentation/bloc/user_cubit/user_cubit.dart';
import 'package:ecomerc_app_with_admin/features/auth/presentation/screen/forget_password.dart';
import 'package:ecomerc_app_with_admin/features/auth/presentation/screen/login_screen.dart';
import 'package:ecomerc_app_with_admin/features/auth/presentation/screen/reset_pass_done.dart';
import 'package:ecomerc_app_with_admin/features/auth/presentation/screen/sign_up.dart';
import 'package:ecomerc_app_with_admin/features/auth/presentation/screen/verfication_sucsess.dart';
import 'package:ecomerc_app_with_admin/features/auth/presentation/screen/verification_email.dart';
import 'package:ecomerc_app_with_admin/features/onboarding/presentation/onbording_screen.dart';
import 'package:ecomerc_app_with_admin/features/profile/presentation/screen/edite_profile_information_screen.dart';
import 'package:ecomerc_app_with_admin/features/profile/presentation/screen/profile_screen.dart';
import 'package:ecomerc_app_with_admin/features/store/presentation/screen/store_screen.dart';
import 'package:ecomerc_app_with_admin/features/wishlist/presentation/screen/wishlist_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouting {
  static const String onbording = "/onboarding";
  static const String login = "/login";
  static const String signUp = "/signup";
  static const String forrgetpass = "/forgetpass";
  static const String resetpassdone = "/resetepasswordone";
  static const String verfivation = "/verification";
  static const String verficationsucess = "/fverificationsucsess";
  static const String mainScreen = "/mainScreen";
  static const String homeScreen = "/homescreen";
  static const String storeScreen = "/storescreen";
  static const String wishListScreen = "/wishListscreen";
  static const String profileScren = "/profilescreen";
  static const String prudicdetils = "/prudictdetils";
  static const String editeprofile = "/editeprofileinformationscreen";
  static Route<dynamic>? ongenerating(RouteSettings setting) {
    switch (setting.name) {
      case "/":
        {
          final user = FirebaseAuth.instance.currentUser;
          return MaterialPageRoute(
            builder: (context) => IsFirstTime.getFirstTime()
                ? OnbordingScreen()
                : user != null && user.emailVerified
                ? MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (context) => sl<UserCubit>()..getUser(),
                      ),
                      BlocProvider(create: (context) => sl<CategoryCubit>()),
                      BlocProvider(
                        create: (context) => sl<ProductCubit>()..getProduct(),
                      ),
                    ],
                    child: MainScreeen(),
                  )
                : LoginScreen(),
          );
        }
      case onbording:
        return MaterialPageRoute(builder: (context) => OnbordingScreen());
      case login:
        return MaterialPageRoute(builder: (context) => LoginScreen());
      case signUp:
        return MaterialPageRoute(builder: (context) => SignUpScreen());
      case forrgetpass:
        return MaterialPageRoute(builder: (context) => ForgetPassword());
      case verfivation:
        {
          final args = setting.arguments as String;

          return MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => TimerCubit(),
              child: VerificationEmail(email: args),
            ),
          );
        }
      case verficationsucess:
        return MaterialPageRoute(builder: (context) => VerficationSucsess());
      case resetpassdone:
        {
          final arg = setting.arguments as String;
          return MaterialPageRoute(
            builder: (context) => ResetPassDone(email: arg),
          );
        }

      case mainScreen:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => sl<UserCubit>()..getUser()),
              BlocProvider(create: (context) => sl<CategoryCubit>()),
              BlocProvider(
                create: (context) => sl<ProductCubit>()..getProduct(),
              ),
            ],
            child: MainScreeen(),
          ),
        );
      case homeScreen:
        return MaterialPageRoute(builder: (context) => HomeScrren());
      case storeScreen:
        return MaterialPageRoute(builder: (context) => StoreScreen());
      case wishListScreen:
        return MaterialPageRoute(builder: (context) => WishlistScreen());
      case profileScren:
        return MaterialPageRoute(builder: (context) => ProfileScreen());
      case editeprofile:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => sl<UserCubit>()..getUser(),
            child: EditeProfileInformationScreen(),
          ),
        );
      case prudicdetils:
        {
          final arg = setting.arguments as ProductModel;
          return MaterialPageRoute(
            builder: (context) => PrudicDetilsScreen(data: arg),
          );
        }
      default:
        return MaterialPageRoute(builder: (context) => DefaultScreen());
    }
  }
}

class DefaultScreen extends StatelessWidget {
  const DefaultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(children: [Center(child: Text("NoRouting"))]);
  }
}
