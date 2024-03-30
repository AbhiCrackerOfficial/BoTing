import 'package:flutter/material.dart';

Color hexToColor(String hexString) {
  hexString = hexString.replaceFirst('#', '');
  String hex;
  String alphaChannel;
  if (hexString.length < 6) {
    hex = hexString.padRight(6, '0');
    alphaChannel = 'FF';
  } else if (hexString.length == 6) {
    hex = hexString;
    alphaChannel = 'FF';
  } else {
    hex = hexString.substring(0, 6);
    alphaChannel = hexString.substring(6, hexString.length);
  }

  String fullHexString = '#$alphaChannel$hex';

  return Color(int.parse(fullHexString.replaceFirst('#', '0x')));
}

String colorToHexColor(Color color) {
  String alphaChannel = color.alpha.toRadixString(16).padLeft(2, '0');
  String redChannel = color.red.toRadixString(16).padLeft(2, '0');
  String greenChannel = color.green.toRadixString(16).padLeft(2, '0');
  String blueChannel = color.blue.toRadixString(16).padLeft(2, '0');

  return '#$redChannel$greenChannel$blueChannel$alphaChannel';
}

MaterialColor createMaterialColor(Color color) {
  final List<double> strengths = <double>[.05];
  final Map<int, Color> swatch = <int, Color>{};

  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }

  for (final double strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }

  return MaterialColor(color.value, swatch);
}
