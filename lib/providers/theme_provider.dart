import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier{
  ThemeMode _themeMode = ThemeMode.light;
  get themeMode => _themeMode;
  toogleTheme({required bool isDark}) {
    _themeMode = (isDark) ? _themeMode = ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}