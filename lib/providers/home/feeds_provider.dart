import 'package:flutter/material.dart';

class FeedsProvider with ChangeNotifier {
  TextOverflow? _textOverflow = TextOverflow.ellipsis;
  TextOverflow? get textOverFlow => _textOverflow;
  void setTextOverflow({required TextOverflow? textOverflow}) {
    _textOverflow = textOverflow;
    notifyListeners();
  }
}
