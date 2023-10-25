import 'package:flutter/material.dart';
import 'package:infoprofile_demo/services/network/base_api_service.dart';
import 'package:infoprofile_demo/services/network/network_api_service.dart';

import '../../resources/api_payloads.dart';
import '../../resources/urls.dart';

class UserRepository {
  final BaseApiService _apiService = NetworkApiService();

  Future<dynamic> editProfileApi({
    required String accesstoken,
    String? username,
    String? profilePic,
    String? profileBio,
  }) async {
    try {
      await _apiService
          .patchApiCall(
        url: AppUrls.editProfile,
        header: ApiPayload.bearerTokenHeader(bearerToken: accesstoken),
        data: ApiPayload.editProfiletData(
          username: username,
          profileBio: profileBio,
          profilePic: profilePic,
        ),
      )
          .then((value) {
        // action on post
        debugPrint(value.toString());
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> userFeedsApi({
    required String accessToken,
  }) async {
    try {
      await _apiService
          .getApiCall(
              url: AppUrls.userFeed,
              header: ApiPayload.bearerTokenHeader(bearerToken: accessToken))
          .then((value) {
        debugPrint(value.toString());
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> userProfileApi({
    required String accessToken,
    required String userId,
  }) async {
    try {
      await _apiService
          .getApiCall(
        url: AppUrls.userProfile,
        header: ApiPayload.bearerTokenHeader(bearerToken: accessToken),
        params: 'userId=$userId',
      )
          .then((value) {
        debugPrint(value.toString());
      });
    } catch (e) {
      rethrow;
    }
  }
}
