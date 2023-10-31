import 'package:flutter/material.dart';
import 'package:infoprofile_demo/repository/home/posts_repo.dart';

class ProfileViewModel {
  Future<dynamic> userPostsApiCall({
    required String accessToken,
    required String userId,
  }) async {
    try {
      dynamic response = await PostRepository().getMyPostApi(
        accessToken: accessToken,
      );
      debugPrint('posts: ${response.toString()}');
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
