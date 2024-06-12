import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyle {
  static Color bgColor = Color.fromARGB(255, 231, 233, 248);
  static Color mainColor = Color(0xFF000633);
  static Color accentColor = Color(0xFF0065FF);

  static List<Color> cardsColor = [
    Colors.red.shade100,
    Colors.pink.shade100,
    Colors.orange.shade100,
    Colors.green.shade100,
    Colors.blue.shade100,
    Colors.yellow.shade100,
  ];

  static TextStyle mainTitle =
      GoogleFonts.roboto(fontSize: 18.0, fontWeight: FontWeight.bold);
  static TextStyle mainContent =
      GoogleFonts.roboto(fontSize: 16.0, fontWeight: FontWeight.normal);
  static TextStyle dateTitle =
      GoogleFonts.roboto(fontSize: 13.0, fontWeight: FontWeight.w500);
}
