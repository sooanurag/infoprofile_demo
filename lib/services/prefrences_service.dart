import 'package:flutter/material.dart';
import 'package:infoprofile_demo/models/prefrences_settings_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefrenceService {
  Future<void> savePrefrences({
    required PrefrencesSettings prefrencesSettings,
  }) async {
    final prefrences = await SharedPreferences.getInstance();
    await prefrences.setString("accesstoken", prefrencesSettings.accesstoken!);
    await prefrences.setString("userId", prefrencesSettings.userId!);
    await prefrences.setString("username", prefrencesSettings.username!);
    await prefrences.setString("fullName", prefrencesSettings.fullName!);
    await prefrences.setString("profilePic", prefrencesSettings.profilePic!);
    await prefrences.setString("profileBio", prefrencesSettings.profileBio!);
    await prefrences.setString("email", prefrencesSettings.email!);
    await prefrences.setInt("followerCount", prefrencesSettings.followerCount!);
    await prefrences.setInt(
        "followingCount", prefrencesSettings.followingCount!);
    await prefrences.setInt("postCount", prefrencesSettings.postCount!);
    //debug-print
    debugPrint("prefrences saved!");
  }

  Future<PrefrencesSettings> getPrefrences() async {
    final prefrences = await SharedPreferences.getInstance();
    String? accesstoken = prefrences.getString("accesstoken");
    String? userId = prefrences.getString("userId");
    String? email = prefrences.getString("email");
    String? username = prefrences.getString("username");
    String? fullName = prefrences.getString("fullName");
    String? profilePic = prefrences.getString("profilePic");
    String? profileBio = prefrences.getString("profileBio");
    int? followerCount = prefrences.getInt("followerCount");
    int? followingCount = prefrences.getInt("followingCount");
    int? postCount = prefrences.getInt("postCount");

    return PrefrencesSettings(
      userId: userId,
      accesstoken: accesstoken,
      email: email,
      username: username,
      fullName: fullName,
      profilePic: profilePic,
      profileBio: profileBio,
      followerCount: followerCount,
      followingCount: followingCount,
      postCount: postCount,
    );
  }
}
