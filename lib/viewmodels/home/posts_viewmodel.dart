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
}
