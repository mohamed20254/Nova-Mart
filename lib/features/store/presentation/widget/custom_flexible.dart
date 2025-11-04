import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/responsive/app_size.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../Home/presentation/widget/custom_search.dart';
import 'feature_card.dart';

class CustomFlexible extends StatelessWidget {
  const CustomFlexible({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 12.h),
        child: ListView(
          //  mainAxisSize: MainAxisSize.min,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            SizedBox(height: AppSize.spacehight1(context)),
            CustomSearch(isdefault: true),
            SizedBox(height: AppSize.spacehight1(context)),
            _buildviweAll(context),
            SizedBox(height: AppSize.spacehight2(context)),
            Row(
              children: [
                Expanded(child: FeaturedCard()),
                SizedBox(width: AppSize.spacewWidth2(context)),
                Expanded(child: FeaturedCard()),
              ],
            ),
            SizedBox(height: AppSize.spacehight2(context)),
            Row(
              children: [
                Expanded(child: FeaturedCard()),
                SizedBox(width: AppSize.spacewWidth2(context)),
                Expanded(child: FeaturedCard()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Row _buildviweAll(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppLocalizations.of(context)!.featuredbrands,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500),
        ),
        Text(
          AppLocalizations.of(context)!.viewall,
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
