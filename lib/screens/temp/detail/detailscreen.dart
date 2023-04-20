
import 'package:flutter/material.dart';
import 'components/body.dart';

class DetailScreen extends StatefulWidget {
  static String routeName = "/details";
  Map dict;
  DetailScreen({super.key, required this.dict});
  @override
  _DetailScreenState createState() => _DetailScreenState(dict: dict);
}

class _DetailScreenState extends State<DetailScreen> {
  Map dict;
  _DetailScreenState({required this.dict});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(dict: dict),
    );
  }
}
