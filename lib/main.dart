import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'radar.dart';
import 'utils/constants/colors.dart';
import 'utils/constants/theme.dart';
import 'utils/repo/authentication_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value) => Get.put(AuthenticationRepository()));

  // Restricts Portrait Mode
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'HUDDLE HUB',
      themeMode: ThemeMode.light,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      defaultTransition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 500),

      // /// check if user is signed (Open Home Page) if user is not signed in (Open Onboarding Page)
      // initialRoute: FirebaseAuth.instance.currentUser == null
      //     ? SplashScreen.id
      //     : BaseScreen.id,

      // ///key value pair
      // routes: {
      //   SplashScreen.id: (context) => SplashScreen(),
      //   WelcomeScreen.id: (context) => const WelcomeScreen(),
      //   LoginScreen.id: (context) => const LoginScreen(),
      //   SignUpScreen.id: (context) => const SignUpScreen(),
      //   BaseScreen.id: (context) => const BaseScreen(),
      // },

      home: Scaffold(
        backgroundColor: bgColor,
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: const SizedBox(
              height: 120.0,
              width: 120.0,
              child: Center(child: CircularProgressIndicator()),
            ),
          ),
        ),
      ),
    );
  }
}
