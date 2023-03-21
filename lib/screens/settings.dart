import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:huddle_hub/components/reusable_widgets.dart';
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
      appBar: myAppBar(),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 5,
              ),
              firebaseButton(context, "LOGOUT", () {
                FirebaseAuth.instance.signOut().then((value) {
                  print("Logged Out");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const WelcomeScreen()));
                }).onError((error, stackTrace) {
                  print("Error ${error.toString()}");
                });
              }),
            ],
          ),
        ),
      ),

      // bottomNavigationBar: CurvedNavigationBar(
      //   index: 3,
      //   height: 60,
      //   backgroundColor: Colors.transparent,
      //   color: const Color.fromARGB(255, 221, 255, 242),
      //   animationDuration: const Duration(milliseconds: 350),
      //   items: const <Widget>[
      //     Icon(
      //       Icons.home,
      //       color: Colors.black,
      //     ),
      //     Icon(
      //       Icons.wifi_tethering,
      //       // icon: const Icon(Icons.wifi_tethering),
      //       color: Colors.black,
      //       // onPressed: () {
      //       //   Navigator.push(context,
      //       //       MaterialPageRoute(builder: (context) => const SearchScreen()));
      //       // }
      //     ),
      //     Icon(
      //       Icons.favorite_border,
      //       // icon: const Icon(Icons.favorite_border),
      //       color: Colors.black,
      //       // onPressed: () {
      //       //   Navigator.push(context,
      //       //       MaterialPageRoute(builder: (context) => const HobbiesScreen()));
      //       // }
      //     ),
      //     Icon(
      //       Icons.settings,
      //       // icon: const Icon(Icons.settings),
      //       color: Colors.black,
      //       // onPressed: () {
      //       //   Navigator.push(context,
      //       //       MaterialPageRoute(builder: (context) => const SettingsScreen()));
      //       // }
      //     ),
      //   ],
      // ),
    );
  }
}
