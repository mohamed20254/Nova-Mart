import 'package:ecomerc_app_with_admin/core/constant/app_lottie.dart';
import 'package:ecomerc_app_with_admin/l10n/app_localizations.dart';

class OnBoardibgModel {
  final String title;
  final String dec;
  final String image;
  OnBoardibgModel({
    required this.title,
    required this.dec,
    required this.image,
  });
}

List<OnBoardibgModel> onboardingList(context) => [
  OnBoardibgModel(
    title: AppLocalizations.of(context)!.onBoardingTitle1,
    dec: AppLocalizations.of(context)!.onBoardingDesc1,
    image: AppLottie.onboarding1,
  ),
  OnBoardibgModel(
    title: AppLocalizations.of(context)!.onBoardingTitle2,
    dec: AppLocalizations.of(context)!.onBoardingDesc2,
    image: AppLottie.onboarding2,
  ),
  OnBoardibgModel(
    title: AppLocalizations.of(context)!.onBoardingTitle3,
    dec: AppLocalizations.of(context)!.onBoardingDesc3,
    image: AppLottie.onboarding3,
  ),
];
