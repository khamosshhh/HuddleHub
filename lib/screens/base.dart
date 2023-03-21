import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:huddle_hub/screens/hobbies.dart';
import 'package:huddle_hub/screens/home.dart';
import 'package:huddle_hub/screens/search.dart';
import 'package:huddle_hub/screens/settings.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});
  static String id = 'base';

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  int index = 0;

  final screens = const [
    HomeScreen(),
    SearchScreen(),
    HobbiesScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: const Color(0xFFC0FFE8),
      //   leading: const IconButton(
      //     icon: Icon(Icons.menu),
      //     color: Colors.black,
      //     onPressed: mySideBar,
      //   ),
      //   title: const Text(
      //     'HUDDLE HUB',
      //     style: TextStyle(
      //       color: Colors.black,
      //       fontSize: 18,
      //       fontWeight: FontWeight.bold,
      //       fontFamily: 'Aware',
      //     ),
      //   ),
      //   centerTitle: true,
      // ),

      body: screens[index],

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
