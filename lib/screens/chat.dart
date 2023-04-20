import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/constants/colors.dart';
import 'home.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFC0FFE8),
        leading: IconButton(
          icon: const Icon(Icons.navigate_before_rounded),
          color: primaryColor,
          onPressed: () {
            Get.off(
              () => const HomeScreen(),
              transition: Transition.leftToRight,
              duration: const Duration(milliseconds: 500),
            );
          },
        ),
        toolbarHeight: 45,
        title: const Text(
          'Messages',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      
      body: const Center(
        child: Text('NOT IMPLEMENTED YET'),
      ),
    );
  }
}
