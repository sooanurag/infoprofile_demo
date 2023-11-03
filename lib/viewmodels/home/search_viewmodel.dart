import 'package:flutter/material.dart';
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
  }) async {
    await ProfileRepository()
        .followUserApi(accessToken: accessToken, followingId: followingId)
        .then((value) => Utils.showToastMessage("following"))
        .onError((error, stackTrace) => Utils.showToastMessage(error.toString()));
  }
}
