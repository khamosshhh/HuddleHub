import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:huddle_hub/screens/base.dart';
import 'package:huddle_hub/screens/register.dart';
import 'package:huddle_hub/screens/resetPassword.dart';
import 'package:huddle_hub/components/reusable_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static String id = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Text Controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future signIn() async {
    // Loading Bar
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });

    // Signing In
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim())
        .then((value) {
      print("Logged In");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const BaseScreen()));
    }).onError((error, stackTrace) {
      print("Error ${error.toString()}");
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                logoWidget('assets/images/logo.png'),
                const SizedBox(height: 15),

                // Heading
                const Text(
                  'Hello Again!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Welcome back, you\'ve been missed!',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),

                const SizedBox(height: 50),

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
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // Forgot Password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ResetPassword()));
                        },
                        child: const Text(
                          'Forgot Password?',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: Colors.lightBlue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                const SizedBox(height: 15),

                // Sign In Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                    onTap: signIn,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF000014),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text(
                          'LOG IN',
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

                // Redirect to Register Page
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Not a member?',
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpScreen()));
                      },
                      child: const Text(
                        ' Register Now',
                        style: TextStyle(
                          color: Colors.lightBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ],

              // child: Padding(
              //   padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
              //   child: Column(children: <Widget>[
              //     logoWidget("assets/images/logo.png"),
              //     const SizedBox(
              //       height: 30,
              //     ),
              //     reusableTextField(" Enter Username", Icons.person_outline, false,
              //         _emailTextController),
              //     const SizedBox(
              //       height: 30,
              //     ),
              //     reusableTextField(" Enter Password", Icons.lock_outline, true,
              //         _passwordTextController),
              //     const SizedBox(
              //       height: 5,
              //     ),
              //     forgetPassword(context),
              //     firebaseButton(context, "LOG IN", () {
              //       FirebaseAuth.instance
              //           .signInWithEmailAndPassword(
              //               email: _emailTextController.text,
              //               password: _passwordTextController.text)
              //           .then((value) {
              //         print("Logged In");
              //         Navigator.pushReplacement(
              //             context,
              //             MaterialPageRoute(
              //                 builder: (context) => const BaseScreen()));
              //       }).onError((error, stackTrace) {
              //         print("Error ${error.toString()}");
              //       });
              //     }),
              //     signUpOption()
              //   ]),
              // ),
            ),
          ),
        ),
      ),
    );
  }

  Widget forgetPassword(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
      alignment: Alignment.bottomRight,
      child: TextButton(
        child: const Text(
          "Forgot Password?",
          style: TextStyle(color: Colors.white70),
          textAlign: TextAlign.right,
        ),
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ResetPassword())),
      ),
    );
  }
}
