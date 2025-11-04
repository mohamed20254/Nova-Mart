import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../core/theme/app_theme.dart';

class CustomIconFavorite extends StatelessWidget {
  const CustomIconFavorite({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.h,
      width: 30.w,
      decoration: BoxDecoration(
        color: AppTheme.isdark(context) ? Colors.black : Colors.white,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(Iconsax.heart, color: Colors.red, size: 20.h),
      ),
    );
  }
}
