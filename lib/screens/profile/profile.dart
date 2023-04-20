import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:huddle_hub/screens/profile/pfp.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../utils/constants/colors.dart';
import '../../utils/models/navbar_model.dart';
import '../../utils/controllers/profile_controller.dart';
import '../../utils/models/user_model.dart';
import '../../utils/widgets/reusable_widgets.dart';
import '../settings.dart';
import 'editProfile.dart';

class ProfileScreen extends StatefulWidget {
  static String routeName = "/profile";
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? image;
  String imageUrl = ' ';
  var imageLink;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);

      //final imageTemp = File(image.path);
      final imagePath = await saveImagePermanently(image!.path);
      setState(() => this.image = imagePath);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<File> saveImagePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');

    Reference ref = FirebaseStorage.instance.ref().child('profilepic.jpg');
    await ref.putFile(File(image.path));
    ref.getDownloadURL().then((value) {
      print(value);
      setState(() {
        imageUrl = value;
        imageLink = PfPDB(imageUrl: value);
        storeImageUrl(imageLink);
      });
    });

    return File(imagePath).copy(image.path);
  }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.light;
    final controller = Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFC0FFE8),
        centerTitle: true,
        toolbarHeight: 45,
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
            onPressed: () {
              Get.to(
                () => const SettingsScreen(),
                transition: Transition.rightToLeft,
                duration: const Duration(milliseconds: 500),
              );
            },
            icon: SvgPicture.asset(
              "assets/icons/Settings.svg",
              color: primaryColor,
            ),
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
                          CircleAvatar(
                            backgroundImage: imageUrl == ' '
                                ? const AssetImage('assets/images/Huddle.png')
                                : NetworkImage(imageUrl) as ImageProvider,
                            radius:
                                MediaQuery.of(context).size.aspectRatio * 100,
                            foregroundColor: primaryColor,
                          ),
                          Positioned(
                            top: 30,
                            right: 0,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.1,
                              height: MediaQuery.of(context).size.height * 0.2,
                              decoration: const BoxDecoration(
                                color: Color(0xFF000014),
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: const Icon(
                                  LineAwesomeIcons.alternate_pencil,
                                  size: 20,
                                ),
                                color: Colors.white,
                                onPressed: () => myPfPDialog(context),
                              ),
                            ),
                          )
                        ],
                      ),

                      const SizedBox(height: 10),

                      // Profile Details
                      Text(
                        '${userData.fullName}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        userData.email,
                        style: const TextStyle(
                          fontSize: 15,
                          fontFamily: 'Aware',
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Edit Profile Button
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: myButton(context, 'Edit Profile',
                            () => Get.to(() => const UpdateProfileScreen())),
                      ),

                      const SizedBox(height: 25),
                      const Divider(color: Colors.grey),
                      const SizedBox(height: 10),
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
      bottomNavigationBar: myNavBar(MenuState.profile),
    );
  }

  
// Image Selection
  Future myPfPDialog(context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Select Image Source',
          textAlign: TextAlign.center,
        ),
        titlePadding: const EdgeInsets.all(15),
        actions: [
          // Camera Option
          TextButton(
            onPressed: () =>
                Navigator.pop(context, pickImage(ImageSource.camera)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  LineAwesomeIcons.camera,
                  color: primaryColor,
                  size: 30,
                ),
                SizedBox(width: 10),
                Text(
                  'Camera',
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),

          // Gallery Option
          TextButton(
            onPressed: () =>
                Navigator.pop(context, pickImage(ImageSource.gallery)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  LineAwesomeIcons.image,
                  color: primaryColor,
                  size: 30,
                ),
                SizedBox(width: 10),
                Text(
                  'Gallery',
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
