import 'package:flutter/material.dart';

import '../../../models/comments_model.dart';

class CommentsProvider with ChangeNotifier {
  List<Comment>? _commentsList;
  Map<String, List<Comment>> _commentsMap = {};
  List<Comment> get commentsList => _commentsList ?? <Comment>[];
  void setCommentsList(
      {required List<Comment> comments, required String postId}) {
    _commentsList = comments;
    _commentsMap[postId] = comments;
    // _commentsCount = comments.length;
    notifyListeners();
  }

  List<Comment>? getCommentFromMap({required String postId}) {
    if (_commentsMap.containsKey(postId)) {
      debugPrint('provider postId: $postId');
      return _commentsMap[postId];
    }
    return null;
  }

  void clearCommentsMap() {
    _commentsMap.clear();
    notifyListeners();
  }

  // int _commentsCount = 0;
  // int get commentsCount => _commentsCount;
  // void setCommentsCount({required int count}) {
  //   _commentsCount = count;
  //   notifyListeners();
  // }

  // void incrementCommentsCount() {
  //   _commentsCount++;
  //   notifyListeners();
  // }

  // void decrementCommentsCount() {
  //   _commentsCount--;
  //   notifyListeners();
  // }
}
