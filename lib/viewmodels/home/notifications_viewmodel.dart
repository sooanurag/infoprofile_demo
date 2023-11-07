import 'package:flutter/material.dart';
import 'package:infoprofile_demo/repository/home/notifications_repo.dart';
import 'package:infoprofile_demo/utils/utils.dart';

class NotificationsViewModel {
  Future<dynamic> getNotifications({
    required String accessToken,
  }) async {
    try {
      return await NotificationsRepository()
          .getNotificationApi(accessToken: accessToken);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> addNotification({
    required String accessToken,
    required String postUserId,
    required String postId,
    required String type,
  }) async {
    try {
      return await NotificationsRepository().addNotificationApi(
        accessToken: accessToken,
        receiverId: postUserId,
        activityId: postId,
        type: type,
      );
    } catch (e) {
      debugPrint('add-N: $e');
      Utils.showToastMessage(e.toString());
    }
  }

  Future<dynamic> deleteNotification({
    required String accessToken,
    required String notificationId,
  }) async {
    try {
      return await NotificationsRepository().deleteNotificationApi(
          accessToken: accessToken, notificationId: notificationId);
    } catch (e) {
      debugPrint('delete-N: $e');
      Utils.showToastMessage(e.toString());
    }
  }
}
