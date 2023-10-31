import 'package:flutter/material.dart';

import '../../models/userfeeds_model.dart';

class FeedsProvider with ChangeNotifier {
  dynamic _feedsList;
  List<UserFeed> get feedsList => _feedsList;
  void setFeeds({required List<UserFeed> feeds}) {
    _feedsList = feeds;
    notifyListeners();
  }

  // after pagination
  void addFeeds({required List<UserFeed> newFeeds}) {
    _feedsList.add(newFeeds);
    notifyListeners();
  }
}
