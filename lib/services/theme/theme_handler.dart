import 'package:flutter/material.dart';
import 'package:infoprofile_demo/resources/colors.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: Colors.grey,
);

var kDarkColorScheme =
    ColorScheme.fromSeed(brightness: Brightness.dark, seedColor: Colors.grey);

ThemeData lightTheme = ThemeData().copyWith(

    dividerColor: Colors.grey,
    iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
      iconColor: MaterialStateProperty.all(Colors.black),
    )),
    drawerTheme: const DrawerThemeData().copyWith(
      backgroundColor: AppColors.white,
      // surfaceTintColor: Colors.white54,
    ),
    appBarTheme: const AppBarTheme().copyWith(
      backgroundColor: AppColors.white,
      surfaceTintColor: AppColors.white,
      foregroundColor: AppColors.white,
    ),
    scaffoldBackgroundColor: AppColors.white);

ThemeData darkTheme = ThemeData.dark().copyWith(
    dividerColor: Colors.grey,

    colorScheme: kDarkColorScheme,
    iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
      iconColor: MaterialStateProperty.all(Colors.white),
    )),
    drawerTheme: const DrawerThemeData().copyWith(
      backgroundColor: Colors.black,
      surfaceTintColor: Colors.black,
    ),
    appBarTheme: const AppBarTheme().copyWith(
        backgroundColor: Colors.black,
        surfaceTintColor: Colors.black,
        foregroundColor: Colors.white),
    scaffoldBackgroundColor: Colors.black);
