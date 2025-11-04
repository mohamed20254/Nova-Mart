import 'package:ecomerc_app_with_admin/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class PadgeCard extends StatelessWidget {
  const PadgeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Iconsax.shopping_bag_copy,
            size: 22.w,
            color: AppTheme.isdark(context) ? Colors.white : Colors.black,
          ),
        ),
        Positioned(
          right: 4,
          top: 0.0,
          child: Container(
            padding: EdgeInsets.all(1),
            height: 18.h,
            width: 18.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black,
            ),
            child: Text(
              "1",
              style: Theme.of(
                context,
              ).textTheme.labelMedium!.copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
