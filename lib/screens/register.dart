import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:huddle_hub/components/reusable_widgets.dart';
import 'package:huddle_hub/screens/base.dart';
import 'package:huddle_hub/screens/login.dart';
import 'package:huddle_hub/utils/colors.dart';
import 'package:intl/intl.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static String id = 'signup';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // Text Controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _dobController = TextEditingController();

  Future signUp() async {
    // Loading Bar
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });

    // Signing In
    if (passwordConfirmed()) {
      // Creating User
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim())
          .then((value) {
        print("Signed In");
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const BaseScreen()));
      }).onError((error, stackTrace) {
        print("Error ${error.toString()}");
      });

      // Updating User Details
      addUserDetails(
        _firstNameController.text.trim(),
        _lastNameController.text.trim(),
        _emailController.text.trim(),
        _passwordController.text.trim(),
        _dobController.text.trim(),
      );
    }
  }

  Future addUserDetails(String firstName, String lastName, String email,
      String password, String dob) async {
    await FirebaseFirestore.instance.collection('users').add({
      'First Name': firstName,
      'Last Name': lastName,
      'Email': email,
      'Password': password,
      'Date of Birth': dob,
      'User Since': DateTime.now(),
    });
  }

  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmPasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Heading
                Text(
                  'Hello There!',
                  style: GoogleFonts.bebasNeue(
                    fontSize: 52,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Register below with your details!',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),

                const SizedBox(height: 50),

                // First Name
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: _firstNameController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person_rounded),
                        border: InputBorder.none,
                        hintText: 'First Name',
                      ),
                      textCapitalization: TextCapitalization.words,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // Last Name
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: _lastNameController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person_rounded),
                        border: InputBorder.none,
                        hintText: 'Last Name',
                      ),
                      textCapitalization: TextCapitalization.words,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // Date of Birth
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextFormField(
                      controller: _dobController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.edit_calendar_rounded),
                        border: InputBorder.none,
                        hintText: 'Date of Birth',
                      ),
                      keyboardType: TextInputType.none,
                      showCursor: false,
                      onFieldSubmitted: (_) =>
                          FocusScope.of(context).nextFocus(),
                      onTap: (() async {
                        DateTime? pickeddate = await showDatePicker(
                            context: context,
                            initialDate: DateTime(2007, 7, 1),
                            firstDate: DateTime(1990),
                            lastDate: DateTime(2007, 7, 1));

                        if (pickeddate != null) {
                          setState(() {
                            _dobController.text =
                                DateFormat('dd/MM/yyyy').format(pickeddate);
                          });
                        }
                      }),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // Email Address
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.mail_rounded),
                        border: InputBorder.none,
                        hintText: 'Email Address',
                      ),
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // Password Field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.lock_rounded),
                        border: InputBorder.none,
                        hintText: 'Password',
                      ),
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // Confirm Password Field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.lock_rounded),
                        border: InputBorder.none,
                        hintText: 'Confirm Password',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                // Sign Up Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                    onTap: signUp,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF000014),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text(
                          'SIGN UP',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            fontFamily: 'Aware',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // Redirect to Login Page
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already a member?',
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()));
                      },
                      child: const Text(
                        ' Log In',
                        style: TextStyle(
                          color: Colors.lightBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );

    // return Scaffold(
    //   body: Container(
    //       width: MediaQuery.of(context).size.width,
    //       height: MediaQuery.of(context).size.height,
    //       decoration: BoxDecoration(
    //           gradient: LinearGradient(colors: [
    //         hexStringToColor("CB2B93"),
    //         hexStringToColor("9546C4"),
    //         hexStringToColor("5E61F4")
    //       ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
    //       child: SingleChildScrollView(
    //           child: Padding(
    //         padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
    //         child: Column(
    //           children: <Widget>[
    //             logoWidget("assets/images/logo.png"),
    //             const SizedBox(
    //               height: 20,
    //             ),
    //             reusableTextField(" Enter Username", Icons.person_outline,
    //                 false, _firstNameController),
    //             const SizedBox(
    //               height: 20,
    //             ),
    //             reusableTextField(" Enter Email ID", Icons.mail_outline, false,
    //                 _emailTextController),
    //             const SizedBox(
    //               height: 20,
    //             ),
    //             reusableTextField(" Enter Password", Icons.lock_outline, true,
    //                 _passwordTextController),
    //             const SizedBox(
    //               height: 20,
    //             ),
    //             firebaseButton(context, "SIGN UP", () {
    //               FirebaseAuth.instance
    //                   .createUserWithEmailAndPassword(
    //                       email: _emailTextController.text,
    //                       password: _passwordTextController.text)
    //                   .then((value) {
    //                 print("Created New Account");
    //                 Navigator.pushReplacement(
    //                     context,
    //                     MaterialPageRoute(
    //                         builder: (context) => const BaseScreen()));
    //               }).onError((error, stackTrace) {
    //                 print("Error ${error.toString()}");
    //               });
    //             }),
    //             loginOption()
    //           ],
    //         ),
    //       ))),
    // );
  }
}
