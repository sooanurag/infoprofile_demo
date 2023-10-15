import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFonts {
  static TextStyle headerStyle({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    TextDecoration? textDecoration,

  }) =>
      GoogleFonts.poppins(
        decoration: textDecoration,
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
        fontStyle: fontStyle,
      );
}
