import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String? fullName;
  final String? firstName;
  final String? lastName;
  final String? dob;
  final String email;
  final String phoneNo;
  final String password;

  const UserModel({
    this.id,
    required this.email,
    required this.password,
    required this.fullName,
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.phoneNo,
  });

  toJson() {
    return {
      'Full Name': '$firstName $lastName',
      'First Name': firstName,
      'Last Name': lastName,
      'Date of Birth': dob,
      'Email': email,
      'Phone Number': phoneNo,
      'Password': password,
    };
  }

  // Map User fetched from Firebase to UserModel
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
      id: document.id,
      email: data['Email'],
      password: data['Password'],
      fullName: data['Full Name'],
      firstName: data['First Name'],
      lastName: data['Last Name'],
      dob: data['Date of Birth'],
      phoneNo: data['Phone Number'],
    );
  }
}
