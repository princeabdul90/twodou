/*
* Developer: Abubakar Abdullahi
* Date: 01/08/2022
*/

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TwoDouTheme {
  static TextTheme globalTextTheme = TextTheme(
    bodyText1: GoogleFonts.nunito(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
    bodyText2: GoogleFonts.nunito(
      fontSize: 18,
      fontWeight: FontWeight.w300,
      color: Colors.black,
      fontStyle: FontStyle.italic,
    ),

    headline1: GoogleFonts.nunito(
      fontWeight: FontWeight.w700,
      color: Colors.black,
      fontSize: 24,
    ),
    headline2: GoogleFonts.nunito(
      fontWeight: FontWeight.w700,
      color: Colors.black,
      fontSize: 22,
    ),
  );

  static ThemeData globalTheme() {
    return ThemeData(
      textTheme: globalTextTheme,
      appBarTheme: const AppBarTheme(
        elevation: 0.0,

        backgroundColor: Colors.white,
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor:
            MaterialStateProperty.resolveWith((states) => Colors.blueAccent),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          foregroundColor: Colors.white,
          backgroundColor: Colors.indigoAccent
      ),
    );
  }
}

