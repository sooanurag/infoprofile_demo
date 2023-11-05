
import 'package:infoprofile_demo/resources/api_payloads.dart';

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
      return await _apiService
          .postApiCall(
        url: AppUrls.createPost,
        header: ApiPayload.bearerTokenHeader(bearerToken: accesstoken),
        data: ApiPayload.createPostData(
          postUrl: dataUrl,
          caption: caption,
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> deletePostApi({
    required String accessToken,
    required String postId,
  }) async {
    try {
      return await _apiService
          .deleteApiCall(
        url: AppUrls.deletePost,
        header: ApiPayload.bearerTokenHeader(bearerToken: accessToken),
        params: 'postId=$postId',
      );
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
      return await _apiService
          .patchApiCall(
        url: AppUrls.editPost,
        header: ApiPayload.bearerTokenHeader(bearerToken: accessToken),
        data: ApiPayload.editPostData(
          caption: caption,
        ),
        params: 'postId=$postId',
      );
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
      return await _apiService
          .getApiCall(
        url: AppUrls.getPostLikes,
        header: ApiPayload.bearerTokenHeader(bearerToken: accessToken),
        params: 'postId=$postId',
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> postLikesApi({
    required String accessToken,
    required String postId,
  }) async {
    try {
      return await _apiService
          .postApiCall(
        url: AppUrls.postLike,
        header: ApiPayload.bearerTokenHeader(bearerToken: accessToken),
        params: 'postId=$postId',
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> postDislikesApi({
    required String accessToken,
    required String postId,
  }) async {
    try {
      return await _apiService
          .deleteApiCall(
        url: AppUrls.postDislike,
        header: ApiPayload.bearerTokenHeader(bearerToken: accessToken),
        params: 'postId=$postId',
      );
    } catch (e) {
      rethrow;
    }
  }

  // comments

  Future<dynamic> createCommentApi({
    required String accessToken,
    required String comment,
    required String postId,
  }) async {
    try {
      return await _apiService
          .postApiCall(
              url: AppUrls.createComment,
              header: ApiPayload.bearerTokenHeader(bearerToken: accessToken),
              data: ApiPayload.createCommentData(comment: comment),
              params: 'postId=$postId')
          ;
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
      return await _apiService
          .deleteApiCall(
        url: AppUrls.deleteComment,
        header: ApiPayload.bearerTokenHeader(bearerToken: accessToken),
        params: 'postId=$postId&commentId=$commentId',
      );
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
      return await _apiService
          .patchApiCall(
        url: AppUrls.editComment,
        header: ApiPayload.bearerTokenHeader(bearerToken: accessToken),
        params: 'postId=$postId&commentId=$commentId',
        data: ApiPayload.editCommentData(comment: newComment),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> listCommentsApi({
    required String accessToken,
    required String postId,
  }) async {
    try {
      return await _apiService
          .getApiCall(
        url: AppUrls.listComments,
        header: ApiPayload.bearerTokenHeader(bearerToken: accessToken),
        params: 'postId=$postId',
      );
    } catch (e) {
      rethrow;
    }
  }

  // report

  Future<dynamic> reportPostApi({
    required String accessToken,
    required String postId,
  }) async {
    try{
      return await _apiService
        .postApiCall(
      url: AppUrls.reportPost,
      header: ApiPayload.bearerTokenHeader(bearerToken: accessToken),
      params: 'postId=$postId',
    );}
    catch (e) {
      rethrow;
    }
  }
  // get user posts
  Future<dynamic> getUserPostApi({
    required String accessToken,
    required String userId,
  }) async {
    try {
      return await _apiService
          .getApiCall(
        url: AppUrls.getUserPost,
        header: ApiPayload.bearerTokenHeader(bearerToken: accessToken),
        params: 'userId=$userId',
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getMyPostApi({
    required String accessToken,
  }) async {
    try {
      return await _apiService
          .getApiCall(
        url: AppUrls.getMyPost,
        header: ApiPayload.bearerTokenHeader(bearerToken: accessToken),
      );
    } catch (e) {
      rethrow;
    }
  }


  

}
