import 'package:flutter/material.dart';

class AuthAnimateProvider with ChangeNotifier{
  bool _isLoginStateChange = false;
  bool get isLoginStateChange => _isLoginStateChange;
  void setIsLoginStateChange({required bool status}) {
    _isLoginStateChange = status;
    notifyListeners();
  }
}