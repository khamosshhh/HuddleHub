
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../utils/constants/colors.dart';
import '../utils/repo/authentication_repository.dart';
import 'initial/welcome.dart';
import 'profile/profile.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFC0FFE8),
        leading: IconButton(
          icon: const Icon(Icons.navigate_before_rounded),
          color: primaryColor,
          onPressed: () {
            Get.off(
              () => const ProfileScreen(),
              transition: Transition.leftToRight,
              duration: const Duration(milliseconds: 500),
            );
          },
        ),
        toolbarHeight: 45,
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          children: [
            const SizedBox(height: 25),

            // Search Bar
            SizedBox(
              height: 40,
              child: TextField(
                cursorColor: Colors.grey.shade400,
                cursorWidth: 0.8,
                textAlignVertical: TextAlignVertical.bottom,
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                  prefixIcon: Icon(
                    LineAwesomeIcons.search,
                    color: Colors.grey.shade600,
                    size: 20,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey.shade100),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey.shade100),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Account Settings
            ProfileMenuWidget(
              title: 'Account Settings',
              icon: LineAwesomeIcons.user_circle_1,
              onPress: () {
                Get.snackbar(
                  "Sorry",
                  "We are working on it.",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.redAccent.withOpacity(0.1),
                  colorText: Colors.red,
                );
              },
            ),

            // Payment Settings
            ProfileMenuWidget(
              title: 'Billing Details',
              icon: LineAwesomeIcons.wallet,
              onPress: () {
                Get.snackbar(
                  "Sorry",
                  "We are working on it.",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.redAccent.withOpacity(0.1),
                  colorText: Colors.red,
                );
              },
            ),

            // Blocked Users
            ProfileMenuWidget(
              title: 'Blocked Users',
              icon: LineAwesomeIcons.user_shield,
              onPress: () {
                Get.snackbar(
                  "Sorry",
                  "We are working on it.",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.redAccent.withOpacity(0.1),
                  colorText: Colors.red,
                );
              },
            ),

            // Information
            ProfileMenuWidget(
              title: 'About',
              icon: LineAwesomeIcons.info_circle,
              onPress: () {
                Get.snackbar(
                  "Sorry",
                  "We are working on it.",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.redAccent.withOpacity(0.1),
                  colorText: Colors.red,
                );
              },
            ),

            // Logout Option
            ProfileMenuWidget(
              title: 'Logout',
              icon: LineAwesomeIcons.alternate_sign_out,
              textColor: Colors.red,
              endIcon: false,
              onPress: () {
                AuthenticationRepository.instance.logout().then((value) {
                  print("Logged Out");
                  Get.offAll(() => const WelcomeScreen());
                }).onError((error, stackTrace) {
                  print("Error ${error.toString()}");
                });
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        child: SizedBox(height: 10),
      ),
    );
  }
}

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.blueAccent.withOpacity(0.1),
        ),
        child: Icon(icon, color: Colors.blueAccent),
      ),
      title: Text(title,
          style:
              Theme.of(context).textTheme.bodyLarge?.apply(color: textColor)),
      trailing: endIcon
          ? Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Theme.of(context).backgroundColor.withOpacity(0.1),
              ),
              child: const Icon(
                LineAwesomeIcons.angle_right,
                size: 18,
                color: Colors.grey,
              ),
            )
          : null,
    );
  }
}
