import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      colorScheme: ColorScheme.light(primary: Color(0xff007a54)),
      primaryTextTheme: TextTheme(
        headline1:
            GoogleFonts.barlow(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w400),
      ),
    );
  }
}
