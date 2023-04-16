import 'package:flutter/material.dart';

import '../utils/widgets/reusable_widgets.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(),

      body: const Center(
        child: Text('NOT IMPLEMENTED YET'),
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
