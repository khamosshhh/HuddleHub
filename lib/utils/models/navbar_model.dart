import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../screens/authentication/login.dart';
import '../../screens/authentication/otpScreen.dart';
import '../../screens/authentication/register.dart';
import '../../screens/authentication/resetPassMail.dart';
import '../../screens/authentication/resetPassword.dart';
import '../../screens/hobbies.dart';
import '../../screens/home.dart';
import '../../screens/initial/splash.dart';
import '../../screens/profile/profile.dart';
import '../../screens/radar.dart';
import '../constants/text_strings.dart';

// Setting Menu State for navigation
enum MenuState { home, radar, hobbies, profile }

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  LoginScreen.routeName: (context) => const LoginScreen(),
  ResetPassWord.routeName: (context) => ResetPassWord(
        btnIcon: Icons.mail_outline_rounded,
        title: emaiL,
        subTitle: resetVemail,
        onTap: () {
          Navigator.pop(context);
          Get.to(() => const ResetPasswordMailScreen());
        },
      ),
  //LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  //CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  OTPScreen.routeName: (context) => const OTPScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  RadarSearch.routeName: (context) => const RadarSearch(),
  //DetailsScreen.routeName: (context) => DetailsScreen(),
  HobbiesScreen.routeName: (context) => const HobbiesScreen(),
  ProfileScreen.routeName: (context) => const ProfileScreen(),
};
