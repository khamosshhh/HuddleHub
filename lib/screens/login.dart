import 'package:flutter/material.dart';
import 'package:huddle_hub/screens/home.dart';
import 'package:huddle_hub/screens/register.dart';
import 'package:huddle_hub/utils/colors.dart';
import 'package:huddle_hub/reusable_widgets/reusable_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
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
                SizedBox(
                  height: 30,
                ),
                reusableTextField("Enter Username", Icons.person_outline, false, 
                    _emailTextController),
                SizedBox(
                  height: 30,
                ),
                reusableTextField("Enter Password", Icons.lock_outline, true, 
                    _passwordTextController),
                SizedBox(
                  height: 20,
                ),
                signInsignUpButton(context, true, () {
                  Navigator.push(context, 
                    MaterialPageRoute(builder: (context) => HomeScreen()));
                }),
                signUpOption()
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
                MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
          child: const Text(
            " Sign Up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
