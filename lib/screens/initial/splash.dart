import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constants/colors.dart';
import '../../utils/constants/image_strings.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/constants/text_strings.dart';
import '../../utils/controllers/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);
  static String id = 'splash';

  final splashController = Get.put(SplashScreenController());

  @override
  Widget build(BuildContext context) {
    SplashScreenController.find.startAnimation();

    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: [
          Obx(
            () => AnimatedPositioned(
              duration: const Duration(milliseconds: 1200),
              top: splashController.animate.value ? 45 : -30,
              left: splashController.animate.value ? 40 : -30,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 1200),
                opacity: splashController.animate.value ? 1 : 0,
                child: const Image(image: AssetImage(splashIcon)),
              ),
            ),
          ),
          Obx(
            () => AnimatedPositioned(
              duration: const Duration(milliseconds: 1600),
              top: 135,
              left: splashController.animate.value ? defaultSize : -80,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 1600),
                opacity: splashController.animate.value ? 1 : 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(appName,
                        style: TextStyle(fontSize: 26, fontFamily: 'Aware')),
                    Text(tagLine,
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Aware',
                            fontWeight: FontWeight.bold))
                  ],
                ),
              ),
            ),
          ),
          Obx(
            () => AnimatedPositioned(
              duration: const Duration(milliseconds: 2000),
              left: splashController.animate.value ? 60 : 0,
              bottom: splashController.animate.value ? 120 : 0,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 1600),
                opacity: splashController.animate.value ? 1 : 0,
                child: const Image(image: AssetImage(splashImage)),
              ),
            ),
          ),
          Obx(
            () => AnimatedPositioned(
              duration: const Duration(milliseconds: 2000),
              bottom: splashController.animate.value ? 60 : 0,
              right: defaultSize,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 1600),
                opacity: splashController.animate.value ? 1 : 0,
                child: Container(
                  width: splashContainerSize,
                  height: splashContainerSize,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: primaryColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
