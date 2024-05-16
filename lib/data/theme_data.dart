import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData lightTheme = ThemeData(
  platform: TargetPlatform.android,
  colorSchemeSeed: const Color.fromARGB(238, 163, 163, 163),
  useMaterial3: true,
  brightness: Brightness.light,
  fontFamily: GoogleFonts.josefinSans().fontFamily,
);

final ThemeData darkTheme = ThemeData(
  platform: TargetPlatform.android,
  colorSchemeSeed: const Color.fromARGB(238, 163, 163, 163),
  useMaterial3: true,
  brightness: Brightness.dark,
  fontFamily: GoogleFonts.josefinSans().fontFamily,
);