import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constants/image_strings.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/constants/text_strings.dart';
import '../../utils/widgets/form_header.dart';
import 'otpScreen.dart';

class ResetPasswordMailScreen extends StatelessWidget {
  const ResetPasswordMailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(defaultSize),
            child: Column(
              children: [
                const SizedBox(height: defaultSize * 4),
                const FormHeaderWidget(
                  image: welcomeImage,
                  title: forgetPassworD,
                  subTitle: forgetPassSubTitle,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  heightBetween: 30.0,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: formHeight),
                Form(
                  child: Column(
                    children: [
                      // Email Textfield
                      TextFormField(
                        decoration: const InputDecoration(
                          label: Text(emaiL),
                          prefixIcon: Icon(Icons.mail_outline_rounded),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),

                      const SizedBox(height: 20.0),

                      // Get OTP Button
                      SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () {
                                Get.to(() => const OTPScreen());
                              },
                              child: const Text(nexT))),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
