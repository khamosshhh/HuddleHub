import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../../utils/constants/colors.dart';

class PfPDB {
  final String imageUrl;

  PfPDB({required this.imageUrl});

  Map<String, dynamic> toMap() {
    return {'imageUrl': imageUrl};
  }
}

void storeImageUrl(PfPDB imageUrl) async {
  // Get the current user's ID
  final userId = FirebaseAuth.instance.currentUser!.uid;
  print(userId);

  // Create a reference to the user's image document
  final imageRef =
      FirebaseFirestore.instance.collection('profilePic').doc(userId);

  // Set the image data
  await imageRef.set(imageUrl.toMap());
}
