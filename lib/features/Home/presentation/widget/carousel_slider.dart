import 'package:ecomerc_app_with_admin/core/responsive/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constant/app_images.dart';

class CarouselSlider extends StatefulWidget {
  const CarouselSlider({super.key});

  @override
  State<CarouselSlider> createState() => _CarouselSlider();
}

class _CarouselSlider extends State<CarouselSlider> {
  List<String> carouselimages = [
    AppImages.carousel1,
    AppImages.carousel2,
    AppImages.carousel3,
  ];
  ValueNotifier<int> currentindex = ValueNotifier<int>(0);
  @override
  Widget build(BuildContext context) {
    final bool isdark = Theme.of(context).brightness == Brightness.dark;
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: 150.h,
                  maxWidth: double.infinity,
                ),

                child: PageView.builder(
                  onPageChanged: (value) => currentindex.value = value,
                  itemCount: carouselimages.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: SizedBox(
                        child: ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(12),
                          child: Image.asset(
                            carouselimages[index],
                            height: 150.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: AppSize.spacehight2(context)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(carouselimages.length, (index) {
                return ValueListenableBuilder(
                  valueListenable: currentindex,
                  builder: (context, value, child) {
                    return AnimatedContainer(
                      margin: EdgeInsets.symmetric(horizontal: 5.w),
                      height: 8.h,
                      width: value == index ? 40.w : 20.w,
                      duration: Duration(milliseconds: 300),
                      decoration: BoxDecoration(
                        color: value == index
                            ? Theme.of(context).primaryColor
                            : isdark
                            ? Colors.white24
                            : Colors.black26,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
