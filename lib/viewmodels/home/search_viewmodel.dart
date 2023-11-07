import 'package:flutter/material.dart';
import 'package:infoprofile_demo/providers/home/search_provider.dart';
import 'package:infoprofile_demo/repository/home/profile_repo.dart';
import 'package:infoprofile_demo/utils/utils.dart';

import '../../repository/home/user_repo.dart';

class SearchViewModel {
  Future<dynamic> onSubmitSearch({
    required String accessToken,
    required String inputName,
    required BuildContext context,
  }) async {
    if (inputName.isNotEmpty) {
      try {
        return await UserRepository().userSearchApi(
          accessToken: accessToken,
          name: inputName,
        );
      } catch (e) {
        rethrow;
      }
    }
  }

  Future<dynamic> followUser({
    required String accessToken,
    required String followingId,
    required SearchProvider searchProvider,
  }) async {
    await ProfileRepository()
        .followUserApi(accessToken: accessToken, followingId: followingId)
        .then((value) {
      searchProvider.setFollowStatsu(status: "Unfollow");
      Utils.showToastMessage("following!");
    }).onError((error, stackTrace) => Utils.showToastMessage(error.toString()));
  }

  Future<dynamic> unFollowUser({
    required String accessToken,
    required String followingId,
    required SearchProvider searchProvider,
  }) async {
    await ProfileRepository()
        .unfollowUserApi(accessToken: accessToken, followingId: followingId)
        .then((value) {
      searchProvider.setFollowStatsu(status: "Follow");
      Utils.showToastMessage("Unfollowed!");
    }).onError((error, stackTrace) => Utils.showToastMessage(error.toString()));
  }

  Future<dynamic> getUserProfile({
    required String accessToken,
    required String userId,
  }) async {
    try {
      dynamic res = await UserRepository()
          .userProfileApi(accessToken: accessToken, userId: userId);
      debugPrint('userProfile: $res');
      return res;
    } catch (e) {
      rethrow;
    }
  }
}
