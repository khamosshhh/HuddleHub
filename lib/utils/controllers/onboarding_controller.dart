import 'package:get/get.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

import '../../screens/initial/welcome.dart';
import '../constants/colors.dart';
import '../constants/image_strings.dart';
import '../constants/text_strings.dart';
import '../models/onboarding_model.dart';
import '../widgets/onboarding_widget.dart';

class OnboardingController extends GetxController {
  final controller = LiquidController();
  RxInt currentPage = 0.obs;

  final pages = [
    OnboardingPageWidget(
      model: OnboardingModel(
        image: onboardingImage1,
        title: onboardingTitle1,
        subTitle: onboardingSubTitle1,
        counter: onboardingCounter1,
        bgColor: onboardingPage1Color,
      ),
    ),
    OnboardingPageWidget(
      model: OnboardingModel(
        image: onboardingImage2,
        title: onboardingTitle2,
        subTitle: onboardingSubTitle2,
        counter: onboardingCounter2,
        bgColor: onboardingPage2Color,
      ),
    ),
    OnboardingPageWidget(
      model: OnboardingModel(
        image: onboardingImage3,
        title: onboardingTitle3,
        subTitle: onboardingSubTitle3,
        counter: onboardingCounter3,
        bgColor: onboardingPage3Color,
      ),
    ),
  ];

  animateToNextSlide() {
    int nextPage = controller.currentPage + 1;
    if (nextPage != 3) {
      controller.animateToPage(page: nextPage, duration: 3);
    } else {
      Get.to(() => const WelcomeScreen());
    }
  }

  onPageChangedCallback(int activePageIndex) =>
      currentPage.value = activePageIndex;
}
