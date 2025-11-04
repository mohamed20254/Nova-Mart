import 'package:ecomerc_app_with_admin/core/responsive/app_size.dart';
import 'package:ecomerc_app_with_admin/features/profile/presentation/widget/custom_section_profile.dart';
import 'package:ecomerc_app_with_admin/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../widget/header_account.dart';
import '../widget/logout_bottom.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderAccount(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                children: [
                  SizedBox(height: AppSize.spacehight2(context)),
                  _buildAccounSettting(context),
                  _buildAppSetting(context),
                  LogoutButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column _buildAppSetting(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.appSetting,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        SizedBox(height: AppSize.spacehight2(context)),
        CustomSectionProfile(
          onTap: () {
            //!ontap====================================loaddata
          },
          icon: Iconsax.filter_add_copy,
          title: Text(AppLocalizations.of(context)!.loadData),
          subtitle: AppLocalizations.of(context)!.loadDataDesc,
        ),
        CustomSectionProfile(
          trailing: Switch(
            value: true,
            onChanged: (value) {
              //
            },
          ),
          onTap: () {
            //!ontap====================================geoLocation
          },
          icon: Iconsax.location_copy,
          title: Text(AppLocalizations.of(context)!.geoLocation),
          subtitle: AppLocalizations.of(context)!.geoLocationDesc,
        ),
        CustomSectionProfile(
          trailing: Switch(
            value: false,
            onChanged: (value) {
              //
            },
          ),
          onTap: () {
            //!ontap====================================safeMode
          },
          icon: Iconsax.security_safe_copy,
          title: Text(AppLocalizations.of(context)!.safeMode),
          subtitle: AppLocalizations.of(context)!.safeModeDesc,
        ),
        CustomSectionProfile(
          trailing: Switch(
            value: false,
            onChanged: (value) {
              //
            },
          ),
          onTap: () {
            //!ontap====================================hdImageQuality
          },
          icon: Iconsax.image_copy,
          title: Text(AppLocalizations.of(context)!.hdImageQuality),
          subtitle: AppLocalizations.of(context)!.hdImageQualityDesc,
        ),
        SizedBox(height: AppSize.spacehight2(context)),
      ],
    );
  }

  Column _buildAccounSettting(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.accountSetting,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        SizedBox(height: AppSize.spacehight2(context)),
        CustomSectionProfile(
          onTap: () {
            //!ontap====================================adresss
          },
          icon: Iconsax.home_2_copy,
          title: Text(AppLocalizations.of(context)!.myAddress),
          subtitle: AppLocalizations.of(context)!.myAddressDesc,
        ),
        CustomSectionProfile(
          onTap: () {
            //!ontap====================================cart
          },
          icon: Iconsax.shopping_bag_copy,
          title: Text(AppLocalizations.of(context)!.myCart),
          subtitle: AppLocalizations.of(context)!.myCartDesc,
        ),
        CustomSectionProfile(
          onTap: () {
            //!ontap====================================orders
          },
          icon: Iconsax.bag_cross_1_copy,
          title: Text(AppLocalizations.of(context)!.myOrders),
          subtitle: AppLocalizations.of(context)!.myOrdersDesc,
        ),
        CustomSectionProfile(
          onTap: () {
            //!ontap====================================bank
          },
          icon: Iconsax.bank_copy,
          title: Text(AppLocalizations.of(context)!.bankAccount),
          subtitle: AppLocalizations.of(context)!.bankAccountDesc,
        ),
        CustomSectionProfile(
          onTap: () {
            //!ontap====================================cuopons
          },
          icon: Iconsax.square_copy,
          title: Text(AppLocalizations.of(context)!.myCoupons),
          subtitle: AppLocalizations.of(context)!.myCouponsDesc,
        ),
        CustomSectionProfile(
          onTap: () {
            //!ontap====================================notification
          },
          icon: Iconsax.notification_copy,
          title: Text(AppLocalizations.of(context)!.notification),
          subtitle: AppLocalizations.of(context)!.notificationDesc,
        ),
        CustomSectionProfile(
          onTap: () {
            //!ontap====================================accountprivicy
          },
          icon: Iconsax.security_copy,
          title: Text(AppLocalizations.of(context)!.accountPrivacy),
          subtitle: AppLocalizations.of(context)!.accountPrivacyDesc,
        ),
      ],
    );
  }
}
