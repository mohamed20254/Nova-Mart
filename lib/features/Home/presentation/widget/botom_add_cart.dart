import 'package:ecomerc_app_with_admin/core/responsive/app_size.dart';
import 'package:ecomerc_app_with_admin/core/theme/app_theme.dart';
import 'package:ecomerc_app_with_admin/features/Home/domain/entity/product_entity.dart';
import 'package:ecomerc_app_with_admin/features/cart/domain/entity/cart_entity.dart';
import 'package:ecomerc_app_with_admin/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class BotomAddCart extends StatelessWidget {
  final ProductEntity product;
  const BotomAddCart({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    ValueNotifier<int> valueNotifier = ValueNotifier(1);
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(color: Colors.transparent),
      child: Row(
        children: [
          SizedBox(width: AppSize.spacewWidth1(context)),
          _buildAddandminus(
            context,
            icon: Icons.remove,
            ontap: () {
              if (valueNotifier.value != 0) {
                valueNotifier.value--;
              }
            },
          ),
          SizedBox(width: AppSize.spacewWidth2(context)),
          ValueListenableBuilder(
            valueListenable: valueNotifier,
            builder: (context, value, child) {
              return Text(value.toString());
            },
          ),
          SizedBox(width: AppSize.spacewWidth2(context)),
          _buildAddandminus(
            context,
            icon: Icons.add,
            ontap: () {
              valueNotifier.value++;
            },
          ),
          Spacer(),
          InkWell(
            onTap: () {
              context.read<CartCubit>().addItem(CartItem(product: product));
            },
            child: Container(
              height: 38.h,
              decoration: BoxDecoration(
                color: AppTheme.isdark(context) ? Colors.white : Colors.black,
                borderRadius: BorderRadius.circular(4),
              ),
              padding: EdgeInsets.all(7),
              child: Row(
                children: [
                  Icon(
                    Iconsax.shopping_bag_copy,
                    color: AppTheme.isdark(context)
                        ? Colors.black
                        : Colors.white,
                    size: 20.w,
                  ),
                  SizedBox(width: AppSize.spacewWidth1(context)),
                  Text(
                    "Add to cart",
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: AppTheme.isdark(context)
                          ? Colors.black
                          : Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  InkWell _buildAddandminus(
    BuildContext context, {
    required void Function() ontap,
    required IconData icon,
  }) {
    return InkWell(
      onTap: ontap,
      child: Container(
        alignment: Alignment.center,
        height: 30.h,
        width: 30.w,

        decoration: BoxDecoration(
          color: AppTheme.isdark(context) ? Colors.black : Colors.white,
          border: Border.all(color: Theme.of(context).primaryColor, width: 3),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 20.w),
      ),
    );
  }
}
