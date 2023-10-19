import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class AppFonts {
  static TextStyle headerStyle({
    required BuildContext context,
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
        color: color ??
            ((Theme.of(context).brightness == Brightness.dark)
                ? AppColors.white
                : AppColors.black),
        fontStyle: fontStyle,
      );
}
