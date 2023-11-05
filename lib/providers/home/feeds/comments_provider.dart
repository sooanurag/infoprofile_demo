import 'package:flutter/material.dart';

import '../../../models/comments_model.dart';

class CommentsProvider with ChangeNotifier {
  List<Comment>? _commentsList;
  final Map<String, List<Comment>> _commentsMap = {};
  List<Comment> get commentsList => _commentsList ?? <Comment>[];
  void setCommentsList(
      {required List<Comment> comments, required String postId}) {
    _commentsList = comments;
    _commentsMap[postId] = comments;
    notifyListeners();
  }

  void addCommentToList({required Comment newComment, required String postId}) {
    _commentsMap[postId]?.add(newComment);
    debugPrint('new Comment: ${_commentsMap[postId]?[0]}');
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
}
