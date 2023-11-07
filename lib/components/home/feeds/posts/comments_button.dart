import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infoprofile_demo/components/home/feeds/posts/comment_tiles.dart';
import 'package:infoprofile_demo/models/comments_model.dart';
import 'package:infoprofile_demo/models/prefrences_settings_model.dart';
import 'package:infoprofile_demo/providers/home/feeds/comments_provider.dart';
import 'package:infoprofile_demo/resources/colors.dart';
import 'package:infoprofile_demo/utils/utils.dart';
import 'package:infoprofile_demo/viewmodels/home/posts_viewmodel.dart';

import 'package:provider/provider.dart';
import '../../../../models/userfeeds_model.dart';
import '../../../../viewmodels/home/notifications_viewmodel.dart';

class CommentsButton extends StatefulWidget {
  final PrefrencesSettings prefrencesSettings;
  final UserData postUserData;
  final String accessToken;
  final UserPosts postData;
  const CommentsButton({
    super.key,
    required this.postUserData,
    required this.prefrencesSettings,
    required this.accessToken,
    required this.postData,
  });

  @override
  State<CommentsButton> createState() => _CommentsButtonState();
}

class _CommentsButtonState extends State<CommentsButton> {
  final _commentsController = TextEditingController();
  final _commentsFocusNode = FocusNode();
  late CommentsProvider commentsProvider;

  @override
  void initState() {
    super.initState();
    _commentsFocusNode.requestFocus();
    commentsProvider = Provider.of<CommentsProvider>(context, listen: false);
  }

  @override
  void dispose() {
    _commentsController.dispose();
    _commentsFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // debugPrint("comments-button ; call");
    final UserPosts postData = widget.postData;
    ValueNotifier<int> commentsCount =
        ValueNotifier<int>(widget.postData.commentCount);
    final commentsProvider =
        Provider.of<CommentsProvider>(context, listen: false);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          visualDensity: VisualDensity.compact,
          onPressed: () async {
            Future.delayed(
              Duration.zero,
              () => commentsProvider.clearCommentsMap(),
            );
            await showModalBottomSheet(
              shape: const LinearBorder(),
              showDragHandle: true,
              useSafeArea: true,
              isScrollControlled: true,
              context: context,
              builder: (context) {
                // debugPrint("bottom-sheet call");
                return Scaffold(
                  backgroundColor: Colors.transparent,
                  body: SafeArea(
                    child: Column(
                      children: [
                        Expanded(
                          child: CommentTiles(
                            commentsCount: commentsCount,
                            prefrencesSettings: widget.prefrencesSettings,
                            postUserData: widget.postUserData,
                              postData: postData,
                              accessToken: widget.accessToken),
                        ),
                        Utils.customTextFormField(
                          inputFontColor:
                              (Theme.of(context).brightness == Brightness.dark)
                                  ? AppColors.white
                                  : AppColors.black,
                          prefixIcon: const CircleAvatar(),
                          contentPadding: const EdgeInsets.all(20),
                          isBorder: false,
                          hint: "Write comment...",
                          hintColor:
                              (Theme.of(context).brightness == Brightness.dark)
                                  ? AppColors.white
                                  : AppColors.black,
                          cursorColor:
                              (Theme.of(context).brightness == Brightness.dark)
                                  ? AppColors.white
                                  : AppColors.black,
                          inputController: _commentsController,
                          currentFocusNode: _commentsFocusNode,
                          invalidText: "",
                          suffixIcon: IconButton(
                            onPressed: () async {
                              await onSubmitComment(commentsCount: commentsCount);
                              
                            },
                            icon: const FaIcon(FontAwesomeIcons.locationArrow),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          icon: const FaIcon(
            FontAwesomeIcons.comment,
            size: 20,
          ),
        ),
        // comments counts
        ValueListenableBuilder(
            valueListenable: commentsCount,
            builder: (context, value, child) {
              postData.commentCount = commentsCount.value;
              return Text(commentsCount.value.toString());
            }),
      ],
    );
  }

  Future<void> onSubmitComment({
    required ValueNotifier<int> commentsCount,
  }) async {
    String comment = _commentsController.text;
    _commentsController.clear();
    User user = User(
      id: widget.prefrencesSettings.userId ?? "",
      username: widget.prefrencesSettings.username ?? "",
      email: widget.prefrencesSettings.email ?? "",
      profilePic: widget.prefrencesSettings.profilePic ?? "",
    );
    await PostsViewModel().createComment(
      user: user,
      commentsProvider: commentsProvider,
      accessToken: widget.accessToken,
      comment: comment,
      postId: widget.postData.id,
    );
    commentsCount.value++;
    await NotificationsViewModel().addNotification(
        accessToken: widget.accessToken,
        postUserId: widget.postData.userId,
        postId: widget.postData.id,
        type: 'COMMENT',
      );
  }
}
