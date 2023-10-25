import 'package:flutter/material.dart';
import 'package:infoprofile_demo/resources/api_payloads.dart';
import 'package:infoprofile_demo/resources/strings.dart';
import 'package:infoprofile_demo/resources/urls.dart';


import '../../services/network/base_api_service.dart';
import '../../services/network/network_api_service.dart';

class PostRepository {
  final BaseApiService _apiService = NetworkApiService();

  Future<dynamic> createPostApi({
    required String accesstoken,
    required String dataUrl,
    String? caption,
  }) async {
    try {
      await _apiService
          .postApiCall(
        url: AppUrls.createPost,
        header: ApiPayload.bearerTokenHeader(bearerToken: accesstoken),
        data: ApiPayload.createPostData(
          postUrl: dataUrl,
          mediaType: AppStrings.mediaType,
          caption: caption,
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

  Future<dynamic> deletePostApi({
    required String accessToken,
    required String postId,
  }) async {
    try {
      await _apiService
          .deleteApiCall(
        url: AppUrls.deletePost,
        header: ApiPayload.bearerTokenHeader(bearerToken: accessToken),
        params: 'postId=$postId',
      )
          .then((value) {
        debugPrint(value.toString());
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> editPostApi({
    required String accessToken,
    required String postId,
    String? caption,
  }) async {
    try {
      await _apiService
          .patchApiCall(
        url: AppUrls.editPost,
        header: ApiPayload.bearerTokenHeader(bearerToken: accessToken),
        data: ApiPayload.editPostData(
          caption: caption,
        ),
        params: 'postId=$postId',
      )
          .then((value) {
        debugPrint(value.toString());
      });
    } catch (e) {
      rethrow;
    }
  }

  // likes

  Future<dynamic> getPostLikesApi({
    required String accessToken,
    required String postId,
  }) async {
    try {
      await _apiService
          .getApiCall(
        url: AppUrls.getPostLikes,
        header: ApiPayload.bearerTokenHeader(bearerToken: accessToken),
        params: 'postId=$postId',
      )
          .then((value) {
        debugPrint(value.toString());
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> postLikesApi({
    required String accessToken,
    required String postId,
  }) async {
    try {
      await _apiService
          .postApiCall(
        url: AppUrls.postLike,
        header: ApiPayload.bearerTokenHeader(bearerToken: accessToken),
        params: 'postId=$postId',
      )
          .then((value) {
        debugPrint(value.toString());
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> postDislikesApi({
    required String accessToken,
    required String postId,
  }) async {
    try {
      await _apiService
          .deleteApiCall(
        url: AppUrls.postDislike,
        header: ApiPayload.bearerTokenHeader(bearerToken: accessToken),
        params: 'postId=$postId',
      )
          .then((value) {
        debugPrint(value.toString());
      });
    } catch (e) {
      rethrow;
    }
  }

  // comments

  Future<dynamic> createCommentApi({
    required BuildContext context,
    required String accesstoken,
    required String comment,
    required String postId,
  }) async {
    try {
      await _apiService
          .postApiCall(
              url: AppUrls.createComment,
              header: ApiPayload.bearerTokenHeader(bearerToken: accesstoken),
              data: ApiPayload.createCommentData(comment: comment),
              params: 'postId=$postId')
          .then((value) {
        // action on post
        debugPrint(value.toString());
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> deleteCommentApi({
    required String accessToken,
    required String postId,
    required String commentId,
  }) async {
    try {
      await _apiService
          .deleteApiCall(
        url: AppUrls.deleteComment,
        header: ApiPayload.bearerTokenHeader(bearerToken: accessToken),
        params: 'postId=$postId&commentId=$commentId',
      )
          .then((value) {
        debugPrint(value.toString());
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> editCommentApi({
    required String accessToken,
    required String postId,
    required String commentId,
    required String newComment,
  }) async {
    try {
      await _apiService
          .patchApiCall(
        url: AppUrls.editComment,
        header: ApiPayload.bearerTokenHeader(bearerToken: accessToken),
        params: 'postId=$postId&commentId=$commentId',
        data: ApiPayload.editCommentData(comment: newComment),
      )
          .then((value) {
        debugPrint(value.toString());
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> listCommentsApi({
    required String accessToken,
    required String postId,
  }) async {
    try {
      await _apiService
          .getApiCall(
        url: AppUrls.listComments,
        header: ApiPayload.bearerTokenHeader(bearerToken: accessToken),
        params: 'postId=$postId',
      )
          .then((value) {
        debugPrint(value.toString());
      });
    } catch (e) {
      rethrow;
    }
  }

  // report

  Future<dynamic> reportPostApi({
    required String accessToken,
    required String postId,
  }) async {
    try{await _apiService
        .postApiCall(
      url: AppUrls.reportPost,
      header: ApiPayload.bearerTokenHeader(bearerToken: accessToken),
      params: 'postId=$postId',
    )
        .then((value) {
      debugPrint(value.toString());
    });}
    catch (e) {
      rethrow;
    }
  }
}
