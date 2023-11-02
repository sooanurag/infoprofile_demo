import 'package:flutter/material.dart';
import 'package:infoprofile_demo/models/userfeeds_model.dart';
import 'package:infoprofile_demo/providers/home/feeds_provider.dart';

import 'package:infoprofile_demo/repository/home/user_repo.dart';

class FeedsViewModel {
  Future<dynamic> userFeedsApiCall({
    required String accessToken,
    required int pageNo,
  }) async {

    debugPrint('page no: $pageNo');
    try {
      dynamic response = await UserRepository()
          .userFeedsApi(accessToken: accessToken, pageNo: pageNo.toString());
      //print
      debugPrint('feeds res: $response');
      // return response;
      return response;
    } catch (e) {
      debugPrint('feeds er: $e');
      rethrow;
    }
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
