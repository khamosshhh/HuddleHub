import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constants/sizes.dart';
import '../../utils/constants/text_strings.dart';
import 'resetPassMail.dart';

class ResetPasswordScreen {
  static Future<dynamic> resetPass(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        builder: (context) => Container(
              padding: const EdgeInsets.all(defaultSize),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(forgetPassTitle,
                      style: Theme.of(context).textTheme.headline2),
                  Text(forgetPassSubTitle,
                      style: Theme.of(context).textTheme.bodyText2),
                  const SizedBox(
                    height: 30.0,
                  ),
                  ResetPassWord(
                    btnIcon: Icons.mail_outline_rounded,
                    title: emaiL,
                    subTitle: resetVemail,
                    onTap: () {
                      Navigator.pop(context);
                      Get.to(() => const ResetPasswordMailScreen());
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  ResetPassWord(
                    btnIcon: Icons.mobile_friendly_outlined,
                    title: phoneNo,
                    subTitle: resetVphone,
                    onTap: () {
                      Get.snackbar("Sorry", "It's not yet implemented",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.pinkAccent.withOpacity(0.1),
                          colorText: Colors.red);
                    },
                  ),
                ],
              ),
            ));
  }
}

class ResetPassWord extends StatelessWidget {
  static String routeName = "/forgot_password";
  const ResetPassWord({
    Key? key,
    required this.btnIcon,
    required this.title,
    required this.subTitle,
    required this.onTap,
  }) : super(key: key);

  final IconData btnIcon;
  final String title, subTitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.grey.shade200,
        ),
        child: Row(
          children: [
            Icon(
              btnIcon,
              size: 60.0,
            ),
            const SizedBox(
              width: 10.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(
                  subTitle,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
