import 'package:ecomerc_app_with_admin/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../core/responsive/app_size.dart';
import '../../../../l10n/app_localizations.dart';

class CustomSearch extends StatelessWidget {
  final bool isdefault;
  const CustomSearch({super.key, this.isdefault = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 45.h,

      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isdefault ? Colors.black12 : Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: [
          Icon(
            Iconsax.search_normal_copy,
            color: isdefault
                ? AppTheme.isdark(context)
                      ? Colors.white
                      : Colors.black
                : Colors.black45,
            size: 20.h,
          ),
          SizedBox(width: AppSize.width(context) * 0.02),
          Text(
            AppLocalizations.of(context)!.search,
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
              color: isdefault ? null : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
