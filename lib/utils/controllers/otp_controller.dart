import 'package:get/get.dart';

import '../../screens/home.dart';
import '../repo/authentication_repository.dart';

class OTPController extends GetxController {
  static OTPController get instance => Get.find();

  void verifyOTP(String otp) async {
    var isVerified = await AuthenticationRepository.instance.verifyOTP(otp);
    isVerified != null ? Get.offAll(const HomeScreen()) : Get.back();
  }
}
