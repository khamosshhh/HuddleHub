import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    backgroundColor: bgColor,
    textTheme: MyTextTheme.lightTextTheme,
    elevatedButtonTheme: ElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: OutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: TextFormFieldTheme.lightInputDecorationTheme,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    textTheme: MyTextTheme.darkTextTheme,
    elevatedButtonTheme: ElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: OutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: TextFormFieldTheme.darkInputDecorationTheme,
  );
}

class MyTextTheme {
  MyTextTheme._();

  static TextTheme lightTextTheme = TextTheme(
      headline1: GoogleFonts.montserrat(
          fontSize: 28.0, fontWeight: FontWeight.bold, color: primaryColor),
      headline2: GoogleFonts.montserrat(
          fontSize: 24.0, fontWeight: FontWeight.w700, color: primaryColor),
      headline3: GoogleFonts.poppins(
          fontSize: 24.0, fontWeight: FontWeight.w700, color: primaryColor),
      headline4: GoogleFonts.poppins(
          fontSize: 16.0, fontWeight: FontWeight.w600, color: primaryColor),
      headline6: GoogleFonts.poppins(
          fontSize: 14.0, fontWeight: FontWeight.w600, color: primaryColor),
      bodyText1: GoogleFonts.poppins(
          fontSize: 14.0, fontWeight: FontWeight.normal, color: primaryColor),
      bodyText2: GoogleFonts.poppins(
          fontSize: 14.0, fontWeight: FontWeight.normal, color: primaryColor));

  static TextTheme darkTextTheme = TextTheme(
      headline1: GoogleFonts.montserrat(
          fontSize: 28.0, fontWeight: FontWeight.bold, color: whiteColor),
      headline2: GoogleFonts.montserrat(
          fontSize: 24.0, fontWeight: FontWeight.w700, color: whiteColor),
      headline3: GoogleFonts.poppins(
          fontSize: 24.0, fontWeight: FontWeight.w700, color: whiteColor),
      headline4: GoogleFonts.poppins(
          fontSize: 16.0, fontWeight: FontWeight.w600, color: whiteColor),
      headline6: GoogleFonts.poppins(
          fontSize: 14.0, fontWeight: FontWeight.w600, color: whiteColor),
      bodyText1: GoogleFonts.poppins(
          fontSize: 14.0, fontWeight: FontWeight.normal, color: whiteColor),
      bodyText2: GoogleFonts.poppins(
          fontSize: 14.0, fontWeight: FontWeight.normal, color: whiteColor));
}

class ElevatedButtonTheme {
  static ElevatedButtonThemeData lightElevatedButtonTheme =
      ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              elevation: 0,
              foregroundColor: whiteColor,
              backgroundColor: primaryColor,
              padding: const EdgeInsets.all(18.5),
              side: const BorderSide(color: primaryColor),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0))));

  static ElevatedButtonThemeData darkElevatedButtonTheme =
      ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              elevation: 0,
              foregroundColor: primaryColor,
              backgroundColor: whiteColor,
              padding: const EdgeInsets.all(18.5),
              side: const BorderSide(color: whiteColor),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0))));
}

class OutlinedButtonTheme {
  OutlinedButtonTheme._();

  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        foregroundColor: primaryColor,
        side: const BorderSide(color: primaryColor),
        padding: const EdgeInsets.all(18.5)),
  );

  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        foregroundColor: whiteColor,
        side: const BorderSide(color: whiteColor),
        padding: const EdgeInsets.all(18.5)),
  );
}

class TextFormFieldTheme {
  TextFormFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      prefixIconColor: primaryColor,
      floatingLabelStyle: const TextStyle(color: primaryColor),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          width: 1.5,
          color: primaryColor,
        ),
      ));

  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      prefixIconColor: whiteColor,
      floatingLabelStyle: const TextStyle(color: whiteColor),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(width: 1.5, color: whiteColor),
      ));
}
