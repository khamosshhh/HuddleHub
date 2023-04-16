import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/widgets/reusable_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: mySideBar(context),
      appBar: myAppBar(),

      body: Center(
        child: Container(
          width: 360,
          height: 360,
          decoration: BoxDecoration(
              color: Colors.grey.shade200,
              border: Border.all(
                color: Colors.blueGrey,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                Text("${FirebaseAuth.instance.currentUser!.displayName}"),
                Text("${FirebaseAuth.instance.currentUser!.email}"),
                const SizedBox(
                  height: 20,
                ),
                // ElevatedButton(
                //   child: const Text("Logout"),
                //   onPressed: () async {
                //     await FirebaseAuth.instance.signOut();
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => const WelcomeScreen()));
                //   },
                // ),
              ],
            ),
          )),
        ),
      ),

      // bottomNavigationBar: CurvedNavigationBar(
      //   index: 1,
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
      //       //       MaterialPageRoute(builder: (context) => const HomeScreen()));
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
