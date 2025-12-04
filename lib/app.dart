import 'package:ecomerc_app_with_admin/core/routing/app_routing.dart';
import 'package:ecomerc_app_with_admin/core/theme/app_theme.dart';
import 'package:ecomerc_app_with_admin/core/theme/them_cubit.dart';
import 'package:ecomerc_app_with_admin/features/auth/presentation/bloc/auth_cubit/auth_cubit.dart';
import 'package:ecomerc_app_with_admin/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:ecomerc_app_with_admin/features/wishlist/presentation/bloc/favorit_cuibt/favvorit_cubit.dart';
import 'package:ecomerc_app_with_admin/l10n/app_localizations.dart';
import 'package:ecomerc_app_with_admin/core/localization/localization_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/di/injection_container.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(final BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (final context) => ThemCubit()),
        BlocProvider(create: (final context) => LocalizationCubit()),
        BlocProvider(create: (final context) => sl<AuthCubit>()),
        BlocProvider(create: (final context) => sl<FavvoritCubit>()),
        BlocProvider(create: (final context) => sl<CartCubit>()),
      ],
      child: BlocBuilder<ThemCubit, ThemeMode>(
        builder: (final context, final thememode) {
          return BlocBuilder<LocalizationCubit, String>(
            builder: (final context, final lang) {
              return ScreenUtilInit(
                designSize: const Size(375, 812),
                builder: (final context, final child) => MaterialApp(
                  locale: Locale(lang),
                  localizationsDelegates:
                      AppLocalizations.localizationsDelegates,
                  supportedLocales: AppLocalizations.supportedLocales,
                  onGenerateRoute: AppRouting.ongenerating,
                  debugShowCheckedModeBanner: false,
                  themeMode: thememode,

                  theme: AppTheme.lightTheme,
                  darkTheme: AppTheme.darkTheme,
                  title: "Ecommerc_App",
                ),
              );
            },
          );
        },
      ),
    );
  }
}
