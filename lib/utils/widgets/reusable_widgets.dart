import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../constants/colors.dart';
import '../models/navbar_model.dart';
import '../../screens/hobbies.dart';
import '../../screens/home.dart';
import '../../screens/profile/profile.dart';
import '../../screens/radar.dart';

Image logoWidget(String imageName) {
  return Image.asset(
    imageName,
    fit: BoxFit.fitWidth,
    width: 250,
    height: 250,
  );
}

TextField reusableTextField(String text, IconData icon, bool isPasswordType,
    TextEditingController controller) {
  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.white,
    style: TextStyle(color: Colors.white.withOpacity(0.9)),
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: Colors.white70,
      ),
      labelText: text,
      labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.white.withOpacity(0.3),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
    ),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}

ElevatedButton myButton(BuildContext context, String title, Function onTap) {
  return ElevatedButton(
    onPressed: (() {
      onTap();
    }),
    child: Center(
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    ),
  );
}

Container firebaseButton(BuildContext context, String title, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.black26;
            }
            return Colors.white;
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.bold,
          fontSize: 16,
          fontFamily: 'Aware',
        ),
      ),
    ),
  );
}

PreferredSizeWidget myAppBar() {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: const Color(0xFFC0FFE8),

    // leading: Builder(builder: (context) {
    //   return IconButton(
    //     icon: const Icon(Icons.menu),
    //     color: Colors.black,
    //     onPressed: () {
    //       Scaffold.of(context).openDrawer();
    //     },
    //   );
    // }),

    centerTitle: true,
    toolbarHeight: 45,
    title: const Text(
      'HUDDLE HUB',
      style: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.bold,
        fontFamily: 'Aware',
      ),
    ),
  );
}

Widget myNavBar(MenuState selectedMenu) {
  return Container(
    decoration: BoxDecoration(
      color: const Color(0xFFC0FFE8),
      boxShadow: [
        BoxShadow(
          offset: const Offset(0, -15),
          blurRadius: 20,
          color: const Color(0xFFDADADA).withOpacity(0.15),
        ),
      ],
    ),
    child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Home Screen
            IconButton(
              icon: Icon(
                MenuState.home == selectedMenu
                    ? Icons.home_rounded
                    : Icons.home_outlined,
              ),
              onPressed: () {
                Get.to(() => const HomeScreen());
              },
            ),

            // Radar Screen
            IconButton(
              icon: Icon(
                MenuState.radar == selectedMenu
                    ? Icons.wifi_find_rounded
                    : Icons.wifi_find_outlined,
              ),
              onPressed: () {
                Get.to(() => const RadarSearch());
              },
            ),

            // Hobbies Screen
            IconButton(
              icon: Icon(
                MenuState.hobbies == selectedMenu
                    ? Icons.favorite_rounded
                    : Icons.favorite_border_outlined,
              ),
              onPressed: () {
                Get.to(() => const HobbiesScreen());
              },
            ),

            // Profile Screen
            IconButton(
              icon: Icon(
                MenuState.profile == selectedMenu
                    ? Icons.account_circle_rounded
                    : Icons.account_circle_outlined,
              ),
              onPressed: () {
                Get.to(() => const ProfileScreen());
              },
            ),
          ],
        )),
  );
}

// Widget mySideBar(BuildContext context) {
//   return Drawer(
//     child: ListView(
//       padding: const EdgeInsets.all(0),
//       children: <Widget>[
//         DrawerHeader(
//           decoration: const BoxDecoration(
//             color: Colors.indigo,
//           ), //BoxDecoration
//           child: UserAccountsDrawerHeader(
//             decoration: const BoxDecoration(
//               color: Colors.indigo,
//             ),
//             accountName: Text(
//               "${FirebaseAuth.instance.currentUser!.displayName}",
//               style: const TextStyle(
//                 fontSize: 18,
//               ),
//             ),
//             accountEmail: Text(
//               "${FirebaseAuth.instance.currentUser!.email}",
//               style: const TextStyle(
//                 color: Colors.grey,
//               ),
//             ),
//             currentAccountPictureSize: const Size.square(50),
//             currentAccountPicture: const CircleAvatar(
//               backgroundColor: Color.fromARGB(255, 165, 255, 137),
//               child: Text(
//                 "A",
//                 style: TextStyle(fontSize: 30.0, color: Colors.blue),
//               ), //Text
//             ), //circleAvatar
//           ), //UserAccountDrawerHeader
//         ),
//         ListTile(
//           leading: const Icon(Icons.person),
//           title: const Text(' My Profile '),
//           onTap: () {
//             Navigator.pop(context);
//           },
//         ),
//         ListTile(
//           leading: const Icon(Icons.book),
//           title: const Text(' My Course '),
//           onTap: () {
//             Navigator.pop(context);
//           },
//         ),
//         ListTile(
//           leading: const Icon(Icons.workspace_premium),
//           title: const Text(' Go Premium '),
//           onTap: () {
//             Navigator.pop(context);
//           },
//         ),
//         ListTile(
//           leading: const Icon(Icons.video_label),
//           title: const Text(' Saved Videos '),
//           onTap: () {
//             Navigator.pop(context);
//           },
//         ),
//         ListTile(
//           leading: const Icon(Icons.edit),
//           title: const Text(' Edit Profile '),
//           onTap: () {
//             Navigator.pop(context);
//           },
//         ),
//         ListTile(
//           leading: const Icon(Icons.logout),
//           title: const Text('LogOut'),
//           onTap: () {
//             FirebaseAuth.instance.signOut().then((value) {
//               print("Logged Out");
//               Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => const WelcomeScreen()));
//             }).onError((error, stackTrace) {
//               print("Error ${error.toString()}");
//             });
//           },
//         ),
//       ],
//     ),
//   );
//   //   child: ListView(
//   //     padding: EdgeInsets.zero,
//   //     children: const [
//   //       ListTile(
//   //         leading: CircleAvatar(
//   //           backgroundColor: Colors.white24,
//   //           child: Icon(
//   //             CupertinoIcons.person,
//   //             color: Colors.white,
//   //           ),
//   //         ),
//   //         title: Text(
//   //           'Huddle Hub',
//   //           style: TextStyle(color: Colors.white, fontFamily: 'Aware'),
//   //         ),
//   //         subtitle: Text(
//   //           'Connect like never before!',
//   //           style: TextStyle(color: Colors.white, fontFamily: 'Aware'),
//   //         ),
//   //       ),
//   //     ],
//   //   ),
//   // );
// }
