import 'package:ecomerc_app_with_admin/core/local_storage/first_time.dart';
import 'package:ecomerc_app_with_admin/core/responsive/app_size.dart';
import 'package:ecomerc_app_with_admin/core/routing/app_routing.dart';
import 'package:ecomerc_app_with_admin/core/theme/app_theme.dart';
import 'package:ecomerc_app_with_admin/features/onboarding/data/onboarding_list.dart';
import 'package:ecomerc_app_with_admin/l10n/app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class OnbordingScreen extends StatefulWidget {
  const OnbordingScreen({super.key});

  @override
  State<OnbordingScreen> createState() => _OnbordingScreenState();
}

class _OnbordingScreenState extends State<OnbordingScreen> {
  final PageController controller = PageController();
  ValueNotifier<int> currentIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    List<OnBoardibgModel> onboardings = onboardingList(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              _headers(context),
              SizedBox(height: AppSize.hight(context) * 0.03),
              Expanded(
                child: PageView.builder(
                  onPageChanged: (value) {
                    currentIndex.value = value;
                  },
                  controller: controller,
                  itemCount: onboardings.length,
                  itemBuilder: (context, index) {
                    final item = onboardings[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          decoration: const BoxDecoration(),
                          height: 250.h,
                          child: Lottie.asset(item.image),
                        ),
                        SizedBox(height: AppSize.hight(context) * 0.09),
                        Text(
                          item.title,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        SizedBox(height: AppSize.hight(context) * 0.01),
                        Text(
                          item.dec,
                          style: Theme.of(context).textTheme.bodySmall,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    );
                  },
                ),
              ),
              _slider(currentIndex, context, onboardings),
            ],
          ),
        ),
      ),
    );
  }

  Row _headers(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () async {
            IsFirstTime.setFirstTime(false);
            Navigator.pushReplacementNamed(context, AppRouting.login);
          },
          child: Text(
            AppLocalizations.of(context)!.skip,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }

  Align _slider(
    ValueNotifier<int> currentIndex,
    BuildContext context,
    List<OnBoardibgModel> onboardings,
  ) {
    return Align(
      child: Padding(
        padding: EdgeInsets.only(bottom: 10.h),
        child: Row(
          children: [
            ValueListenableBuilder(
              valueListenable: currentIndex,
              builder: (context, value, child) {
                return Row(
                  children: List.generate(
                    onboardings.length,
                    (index) => AnimatedContainer(
                      margin: EdgeInsets.symmetric(horizontal: 10.w),
                      height: 8.h,
                      width: value == index ? 40.w : 16.w,
                      duration: Duration(milliseconds: 300),
                      decoration: BoxDecoration(
                        color: value == index
                            ? AppTheme.isdark(context)
                                  ? Colors.white
                                  : Colors.black
                            : AppTheme.isdark(context)
                            ? Colors.white60
                            : Colors.black54,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                );
              },
            ),
            Spacer(),
            ValueListenableBuilder(
              valueListenable: currentIndex,
              builder: (context, value, child) => InkWell(
                onTap: () {
                  final bool islast = value == onboardings.length - 1;
                  if (islast) {
                    IsFirstTime.setFirstTime(false);
                    Navigator.pushReplacementNamed(context, AppRouting.login);
                  } else {
                    controller.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                child: Container(
                  height: 60.h,
                  width: 60.w,
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: AppTheme.isdark(context)
                        ? Colors.white
                        : Colors.black,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.keyboard_arrow_right_outlined,
                    color: AppTheme.isdark(context)
                        ? Colors.black
                        : Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
