import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:huddle_hub/screens/hobbies.dart';
import 'package:huddle_hub/screens/search.dart';
import 'package:huddle_hub/screens/settings.dart';
import 'package:huddle_hub/screens/welcome.dart';  

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  
  static String id = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  int index = 0;

  // final screens = const[
  //   HomeScreen(),
  //   SearchScreen(),
  //   HobbiesScreen(),
  //   SettingsScreen(),
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: const Color(0xFFC0FFE8),
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: Text(
            'HUDDLE HUB',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Aware',
            ),
            textAlign: TextAlign.center,
          ),
        ),
        actions: <Widget> [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Image.asset("assets/images/message.png"),
          )
        ],
        leading: Padding(
          padding: const EdgeInsets.all(14),
          child: Image.asset("assets/images/profile.png"),
        ),
      ),

      // body: screens[index],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            Text("${FirebaseAuth.instance.currentUser!.displayName}"),
            Text("${FirebaseAuth.instance.currentUser!.email}"),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              child: const Text("Logout"),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const WelcomeScreen()));
              },
            ),
          ],
        ),
      ),

      bottomNavigationBar: CurvedNavigationBar(
        key: navigationKey,
        index: index,
        height: 60,
        backgroundColor: Colors.transparent,
        color: const Color.fromARGB(255, 221, 255, 242),
        animationDuration: const Duration(milliseconds: 350),
        items: const <Widget>[
          Icon(
            Icons.home,
            color: Colors.black,
          ),
          Icon(
            Icons.wifi_tethering,
            color: Colors.black,
          ),
          Icon(
            Icons.favorite_border,
            color: Colors.black,
          ),
          Icon(
            Icons.settings,
            color: Colors.black,
          ),
        ],
        onTap: (index) => setState(() => this.index = index),
      ),
    );
  }
}
