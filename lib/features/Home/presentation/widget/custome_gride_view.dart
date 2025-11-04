import 'package:ecomerc_app_with_admin/features/Home/domain/entity/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_card.dart';

class CustomeGrideView extends StatelessWidget {
  final List<ProductEntity> products;
  const CustomeGrideView({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 10.h,
        crossAxisSpacing: 10.w,
        crossAxisCount: 2,
        childAspectRatio: 0.75,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return CustomCard(product: products[index]);
      },
    );
  }
}
