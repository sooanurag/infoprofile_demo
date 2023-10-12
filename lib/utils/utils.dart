import 'package:flutter/material.dart';
import 'package:infoprofile_demo/providers/theme_provider.dart';

class Utils {
  //textButton
  static textButton({
    required VoidCallback onPressed,
    required String buttonText,
    required ThemeProvider themeProvider,
    double? elevation,
    double? fontSize = 16,
    double? hzPadding = 20,
  }) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            (themeProvider.themeMode == ThemeMode.light)
                ? Colors.white
                : Colors.black87,
          ),
          elevation: MaterialStateProperty.all(elevation),
          shadowColor: MaterialStateProperty.all(
            (themeProvider.themeMode == ThemeMode.light)
                ? Colors.black
                : Colors.white,
          )),
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: hzPadding!),
        child: Text(
          buttonText,
          style:  TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
  //----------------------------
}
