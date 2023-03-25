import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:huddle_hub/screens/base.dart';
import 'package:huddle_hub/screens/login.dart';
import 'package:huddle_hub/screens/register.dart';
import 'package:huddle_hub/screens/welcome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription<User?> user;
  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

  @override
  void dispose() {
    user.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HUDDLE HUB',
      theme: ThemeData(
        backgroundColor: Colors.grey[300],
      ),

      /// check if user is signed (Open Home Page ) if user is not signed in (Open Welcome Page)
      initialRoute: FirebaseAuth.instance.currentUser == null
          ? WelcomeScreen.id
          : BaseScreen.id,

      ///key value pair
      routes: {
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        SignUpScreen.id: (context) => const SignUpScreen(),
        BaseScreen.id: (context) => const BaseScreen(),
      },

      home: const WelcomeScreen(),
    );
  }
}
