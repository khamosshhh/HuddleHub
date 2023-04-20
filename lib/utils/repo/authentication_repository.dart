import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../screens/home.dart';
import '../../screens/initial/splash.dart';
import '../../screens/initial/welcome.dart';
import '../constants/login_failure_exception.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  // Variables
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  var verificationId = ''.obs;

  // Load on App Launch and set firebaseUser State
  @override
  void onReady() {
    Future.delayed(const Duration(seconds: 6));
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  // Set Initial Screen on App Launch
  _setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => SplashScreen())
        : Get.offAll(() => const HomeScreen());
  }

  // Account Creation
  Future<void> createUserwithEmailandPassword(
      BuildContext context, String email, String password) async {
    // Loading Bar
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });

    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      firebaseUser.value != null
          ? Get.offAll(() => const HomeScreen())
          : Get.offAll(() => const WelcomeScreen());
    } on FirebaseAuthException catch (e) {
      final ex = LoginFailureException.code(e.code);
      print('FIREBASE AUTH EXCEPTION: ${ex.message}');
      throw ex;
    } catch (_) {
      const ex = LoginFailureException();
      print('EXCEPTION: ${ex.message}');
      throw ex;
    }
  }

  // Account Login
  Future<void> loginWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    // Loading Bar
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      firebaseUser.value != null
          ? Get.offAll(() => const HomeScreen())
          : Get.offAll(() => const WelcomeScreen());
    } on FirebaseAuthException catch (e) {
      final ex = LoginFailureException.code(e.code);
      print('FIREBASE AUTH EXCEPTION: ${ex.message}');
      throw ex;
    } catch (_) {
      const ex = LoginFailureException();
      print('EXCEPTION: ${ex.message}');
      throw ex;
    }
  }

  // Number Verification
  Future<FirebaseAuthException?> phoneAuthentication(String phoneNo) async {
    try {
      await _auth.signInWithPhoneNumber(phoneNo);
    } on FirebaseAuthException catch (e) {
      return e;
    } catch (_) {}
    return null;
  }

  // OTP Verification
  Future<FirebaseAuthException?> verifyOTP(String otp) async {
    try {
      (await _auth.checkActionCode(otp)) as bool;
    } on FirebaseAuthException catch (e) {
      return e;
    } catch (_) {}
    return null;
  }

  // Logout
  Future<void> logout() async => await _auth.signOut();
}
