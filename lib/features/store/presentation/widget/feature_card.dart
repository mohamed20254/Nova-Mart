import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constant/app_icons.dart';
import '../../../../core/responsive/app_size.dart';
import '../../../../core/theme/app_theme.dart';

class FeaturedCard extends StatelessWidget {
  const FeaturedCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppTheme.isdark(context) ? Colors.white54 : Colors.black54,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.schedule_send),
          SizedBox(width: AppSize.spacewWidth3(context)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Nike",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: AppTheme.isdark(context)
                          ? Colors.white
                          : Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(width: AppSize.spacewWidth1(context)),
                  Image.asset(AppIcons.sucsess, height: 20.h),
                ],
              ),
              Text(
                "265 prudicts",
                style: Theme.of(context).textTheme.labelLarge,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
