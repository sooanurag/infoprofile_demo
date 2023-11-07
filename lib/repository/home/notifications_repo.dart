import 'package:flutter/material.dart';
import 'package:infoprofile_demo/resources/api_payloads.dart';
import 'package:infoprofile_demo/resources/urls.dart';
import 'package:infoprofile_demo/services/network/base_api_service.dart';
import 'package:infoprofile_demo/services/network/network_api_service.dart';

class NotificationsRepository {
  final BaseApiService _apiService = NetworkApiService();

  Future<dynamic> addNotificationApi({
    required String accessToken,
    required String receiverId,
    required String activityId,
    required String type,
  }) async {
    try {
      debugPrint('accT: $accessToken');
      return await _apiService.postApiCall(
        url: AppUrls.addNotification,
        header: ApiPayload.bearerTokenHeader(bearerToken: accessToken),
        data: ApiPayload.addNotificationsData(
          receiverId: receiverId,
          activityId: activityId,
          type: type,
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> deleteNotificationApi({
    required String accessToken,
    required String notificationId,
  }) async {
    try {
      return await _apiService.deleteApiCall(
        url: AppUrls.deleteNotification,
        header: ApiPayload.bearerTokenHeader(bearerToken: accessToken),
        params: 'notificationId=$notificationId',
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getNotificationApi({
    required String accessToken,
  }) async {
    try {
      return await _apiService.getApiCall(
        url: AppUrls.getnotification,
        header: ApiPayload.bearerTokenHeader(bearerToken: accessToken),
        params: 'pageNo=1&limit=20',
      );
    } catch (e) {
      rethrow;
    }
  }
}
