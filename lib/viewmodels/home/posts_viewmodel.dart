import 'package:flutter/material.dart';
import 'package:infoprofile_demo/models/comments_model.dart';
import 'package:infoprofile_demo/providers/home/feeds/comments_provider.dart';
import 'package:infoprofile_demo/repository/home/posts_repo.dart';
import 'package:infoprofile_demo/utils/utils.dart';


class PostsViewModel {
  Future<void> likeApiCall({
    required String accessToken,
    required String postId,
  }) async {

    await PostRepository()
        .postLikesApi(accessToken: accessToken, postId: postId)
        .then((value) => null)
        .onError(
            (error, stackTrace) => Utils.showToastMessage(error.toString()));
    
  }

  Future<void> disLikeApiCall({
    required String accessToken,
    required String postId,
  }) async {
    await PostRepository()
        .postDislikesApi(accessToken: accessToken, postId: postId)
        .then((value) => null)
        .onError(
            (error, stackTrace) => Utils.showToastMessage(error.toString()));
  }

  Future<dynamic> getComments({
    required String accessToken,
    required String postId,
    required CommentsProvider commentsProvider,
  }) async {
    dynamic res;
    await PostRepository()
        .listCommentsApi(accessToken: accessToken, postId: postId)
        .then((value) {
      CommentsModel commentsModel = CommentsModel.fromJson(value);
      List<Comment> commentsList = commentsModel.data.comments;
      res = commentsList;
      //print
      commentsProvider.setCommentsList(comments: commentsList, postId: postId);
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      Utils.showToastMessage(error.toString());
    });
    return res;
  }

  Future<dynamic> createComment({
    required String accessToken,
    required String comment,
    required String postId,
    required CommentsProvider commentsProvider,
    required User user,
  }) async {
    await PostRepository()
        .createCommentApi(
            accessToken: accessToken, comment: comment, postId: postId)
        .then((value) {
      String commentId = value['data']['_id'];

      Comment newComment = Comment(id: commentId, comment: comment, user: user);
      commentsProvider.addCommentToList(newComment: newComment, postId: postId);
      //notification
    }).onError((error, stackTrace) => Utils.showToastMessage(error.toString()));
  }

  Future<void> deleteComment({
    required String accessToken,
    required String postId,
    required String commentId,
    required int commentIndex,
    required CommentsProvider commentsProvider,
  }) async {
    await PostRepository()
        .deleteCommentApi(
            accessToken: accessToken, postId: postId, commentId: commentId)
        .then((value) {
      commentsProvider.removeComment(
          commentIndex: commentIndex, postId: postId);
    }).onError((error, stackTrace) => Utils.showToastMessage(error.toString()));
  }

  Future<void> editComment({
    required String accessToken,
    required String postId,
    required String commentId,
    required String newComment,
    required int commentIndex,
    required CommentsProvider commentsProvider,
  }) async {
    PostRepository()
        .editCommentApi(
      accessToken: accessToken,
      postId: postId,
      commentId: commentId,
      newComment: newComment,
    )
        .then((value) {
      commentsProvider.editComment(
        commentIndex: commentIndex,
        postId: postId,
        newComment: newComment,
      );
    }).onError((error, stackTrace) => Utils.showToastMessage(error.toString()));
  }

  Future<void> reportPost({
    required String accessToken,
    required String postId,
  }) async {
    await PostRepository()
        .reportPostApi(accessToken: accessToken, postId: postId)
        .then((value) => Utils.showToastMessage("Reported."))
        .onError(
            (error, stackTrace) => Utils.showToastMessage(error.toString()));
  }
}
