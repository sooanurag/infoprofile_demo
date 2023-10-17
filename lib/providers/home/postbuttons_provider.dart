import 'package:flutter/material.dart';

class PostbuttonsProvider with ChangeNotifier {
  bool _isLiked = false;
  bool get isLiked => _isLiked;
  void setIsLikedStatus({required bool status}) {
    _isLiked = status;
    notifyListeners();
  }
}
