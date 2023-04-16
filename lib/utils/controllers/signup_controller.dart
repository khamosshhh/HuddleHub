import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../repo/authentication_repository.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  // Controllers to fetch the entered data
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final dob = TextEditingController();
  final email = TextEditingController();
  final phoneNo = TextEditingController();
  final password = TextEditingController();
  final passwordConfirm = TextEditingController();

  set text(text) {}

  // Account Creation
  void registerUser(BuildContext context, String email, String password) async {
    String? error = await AuthenticationRepository.instance
        .createUserwithEmailandPassword(context, email, password) as String?;
    if (error != null) {
      Get.showSnackbar(GetSnackBar(message: error.toString()));
    }
  }

  // Get phoneNo from User (Screen) and pass it to Auth Repository for Firebase Authentication
  void phoneAuthentication(String phoneNo) {
    AuthenticationRepository.instance.phoneAuthentication(phoneNo);
  }
}
