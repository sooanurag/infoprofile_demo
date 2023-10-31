import 'package:flutter/material.dart';
import 'package:infoprofile_demo/models/userfeeds_model.dart';

import 'package:infoprofile_demo/repository/home/user_repo.dart';

class FeedsViewModel {
  static Future<void> feedsRefreshHandler() async {
    // refersh feeds api-call
    return await Future.delayed(const Duration(seconds: 2)); //placeholder
  }

  Future<dynamic> userFeedsApiCall({
    required String accessToken,
  }) async {
    try {
      dynamic response =
          await UserRepository().userFeedsApi(accessToken: accessToken);
      //print
      debugPrint('feeds res: $response');
      return UserFeedsModel.fromJson(response);

    } catch (e) {
      debugPrint('feeds er: $e');
      rethrow;
    }
  }
}
