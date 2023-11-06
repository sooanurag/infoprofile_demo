import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String? _profilePicUrl;
  String? get profilePicUrl => _profilePicUrl;
  void setProfilePicUrl({required String url}) {
    _profilePicUrl = url;
    notifyListeners();
  }

  String? _username;
  String? get username => _username;
  void setusername({required String username}) {
    _username = username;
    notifyListeners();
  }

  String? _fullName;
  String? get fullName => _fullName;
  void setfullName({required String fullName}) {
    _fullName = username;
    notifyListeners();
  }

  String? _profileBio;
  String? get profileBio => _profileBio;
  void setprofileBio({required String profileBio}) {
    _profileBio = profileBio;
    notifyListeners();
  }

  int? _followerCount;
  int? get followerCount => _followerCount;
  void setFollowersCount({required int count}) {
    _followerCount = count;
    notifyListeners();
  }

  int? _followingCount;
  int? get followingCountt => _followingCount;
  void setFollowingCount({required int count}) {
    _followingCount = count;
    notifyListeners();
  }
}
