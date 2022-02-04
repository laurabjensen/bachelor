import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData theme = ThemeData(
      colorScheme: ColorScheme.light(primary: Color(0xff007a54)),
      textTheme: GoogleFonts.barlowTextTheme());
}
