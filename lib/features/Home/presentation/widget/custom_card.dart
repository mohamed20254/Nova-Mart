import 'package:ecomerc_app_with_admin/core/constant/app_icons.dart';
import 'package:ecomerc_app_with_admin/core/responsive/app_size.dart';
import 'package:ecomerc_app_with_admin/core/routing/app_routing.dart';
import 'package:ecomerc_app_with_admin/core/theme/app_theme.dart';
import 'package:ecomerc_app_with_admin/features/Home/domain/entity/product_entity.dart';

import 'package:ecomerc_app_with_admin/features/Home/presentation/widget/custom_icon_favorite.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCard extends StatelessWidget {
  final ProductEntity product;
  const CustomCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AppRouting.prudicdetils);
      },
      child: Card(
        color: AppTheme.isdark(context) ? Colors.white24 : Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildimage(context),
            _buildbody(context),
            _buildaddCart(context),
          ],
        ),
      ),
    );
  }

  Align _buildaddCart(BuildContext context) {
    return Align(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("${product.price.toStringAsFixed(2)} "),
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: AppTheme.isdark(context) ? Colors.white : Colors.black,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomRight: Radius.circular(14),
              ),
            ),
            child: Center(
              child: Icon(
                Icons.add,
                color: AppTheme.isdark(context) ? Colors.black : Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildbody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.title,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
              color: AppTheme.isdark(context) ? Colors.white : Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: AppSize.spacehight1(context)),
          nike(context, product.brand),

          // SizedBox(height: 55.h),
        ],
      ),
    );
  }

  Stack _buildimage(context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          child: Card(
            child: Image.network(
              product.images[0],
              height: 130.h,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.error);
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ),
        Positioned(top: 5, right: 5, child: CustomIconFavorite()),
        Positioned(
          top: 5,
          left: 10,
          child: Customdiscound(percent: product.discountPercentage),
        ),
      ],
    );
  }
}

class Customdiscound extends StatelessWidget {
  final double percent;
  const Customdiscound({super.key, required this.percent});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25.h,
      width: 40.w,
      decoration: BoxDecoration(
        color: Colors.yellow,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          "$percent%",
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

Row nike(BuildContext context, final String brand) {
  return Row(
    children: [
      Text(
        brand,
        style: Theme.of(context).textTheme.labelLarge!.copyWith(
          color: AppTheme.isdark(context) ? Colors.white70 : Colors.black87,
        ),
      ),
      SizedBox(width: AppSize.spacewWidth1(context)),
      Image.asset(AppIcons.sucsess, height: 20.h),
    ],
  );
}
