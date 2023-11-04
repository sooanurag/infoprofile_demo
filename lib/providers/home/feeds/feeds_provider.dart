import 'package:flutter/material.dart';

import '../../../models/userfeeds_model.dart';

class FeedsProvider with ChangeNotifier {
  dynamic _feedsList;
  List<UserFeed> get feedsList => _feedsList;
  void setFeeds({required List<UserFeed> feeds}) {
    _feedsList = feeds;
    notifyListeners();
  }

  // after pagination
  int _pageNo = 1;
  int get pageNo => _pageNo;
  void setPageNo({required int pageNo}) {
    _pageNo = pageNo;
    notifyListeners();
  }

  void addFeeds({required List<UserFeed> newFeeds}) {
    _feedsList.add(newFeeds);
    notifyListeners();
  }

  void refreshFeeds() {
    _feedsList.clear();
    _pageNo = 1;
    notifyListeners();
  }
}
