import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/constants/sizes.dart';
import '../../utils/constants/text_strings.dart';

class OTPScreen extends StatelessWidget {
  static String routeName = "/otp";
  const OTPScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(defaultSize),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              otpTitle,
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold, fontSize: 80.0),
            ),

            Text(otpSubTitle.toUpperCase(),
                style: Theme.of(context).textTheme.headline6),

            const SizedBox(height: 40.0),
            const Text("$otpMessage huddle@hub.com",
                textAlign: TextAlign.center),
            const SizedBox(height: 20.0),

            // OTP Field
            OtpTextField(
              mainAxisAlignment: MainAxisAlignment.center,
              numberOfFields: 6,
              fillColor: Colors.black.withOpacity(0.1),
              filled: true,
              onSubmit: (code) => print("OTP is => $code"),
            ),

            const SizedBox(height: 20.0),

            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: () {}, child: const Text(nexT)),
            ),
          ],
        ),
      ),
    );
  }
}
