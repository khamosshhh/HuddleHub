import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/constants/text_strings.dart';
import '../../utils/controllers/profile_controller.dart';
import '../../utils/models/user_model.dart';
import '../../utils/widgets/reusable_widgets.dart';
import 'pfp.dart';
import 'profile.dart';
import '../initial/welcome.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  _UpdateProfileScreen createState() => _UpdateProfileScreen();
}

class _UpdateProfileScreen extends State<UpdateProfileScreen> {
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

    Reference ref = FirebaseStorage.instance.ref().child(name);
    await ref.putFile(File(image.path));
    ref.getDownloadURL().then((value) {
      print(value);
      setState(() {
        imageUrl = value;
        imageLink = PfPDB(imageUrl: value);

        FirebaseAuth.instance.currentUser!.updatePhotoURL(imageUrl);
        storeImageUrl(imageLink);
      });
    });

    return File(imagePath).copy(image.path);
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    String? urL = FirebaseAuth.instance.currentUser!.photoURL;

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
                          CircleAvatar(
                            backgroundImage: imageUrl == ' '
                                ? const AssetImage('assets/images/Huddle.png')
                                : NetworkImage(urL!) as ImageProvider,
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
