import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:huddle_hub/reusable_widgets/reusable_widgets.dart';
import 'package:huddle_hub/screens/welcome.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  
  static String id = 'home';

  @override
  State<SettingsScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding:const EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 5,
                ),
                firebaseButton(context, "LOGOUT", () {
                  FirebaseAuth.instance
                    .signOut()
                    .then((value) {
                      print("Logged Out");
                      Navigator.push(context, 
                          MaterialPageRoute(builder: (context) => const WelcomeScreen()));
                    }).onError((error, stackTrace) {
                      print("Error ${error.toString()}");
                    });
                  }),
              ],
            ),
          ),
        ),
      );
  }
}
