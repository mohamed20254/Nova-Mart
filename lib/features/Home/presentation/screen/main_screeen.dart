import 'package:ecomerc_app_with_admin/features/Home/presentation/screen/home_scrren.dart';
import 'package:ecomerc_app_with_admin/features/auth/presentation/bloc/auth_cubit/auth_cubit.dart';
import 'package:ecomerc_app_with_admin/features/profile/presentation/screen/profile_screen.dart';
import 'package:ecomerc_app_with_admin/features/store/presentation/screen/store_screen.dart';
import 'package:ecomerc_app_with_admin/features/wishlist/presentation/screen/wishlist_screen.dart';
import 'package:ecomerc_app_with_admin/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class MainScreeen extends StatefulWidget {
  const MainScreeen({super.key});

  @override
  State<MainScreeen> createState() => _MainScreeenState();
}

class _MainScreeenState extends State<MainScreeen> {
  @override
  void initState() {
    context.read<AuthCubit>().userupdate();
    super.initState();
  }

  final List<Widget> screens = [
    HomeScrren(),
    StoreScreen(),
    WishlistScreen(),
    ProfileScreen(),
  ];
  ValueNotifier<int> currentIndex = ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentIndex,
      builder: (context, value, child) {
        return Scaffold(
          bottomNavigationBar: _navigationBar(value),
          body: IndexedStack(index: value, children: screens),
        );
      },
    );
  }

  Widget _navigationBar(int value) {
    return NavigationBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      indicatorColor: Theme.of(context).primaryColor.withValues(alpha: 0.5),
      elevation: 0.0,
      labelTextStyle: WidgetStateProperty.all(
        Theme.of(context).textTheme.labelLarge,
      ),
      height: 70.h,
      selectedIndex: value,
      onDestinationSelected: (slectedindex) =>
          currentIndex.value = slectedindex,
      destinations: [
        NavigationDestination(
          icon: Icon(Iconsax.home_2_copy),
          label: AppLocalizations.of(context)!.home,
        ),
        NavigationDestination(
          icon: Icon(Iconsax.shop_copy),
          label: AppLocalizations.of(context)!.store,
        ),
        NavigationDestination(
          icon: Icon(Iconsax.heart_copy),
          label: AppLocalizations.of(context)!.wishlist,
        ),
        NavigationDestination(
          icon: Icon(Iconsax.user_copy),
          label: AppLocalizations.of(context)!.profile,
        ),
      ],
    );
  }
}
