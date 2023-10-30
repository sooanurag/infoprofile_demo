import 'package:flutter/material.dart';

import 'package:infoprofile_demo/models/prefrences_settings_model.dart';

class UserProvider with ChangeNotifier {
  dynamic _userData;
  PrefrencesSettings get userData => _userData;
  void setUserData({required PrefrencesSettings userData}) {
    _userData = userData;
    notifyListeners();
  }
}
