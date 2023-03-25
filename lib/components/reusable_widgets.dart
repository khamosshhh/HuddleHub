import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huddle_hub/screens/welcome.dart';

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

Padding myButton(BuildContext context, String title, Function onTap) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25.0),
    child: ElevatedButton(
      onPressed: (() {
        onTap();
      }),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return const Color(0xFF000014);
            }
            return const Color(0xFF000014);
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)))),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF000014),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
              fontFamily: 'Aware',
            ),
          ),
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
    leading: Builder(builder: (context) {
      return IconButton(
        icon: const Icon(Icons.menu),
        color: Colors.black,
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      );
    }),
    centerTitle: true,
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
