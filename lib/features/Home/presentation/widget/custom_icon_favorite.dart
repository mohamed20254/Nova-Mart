import 'package:ecomerc_app_with_admin/features/Home/domain/entity/product_entity.dart';
import 'package:ecomerc_app_with_admin/features/wishlist/presentation/bloc/favorit_cuibt/favvorit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../core/theme/app_theme.dart';

class CustomIconFavorite extends StatelessWidget {
  final ProductEntity prudict;
  const CustomIconFavorite({super.key, required this.prudict});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.watch<FavvoritCubit>().isfav(id: prudict.id),
      builder: (context, asyncSnapshot) {
        final isfav = asyncSnapshot.data ?? false;
        return InkWell(
          onTap: () {
            context.read<FavvoritCubit>().toogle(
              id: prudict.id,
              context: context,
              product: prudict,
            );
          },
          child: Container(
            height: 30.h,
            width: 30.w,
            decoration: BoxDecoration(
              color: AppTheme.isdark(context) ? Colors.black : Colors.white,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                Iconsax.heart,
                color: isfav ? Colors.red : Colors.grey,
                size: 20.h,
              ),
            ),
          ),
        );
      },
    );
  }
}
