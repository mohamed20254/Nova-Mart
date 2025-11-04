import 'package:ecomerc_app_with_admin/core/constant/app_icons.dart';
import 'package:ecomerc_app_with_admin/core/responsive/app_size.dart';
import 'package:ecomerc_app_with_admin/core/theme/app_theme.dart';
import 'package:ecomerc_app_with_admin/features/Home/data/model/product_model.dart';
import 'package:ecomerc_app_with_admin/features/Home/presentation/widget/botom_add_cart.dart';
import 'package:ecomerc_app_with_admin/features/Home/presentation/widget/custom_icon_favorite.dart';
import 'package:ecomerc_app_with_admin/features/auth/presentation/widget/custom_button_signup.dart';
import 'package:ecomerc_app_with_admin/features/profile/presentation/widget/custom_clipper_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrudicDetilsScreen extends StatelessWidget {
  final ProductModel data;
  const PrudicDetilsScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BotomAddCart(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildiviewImage(context),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildShareandrate(context),
                  _buildPrice(context),
                  SizedBox(height: AppSize.spacehight1(context)),
                  Text(
                    "Green Nike sports shoe",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  SizedBox(height: AppSize.spacehight1(context)),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "stock",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        TextSpan(
                          text: "Is Stock",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: AppSize.spacehight1(context)),
                  // nike(context ),
                  SizedBox(height: AppSize.spacehight3(context)),
                  _buildColor(context),
                  SizedBox(height: AppSize.spacehight2(context)),
                  _buildSize(context),
                  SizedBox(height: AppSize.spacehight3(context)),
                  CustomButtonSignup(text: "checkout", onPressed: () {}),
                  _builddescription(context),
                  SizedBox(height: AppSize.spacehight2(context)),
                  Divider(),
                  SizedBox(height: AppSize.spacehight2(context)),
                  Text(
                    "reivew (124)",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column _builddescription(BuildContext context) {
    return Column(
      children: [
        Text("description", style: Theme.of(context).textTheme.titleSmall),
        SizedBox(height: AppSize.spacehight2(context)),
        Text(
          "i mohamed fawzy aparaherjk",
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ],
    );
  }

  Column _buildSize(BuildContext context) {
    return Column(
      children: [
        Text("Size", style: Theme.of(context).textTheme.bodyLarge),
        Row(
          children: List.generate(3, (index) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                border: Border.all(color: Colors.black),
              ),
              margin: EdgeInsets.symmetric(horizontal: 5),
              padding: EdgeInsets.all(8),
              height: 40.h,
              child: Text(
                "Eu 32",
                style: Theme.of(context).textTheme.labelLarge,
              ),
            );
          }),
        ),
      ],
    );
  }

  Column _buildColor(BuildContext context) {
    return Column(
      children: [
        Text("Color", style: Theme.of(context).textTheme.bodyLarge),
        Row(
          children: List.generate(
            3,
            (index) => Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              height: 25.h,
              width: 25.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row _buildPrice(BuildContext context) {
    return Row(
      children: [
        // Customdiscound(),
        SizedBox(width: AppSize.spacewWidth1(context)),
        Text("\$122.6 -\$334.0", style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }

  Row _buildShareandrate(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.star_rate, color: Colors.amber),
        SizedBox(width: AppSize.spacehight1(context)),
        Text("0.5 (199)", style: Theme.of(context).textTheme.labelMedium),
        Spacer(),
        IconButton(onPressed: () {}, icon: Icon(Icons.share)),
      ],
    );
  }

  ClipPath _buildiviewImage(BuildContext context) {
    return ClipPath(
      clipper: CustomClipperProfile(),
      child: Container(
        height: AppSize.hight(context) * 0.4,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppTheme.isdark(context) ? Colors.white10 : Colors.black12,
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                left: 70.w,

                child: Image.asset(AppIcons.logo, height: 200.h),
              ),
              Positioned(top: 5, right: 10, child: CustomIconFavorite()),
              Positioned(
                top: 5,
                left: 5,
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios_new_rounded),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Positioned(
                bottom: 20.h,
                right: 0,
                left: 0,

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: List.generate(
                    4,
                    (index) => Container(
                      height: 90.h,
                      width: 80.w,
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Image.asset(AppIcons.logo),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
