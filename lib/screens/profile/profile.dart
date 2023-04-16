import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../utils/controllers/profile_controller.dart';
import '../../utils/models/user_model.dart';
import '../../utils/repo/authentication_repository.dart';
import '../../utils/widgets/reusable_widgets.dart';
import '../initial/welcome.dart';
import 'allUsers.dart';
import 'editProfile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  static String id = 'home';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.light;
    final controller = Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFC0FFE8),
        centerTitle: true,
        title: const Text(
          'PROFILE',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon),
            color: Colors.black,
          )
        ],
      ),

      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: FutureBuilder(
            future: controller.getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  UserModel userData = snapshot.data as UserModel;
                  return Column(
                    children: [
                      const SizedBox(height: 20),

                      // Profile Photo
                      Stack(
                        children: [
                          Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 2, color: const Color(0xFF000014)),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: const Image(
                                image: AssetImage('assets/images/profile.png'),
                                fit: BoxFit.cover),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: const Color(0xFF000014),
                              ),
                              child: const Icon(
                                  LineAwesomeIcons.alternate_pencil,
                                  size: 20,
                                  color: Colors.white),
                            ),
                          )
                        ],
                      ),

                      const SizedBox(height: 10),

                      // Profile Details
                      Text(
                        '${userData.fullName}',
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Aware',
                        ),
                      ),
                      Text(
                        userData.email,
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'Aware',
                        ),
                      ),

                      const SizedBox(height: 20),

                      myButton(context, 'Edit Profile',
                          () => Get.to(() => const UpdateProfileScreen())),

                      const SizedBox(height: 25),
                      const Divider(color: Colors.grey),
                      const SizedBox(height: 10),

                      // MENU
                      ProfileMenuWidget(
                          title: 'Settings',
                          icon: LineAwesomeIcons.cog,
                          onPress: () {}),
                      ProfileMenuWidget(
                          title: 'Billing Details',
                          icon: LineAwesomeIcons.wallet,
                          onPress: () {}),
                      ProfileMenuWidget(
                          title: 'User Management',
                          icon: LineAwesomeIcons.user_check,
                          onPress: () {
                            Get.snackbar(
                              "Error",
                              "You don't have access to this.",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor:
                                  Colors.redAccent.withOpacity(0.1),
                              colorText: Colors.red,
                            );
                          }),

                      const SizedBox(height: 10),
                      const Divider(color: Colors.grey),
                      const SizedBox(height: 10),

                      ProfileMenuWidget(
                          title: 'Information',
                          icon: LineAwesomeIcons.info,
                          onPress: () {}),
                      ProfileMenuWidget(
                          title: 'Logout',
                          icon: LineAwesomeIcons.alternate_sign_out,
                          textColor: Colors.red,
                          endIcon: false,
                          onPress: () {
                            AuthenticationRepository.instance
                                .logout()
                                .then((value) {
                              print("Logged Out");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const WelcomeScreen()));
                            }).onError((error, stackTrace) {
                              print("Error ${error.toString()}");
                            });
                          }),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else {
                  return const Center(child: Text('Something went wrong'));
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),

      // bottomNavigationBar: CurvedNavigationBar(
      //   index: 3,
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
      //       //       MaterialPageRoute(builder: (context) => const ProfileScreen()));
      //       // }
      //     ),
      //   ],
      // ),
    );
  }
}

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.blueAccent.withOpacity(0.1),
        ),
        child: Icon(icon, color: Colors.blueAccent),
      ),
      title: Text(title,
          style:
              Theme.of(context).textTheme.bodyLarge?.apply(color: textColor)),
      trailing: endIcon
          ? Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Theme.of(context).backgroundColor.withOpacity(0.1),
              ),
              child: const Icon(LineAwesomeIcons.angle_right,
                  size: 18, color: Colors.grey),
            )
          : null,
    );
  }
}
