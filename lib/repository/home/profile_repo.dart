import 'package:flutter/material.dart';
import 'package:infoprofile_demo/resources/api_payloads.dart';
import 'package:infoprofile_demo/services/network/base_api_service.dart';
import 'package:infoprofile_demo/services/network/network_api_service.dart';

import '../../resources/urls.dart';

class ProfileRepository {
  final BaseApiService _apiService = NetworkApiService();

  Future<dynamic> followUserApi({
    required String accessToken,
    required String followingId,
  }) async {
    try {
      dynamic res = await _apiService.postApiCall(
        url: AppUrls.followUser,
        header: ApiPayload.bearerTokenHeader(bearerToken: accessToken),
        params: 'followingId=$followingId',
      );
      debugPrint(res.toString());
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> unfollowUserApi({
    required String accessToken,
    required String followingId,
  }) async {
    try {
      return await _apiService.deleteApiCall(
        url: AppUrls.unfollowUser,
        header: ApiPayload.bearerTokenHeader(bearerToken: accessToken),
        params: 'followingId=$followingId',
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getUsersFollowersApi({
    required String accessToken,
    required String userId,
  }) async {
    try {
      return await _apiService.getApiCall(
        url: AppUrls.getFollowers,
        header: ApiPayload.bearerTokenHeader(bearerToken: accessToken),
        params: 'UserId=$userId',
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getUsersFollowingApi({
    required String accessToken,
    required String userId,
  }) async {
    try {
      return await _apiService.getApiCall(
        url: AppUrls.getFollowing,
        header: ApiPayload.bearerTokenHeader(bearerToken: accessToken),
        params: 'UserId=$userId',
      );
    } catch (e) {
      rethrow;
    }
  }
}
