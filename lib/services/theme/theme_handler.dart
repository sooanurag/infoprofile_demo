import 'package:flutter/material.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: Colors.white,
);

var kDarkColorScheme =
    ColorScheme.fromSeed(brightness: Brightness.dark, seedColor: Colors.black);

ThemeData lightTheme = ThemeData().copyWith(
  useMaterial3: true,
  colorScheme: kColorScheme,
);

ThemeData darkTheme = ThemeData.dark().copyWith(
    useMaterial3: true,
    colorScheme: kDarkColorScheme,
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        iconColor:MaterialStateProperty.all(Colors.white),
      )
    ),
    appBarTheme: const AppBarTheme().copyWith(
        backgroundColor: Colors.black,
        surfaceTintColor: Colors.black,
        foregroundColor: Colors.white),
    scaffoldBackgroundColor: Colors.black
    // scaffoldBackgroundColor: Colors.white,
    );
