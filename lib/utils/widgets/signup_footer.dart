import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../screens/authentication/login.dart';
import '../constants/image_strings.dart';
import '../constants/sizes.dart';
import '../constants/text_strings.dart';

class SignUpFooterWidget extends StatelessWidget {
  const SignUpFooterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("OR"),
        const SizedBox(height: formHeight - 15),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {
              Get.snackbar("Sorry", "It's not yet implemented",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.pinkAccent.withOpacity(0.1),
                  colorText: Colors.red);
            },
            icon: const Image(
              image: AssetImage(googleLogo),
              width: 20.0,
            ),
            label: Text(loginGoogle.toUpperCase()),
          ),
        ),
        const SizedBox(height: formHeight - 25),
        TextButton(
          onPressed: () {
            Get.to(() => const LoginScreen());
          },
          child: Text.rich(TextSpan(children: [
            TextSpan(
              text: alreadyMember,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            TextSpan(text: logIn.toUpperCase())
          ])),
        )
      ],
    );
  }
}
