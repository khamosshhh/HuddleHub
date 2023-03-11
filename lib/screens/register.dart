import 'package:flutter/material.dart';
import 'package:huddle_hub/reusable_widgets/reusable_widgets.dart';
import 'package:huddle_hub/screens/home.dart';
import 'package:huddle_hub/utils/colors.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _usernameTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
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
            padding:EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Username", Icons.person_outline, false, 
                    _usernameTextController),
                SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Email ID", Icons.person_outline, false, 
                    _emailTextController),
                SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Password", Icons.lock_outline, true, 
                    _passwordTextController),
                SizedBox(
                  height: 20,
                ),
                signInsignUpButton(context, false, () {
                  Navigator.push(context, 
                    MaterialPageRoute(builder: (context) => HomeScreen()));
                }),
              ]
            ),
        ))),
    );
  }
}
