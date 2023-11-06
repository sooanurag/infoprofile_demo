import 'package:flutter/material.dart';
import 'package:infoprofile_demo/models/prefrences_settings_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefrenceService {
  Future<void> savePrefrences({
    required PrefrencesSettings prefrencesSettings,
  }) async {
    final prefrences = await SharedPreferences.getInstance();
    if (prefrencesSettings.accesstoken != null) {
      await prefrences.setString(
          "accesstoken", prefrencesSettings.accesstoken!);
    }
    if (prefrencesSettings.userId != null) {
      await prefrences.setString("userId", prefrencesSettings.userId!);
    }
    if (prefrencesSettings.fullName != null) {
      await prefrences.setString("fullName", prefrencesSettings.fullName!);
    }
    if (prefrencesSettings.username != null) {
      await prefrences.setString("username", prefrencesSettings.username!);
    }
    if (prefrencesSettings.profilePic != null) {
      await prefrences.setString("profilePic", prefrencesSettings.profilePic!);
    }
    if (prefrencesSettings.profileBio != null) {
      await prefrences.setString("profileBio", prefrencesSettings.profileBio!);
    }
    if (prefrencesSettings.email != null) {
      await prefrences.setString("email", prefrencesSettings.email!);
    }
    if (prefrencesSettings.followerCount != null) {
      await prefrences.setInt(
          "followerCount", prefrencesSettings.followerCount!);
    }
    if (prefrencesSettings.followingCount != null) {
      await prefrences.setInt(
          "followingCount", prefrencesSettings.followingCount!);
    }
    if (prefrencesSettings.postCount != null) {
      await prefrences.setInt("postCount", prefrencesSettings.postCount!);
    }
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
