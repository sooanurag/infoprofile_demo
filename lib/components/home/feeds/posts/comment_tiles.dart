import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infoprofile_demo/models/comments_model.dart';
import 'package:infoprofile_demo/providers/home/feeds/comments_provider.dart';
import 'package:provider/provider.dart';

import '../../../../models/userfeeds_model.dart';
import '../../../../resources/fonts.dart';
import '../../../../resources/strings.dart';
import '../../../../viewmodels/home/posts_viewmodel.dart';

class CommentTiles extends StatefulWidget {
  final String accessToken;
  final UserPosts postData;
  const CommentTiles({
    super.key,
    required this.postData,
    required this.accessToken,
  });

  @override
  State<CommentTiles> createState() => _CommentTilesState();
}

class _CommentTilesState extends State<CommentTiles> {
  @override
  Widget build(BuildContext context) {
    // debugPrint("Comments Tile - Build call");
    final UserPosts postData = widget.postData;
    final CommentsProvider commentsProvider =
        Provider.of(context, listen: false);
    return FutureBuilder<dynamic>(
        future: (commentsProvider.getCommentFromMap(postId: postData.id) ==
                null)
            ? PostsViewModel().getComments(
                accessToken: widget.accessToken,
                postId: postData.id,
                commentsProvider: commentsProvider,
              )
            : Future.delayed(Duration.zero,
                () => commentsProvider.getCommentFromMap(postId: postData.id)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              List<Comment> commentsList = snapshot.data;
              return
              Consumer<CommentsProvider>(
                builder: (context, value, child) {
                  return (commentsList.isEmpty)
                      ? const Center(
                          child: Text("Add comment!"),
                        )
                      : ListView.builder(
                          addRepaintBoundaries: false,
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                          itemCount: value.commentsList.length,
                          itemBuilder: (context, index) {
                            int length = value.commentsList.length - 1;
                            Comment currentComment =
                                value.commentsList[length - index];
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: const CircleAvatar(),
                              title: Text(
                                currentComment.user.username,
                                style: AppFonts.headerStyle(
                                    context: context, fontSize: 16),
                              ),
                              subtitle: Text(
                                currentComment.comment,
                                style: AppFonts.headerStyle(
                                    context: context, fontSize: 14),
                              ),
                              trailing: IconButton(
                                visualDensity: VisualDensity.compact,
                                onPressed: () {
                                  // open bottom sheet
                                  // edit & delete comment
                                },
                                icon: const FaIcon(
                                  FontAwesomeIcons.ellipsisVertical,
                                  size: 14,
                                ),
                              ),
                            );
                          },
                        );
                },
              );
            } else {
              return const Center(
                child: Text(AppStrings.hasError),
              );
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
