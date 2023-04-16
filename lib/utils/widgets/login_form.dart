import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../screens/authentication/resetPassword.dart';
import '../constants/sizes.dart';
import '../constants/text_strings.dart';
import '../controllers/login_controller.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    final formKey = GlobalKey<FormState>();

    return Form(
      key: formKey,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: formHeight - 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Email Address
            TextFormField(
              controller: controller.email,
              decoration: const InputDecoration(
                label: Text(emaiL),
                prefixIcon: Icon(Icons.person_outline_outlined),
              ),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
            ),

            const SizedBox(height: formHeight - 20),

            // Password
            TextFormField(
              controller: controller.password,
              obscureText: true,
              decoration: const InputDecoration(
                label: Text(passWord),
                prefixIcon: Icon(Icons.lock_outline_rounded),
              ),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
            ),

            const SizedBox(height: formHeight - 25),

            // Forgot Password Button
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () {
                    ResetPasswordScreen.resetPass(context);
                  },
                  child: const Text(forgetPassworD)),
            ),

            const SizedBox(height: formHeight - 20),

            // Login Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    LoginController.instance.loginUser(
                        context,
                        controller.email.text.trim(),
                        controller.password.text.trim());
                    //SignUpController.instance.phoneAuthentication(controller.phoneNo.text.trim());
                    //Get.to(() => const OTPScreen());
                  }
                },
                child: Text(logIn.toUpperCase()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
