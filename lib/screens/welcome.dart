import 'package:flutter/material.dart';
import 'package:huddle_hub/screens/login.dart';
import 'package:huddle_hub/screens/register.dart';
import 'package:huddle_hub/screens/resetPassword.dart';
import 'package:huddle_hub/utils/colors.dart';
import 'package:huddle_hub/components/reusable_widgets.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});
  static String id = 'welcome';

  @override
  State<WelcomeScreen> createState() => _WelcomeState();
}

class _WelcomeState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [ 
            hexStringToColor("CB2B93"), 
            hexStringToColor("9546C4"), 
            hexStringToColor("5E61F4")
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
          child: Padding(
            padding:EdgeInsets.fromLTRB(
              20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(
              children: <Widget>[
                logoWidget("assets/images/logo.png"),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  child: Text(
                    'Connect like never before!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Aware',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                firebaseButton(context, "LOG IN", () {
                    Navigator.push(context, 
                        MaterialPageRoute(builder: (context) => const LoginScreen()));
                }),
                const SizedBox(
                  height: 10,
                ),
                firebaseButton(context, "SIGN UP", () {
                    Navigator.push(context, 
                        MaterialPageRoute(builder: (context) => const SignUpScreen()));
                }),
              ]
            ),
          ),
        ),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account?",
          style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () {
            Navigator.push(context, 
                MaterialPageRoute(builder: (context) => const SignUpScreen()));
          },
          child: const Text(
            " Sign Up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Widget forgetPassword(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
      alignment: Alignment.bottomRight,
      child: TextButton(
        child: const Text(
          "Forgot Password?", 
          style: TextStyle(color: Colors.white70), 
          textAlign: TextAlign.right,
        ),
        onPressed: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => const ResetPassword())),
      ),
    );
  }
}
