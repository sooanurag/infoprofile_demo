import 'package:flutter/material.dart';

class SearchProvider with ChangeNotifier {
  bool _isSearchInputEmpty = true;
  bool get isSearchInputEmpty => _isSearchInputEmpty;
  void setSeachInputStatus({required bool status}) {
    _isSearchInputEmpty = status;
    notifyListeners();
  }
}
