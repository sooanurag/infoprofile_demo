import 'package:flutter/material.dart';
import 'package:infoprofile_demo/models/userfeeds_model.dart';
import 'package:infoprofile_demo/providers/home/feeds/feeds_provider.dart';

import 'package:infoprofile_demo/repository/home/user_repo.dart';
import 'package:infoprofile_demo/resources/strings.dart';
import 'package:infoprofile_demo/utils/utils.dart';

class FeedsViewModel {
  Future<dynamic> userFeedsApiCall({
    required String accessToken,
    required int pageNo,
    required FeedsProvider feedsProvider,
  }) async {
    debugPrint('page no: $pageNo');
    try {
      dynamic response = await UserRepository()
          .userFeedsApi(accessToken: accessToken, pageNo: pageNo.toString());
      //print
      debugPrint('feeds res: $response');
      UserFeedsModel feedsData = UserFeedsModel.fromJson(response);
      List<UserFeed> feedsList = feedsData.userFeed;
      if (pageNo == 1) {
        feedsProvider.setFeeds(feeds: feedsList);
      } else {
        feedsProvider.addFeeds(newFeeds: feedsList);
      }
      // return response;
      return response;
    } catch (e) {
      debugPrint('feeds er: $e');
      rethrow;
    }
  }

  Future<void> logOut({
    required String accessToken,
  })async{
    await UserRepository().logOutApi(accessToken: accessToken)
    .then((value) => Utils.showToastMessage("Loged out."))
    .onError((error, stackTrace) => Utils.showToastMessage(AppStrings.hasError));
  }

  // void nextPage({
  //   required String accessToken,
  //   required FeedsProvider feedsProvider,
  // }) async {
  //   await userFeedsApiCall(
  //           accessToken: accessToken, feedsProvider: feedsProvider)
  //       .then((value) {
  //     debugPrint(value.userFeed.toString());
  //     feedsProvider.addFeeds(newFeeds: value.userFeed);
  //   }).onError((error, stackTrace) {
  //     debugPrint(error.toString());
  //   });
  // }
}
