import 'package:flutter/material.dart';

import 'package:infoprofile_demo/models/comments_model.dart';
import 'package:infoprofile_demo/models/prefrences_settings_model.dart';
import 'package:infoprofile_demo/providers/home/feeds/comments_provider.dart';
import 'package:infoprofile_demo/utils/utils.dart';
import 'package:provider/provider.dart';

import '../../../../models/userfeeds_model.dart';
import '../../../../resources/fonts.dart';
import '../../../../resources/strings.dart';
import '../../../../viewmodels/home/posts_viewmodel.dart';

class CommentTiles extends StatefulWidget {
  final PrefrencesSettings prefrencesSettings;
  final UserData postUserData;
  final String accessToken;
  final UserPosts postData;
  final ValueNotifier<int> commentsCount;
  const CommentTiles({
    super.key,
    required this.commentsCount,
    required this.prefrencesSettings,
    required this.postUserData,
    required this.postData,
    required this.accessToken,
  });

  @override
  State<CommentTiles> createState() => _CommentTilesState();
}

class _CommentTilesState extends State<CommentTiles> {
  final _editCommentController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _editCommentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              return Consumer<CommentsProvider>(
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
                              trailing: Utils.popUpMenu(
                                  context: context,
                                  popUpMenuItems: (currentComment.user.id ==
                                          widget.prefrencesSettings.userId)
                                      ? [
                                          PopupMenuItem(
                                            child: const Text("Delete"),
                                            onTap: () async {
                                              // delete api
                                              await PostsViewModel()
                                                  .deleteComment(
                                                accessToken: widget.accessToken,
                                                postId: postData.id,
                                                commentId: currentComment.id,
                                                commentIndex: length - index,
                                                commentsProvider:
                                                    commentsProvider,
                                              );
                                              widget.commentsCount.value--;
                                            },
                                          ),
                                          PopupMenuItem(
                                            child: const Text("Edit"),
                                            onTap: () async {
                                              Utils.alertDialog(
                                                context: context,
                                                inputTitle:
                                                    const Text("Edit comment"),
                                                inputContent: TextField(
                                                  controller:
                                                      _editCommentController,
                                                  decoration:
                                                      const InputDecoration(
                                                    hintText: "New comment",
                                                    border:
                                                        OutlineInputBorder(),
                                                  ),
                                                ),
                                                inputActions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child:
                                                          const Text("Cancel")),
                                                  TextButton(
                                                    onPressed: () async {
                                                      if (_editCommentController
                                                          .text.isNotEmpty) {
                                                        await PostsViewModel()
                                                            .editComment(
                                                          accessToken: widget
                                                              .accessToken,
                                                          commentId:
                                                              currentComment.id,
                                                          commentIndex: length - index,
                                                          commentsProvider:
                                                              commentsProvider,
                                                          newComment:
                                                              _editCommentController
                                                                  .text,
                                                          postId: postData.id,
                                                        );
                                                        _editCommentController
                                                            .clear();
                                                        if(context.mounted){
                                                        Navigator.pop(context);}
                                                      }
                                                    },
                                                    child: const Text("Save"),
                                                  ),
                                                ],
                                              );
                                            },
                                          )
                                        ]
                                      : [
                                          PopupMenuItem(
                                            child: const Text("Report"),
                                            onTap: () {
                                              // repost api
                                              Utils.showToastMessage(
                                                  "Comment reported!");
                                            },
                                          )
                                        ]),
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
