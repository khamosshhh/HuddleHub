import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "dart:math";

import '../../home/components/size_config.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
        width: getProportionateScreenWidth(context, 55),
        right: 0,
        child: const Image(image: AssetImage("assets/images/rightbar.png")),
      ),
      // Positioned(
      //   bottom: 0,
      //   right: getProportionateScreenWidth(context,12),
      //   child: Column(
      //     children: [
      //       Padding(
      //         padding: const EdgeInsets.symmetric(vertical: 8),
      //         child: FaIcon(FontAwesomeIcons.instagramSquare,
      //             size: getProportionateScreenWidth(context,30)),
      //       ),
      //       Padding(
      //         padding: const EdgeInsets.symmetric(vertical: 8.0),
      //         child: FaIcon(FontAwesomeIcons.facebook,
      //             size: getProportionateScreenWidth(context,30)),
      //       ),
      //     ],
      //   ),
      // ),
      Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/info.png"), fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(
                      top: getProportionateScreenHeight(context, 10),
                      left: getProportionateScreenWidth(context, 20),
                      right: getProportionateScreenWidth(context, 20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "हमारी,",
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(context, 28),
                          color: const Color(0xff212f44),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "  " + "Info !",
                        style: TextStyle(
                          fontFamily: "Playlist",
                          fontSize: getProportionateScreenWidth(context, 50),
                          color: const Color(0xff212f44),
                        ),
                      ),
                    ],
                  )),
              Center(
                  child: SizedBox(
                      height: getProportionateScreenHeight(context, 200),
                      child: const Image(
                          image: AssetImage("assets/images/logo.png")))),
              Padding(
                padding: EdgeInsets.only(
                    top: getProportionateScreenHeight(context, 20),
                    left: getProportionateScreenWidth(context, 20)),
                child: SizedBox(
                  width: getProportionateScreenWidth(context, 250),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "About HUDDLE HUB",
                        style: TextStyle(
                            fontFamily: "OpenSans",
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: getProportionateScreenWidth(context, 20)),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(context, 10),
                      ),
                      Text(
                        "Huddle Hub is a social networking platform which allows users to connect with individuals who have similar interests, aspirations, and passions more personally and authentically. To assist users in discovering and connecting with like-minded people, it makes use of cutting-edge matching algorithms and location-based technologies.",
                        style: TextStyle(
                            fontFamily: "OpenSans",
                            color: Colors.black,
                            fontSize: getProportionateScreenWidth(context, 13)),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: getProportionateScreenHeight(context, 20),
                    left: getProportionateScreenWidth(context, 20)),
                child: SizedBox(
                  width: getProportionateScreenWidth(context, 280),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Founders",
                        style: TextStyle(
                            fontFamily: "OpenSans",
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: getProportionateScreenWidth(context, 20)),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(context, 10),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(context, 10),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              height: getProportionateScreenHeight(context, 50),
                              child: Text(
                                "Hardik Singhal\n(Developer)",
                                style: TextStyle(
                                    fontFamily: "OpenSans",
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: getProportionateScreenWidth(
                                        context, 10)),
                              )),
                          SizedBox(
                              height: getProportionateScreenHeight(context, 50),
                              child: Text(
                                "Harsh Patil\n(QA Tester)",
                                style: TextStyle(
                                    fontFamily: "OpenSans",
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: getProportionateScreenWidth(
                                        context, 10)),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(context, 10),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              height: getProportionateScreenHeight(context, 50),
                              child: Text(
                                "Ishaan Asthana\n(Project Manager)",
                                style: TextStyle(
                                    fontFamily: "OpenSans",
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: getProportionateScreenWidth(
                                        context, 10)),
                              )),
                          SizedBox(
                              height: getProportionateScreenHeight(context, 50),
                              child: Text(
                                "Jatin Bisht\n(Designer)",
                                style: TextStyle(
                                    fontFamily: "OpenSans",
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: getProportionateScreenWidth(
                                        context, 10)),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
