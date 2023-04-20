import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../screens/home.dart';
import '../../screens/initial/onboarding.dart';

class SplashScreenController extends GetxController {
  static SplashScreenController get find => Get.find();

  RxBool animate = false.obs;

  Future startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 300));
    animate.value = true;

    await Future.delayed(const Duration(milliseconds: 3000));
    if (FirebaseAuth.instance.currentUser == null) {
      Get.to(() => const OnboardingScreen());
    } else {
      Get.to(() => const HomeScreen());
    }
  }
}
