import 'package:flutter/material.dart';

class GetstartedProvider with ChangeNotifier {
  bool _isWelcomed = false;
  bool get isWelcomed => _isWelcomed;
  void setIsWelcomed({required bool status}) {
    _isWelcomed = status;
    notifyListeners();
  }

  bool _isAuth = false;
  bool get isAuth => _isAuth;
  void setIsAuth({required bool status}) {
    _isAuth = status;
    notifyListeners();
  }

  bool _isFadeOut = false;
  bool get isFadeOut => _isFadeOut;
  void setIsFadeOut({required bool status}) {
    _isFadeOut = status;
    notifyListeners();
  }

}
