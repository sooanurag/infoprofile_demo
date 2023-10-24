import 'dart:io';

import 'package:flutter/material.dart';

class CreatePostProvider with ChangeNotifier {
  bool _isPostReady = false;
  bool get isPostReady => _isPostReady;
  void setIsPostReady({required bool status}) {
    _isPostReady = status;
    notifyListeners();
  }

  File? _imageFile;
  File? get imageFile => _imageFile;
  void setImageFile({required File? image}) {
    _imageFile = image;
    (image != null) ? _isPostReady = true : _isPostReady = false;
    notifyListeners();
  }
}
