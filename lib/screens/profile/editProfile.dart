import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../utils/constants/sizes.dart';
import '../../utils/constants/text_strings.dart';
import '../../utils/controllers/profile_controller.dart';
import '../../utils/models/user_model.dart';
import '../../utils/widgets/reusable_widgets.dart';
import 'profile.dart';
import '../initial/welcome.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  _UpdateProfileScreen createState() => _UpdateProfileScreen();
}

class _UpdateProfileScreen extends State<UpdateProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFC0FFE8),
        centerTitle: true,
        leading: IconButton(
            color: Colors.black,
            icon: const Icon(LineAwesomeIcons.angle_left),
            onPressed: () => Get.back()),
        title: const Text(
          'EDIT PROFILE',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(defaultSize),
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
                                image: AssetImage('assets/images/logo.png'),
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
                              child: const Icon(LineAwesomeIcons.camera,
                                  size: 20, color: Colors.white),
                            ),
                          )
                        ],
                      ),

                      const SizedBox(height: 50),

                      // User Details
                      Form(
                          child: Column(
                        children: [
                          // Full Name
                          TextFormField(
                            initialValue: userData.fullName,
                            decoration: const InputDecoration(
                                label: Text(fullNamE),
                                prefixIcon: Icon(LineAwesomeIcons.user)),
                            textCapitalization: TextCapitalization.words,
                            textInputAction: TextInputAction.next,
                          ),

                          const SizedBox(height: 20),

                          // Email Address
                          TextFormField(
                            initialValue: userData.email,
                            decoration: const InputDecoration(
                                label: Text(emaiL),
                                prefixIcon: Icon(LineAwesomeIcons.envelope_1)),
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                          ),

                          const SizedBox(height: 20),

                          // Phone Number
                          TextFormField(
                            initialValue: userData.phoneNo,
                            decoration: const InputDecoration(
                                label: Text(phoneNo),
                                prefixIcon: Icon(LineAwesomeIcons.phone)),
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.next,
                          ),

                          const SizedBox(height: 20),

                          // Date of Birth
                          TextFormField(
                            initialValue: userData.dob,
                            decoration: const InputDecoration(
                                label: Text(dOb),
                                prefixIcon: Icon(LineAwesomeIcons.calendar)),
                            keyboardType: TextInputType.none,
                            showCursor: false,
                            onTap: (() async {
                              DateTime? pickeddate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime(2000, 1, 1),
                                  firstDate: DateTime(1990),
                                  lastDate: DateTime(2007, 12, 31));

                              // if (pickeddate != null) {
                              //   setState(() {
                              //     _dobController.text =
                              //         DateFormat('dd/MM/yyyy').format(pickeddate);
                              //   });
                              // }
                            }),
                          ),

                          const SizedBox(height: 30),

                          // Submit Button
                          myButton(context, 'Save Profile',
                              () => Get.to(() => const ProfileScreen())),

                          const SizedBox(height: 30),

                          // User Info
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text.rich(
                                TextSpan(
                                  text: 'User Since ',
                                  style: const TextStyle(fontSize: 12),
                                  children: [
                                    TextSpan(
                                      text:
                                          "${FirebaseAuth.instance.currentUser!.metadata.creationTime}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  FirebaseAuth.instance.currentUser!.delete();
                                  Get.to(() => const WelcomeScreen());
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(10),
                                  backgroundColor:
                                      Colors.redAccent.withOpacity(0.1),
                                  elevation: 0,
                                  foregroundColor: Colors.red,
                                  shape: const StadiumBorder(),
                                  side: BorderSide.none,
                                ),
                                child: const Text('Delete'),
                              ),
                            ],
                          ),
                        ],
                      ))
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
      //   index: 2,
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
      //       //       MaterialPageRoute(builder: (context) => const UpdateProfileScreen()));
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
