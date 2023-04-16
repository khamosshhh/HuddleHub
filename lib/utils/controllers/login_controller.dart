import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../repo/authentication_repository.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  /// Controllers to fetch the entered data
  final email = TextEditingController();
  final password = TextEditingController();

  // Account Login
  void loginUser(BuildContext context, String email, String password) async {
    String? error = await AuthenticationRepository.instance
        .loginWithEmailAndPassword(context, email, password) as String?;
    if (error != null) {
      Get.showSnackbar(GetSnackBar(
        message: error.toString(),
      ));
    }
  }
}
