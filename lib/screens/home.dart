import 'package:flutter/material.dart';
import 'package:huddle_hub/screens/login.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: Text("Logout"),
        onPressed: () {
          Navigator.push(context, 
            MaterialPageRoute(builder: (context) => LoginScreen()));
        },
      ),
    );
  }
}