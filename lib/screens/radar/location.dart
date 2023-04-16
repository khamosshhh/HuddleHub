import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LocationDB {
  final double latitude;
  final double longitude;

  LocationDB({required this.latitude, required this.longitude});

  Map<String, dynamic> toMap() {
    return {'latitude': latitude, 'longitude': longitude};
  }
}

void storeLocation(LocationDB location) async {
  // Get the current user's ID
  final userId = FirebaseAuth.instance.currentUser!.uid;
  print(userId);

  // Create a reference to the user's location document
  final locationRef =
      FirebaseFirestore.instance.collection('locations').doc(userId);

  // Set the location data
  await locationRef.set(location.toMap());
}
