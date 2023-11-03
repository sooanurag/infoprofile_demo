import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infoprofile_demo/models/userfeeds_model.dart';
import 'package:infoprofile_demo/viewmodels/home/posts_viewmodel.dart';

class LikeButton extends StatefulWidget {
  final UserPosts postData;
  final ValueNotifier<bool> isLiked;
  final ValueNotifier<int> likesCount;
  final ValueNotifier<bool> islikeAnimation;
  final String accessToken;
  final String postId;
  const LikeButton(
      {super.key,
      required this.postData,
      required this.isLiked,
      required this.likesCount,
      required this.islikeAnimation,
      required this.postId,
      required this.accessToken});

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: widget.isLiked,
        builder: (context, value, child) {
          return Row(
            children: [
              IconButton(
                visualDensity: VisualDensity.compact,
                onPressed: () async {
                  //like
                  widget.isLiked.value = !widget.isLiked.value;
                  widget.islikeAnimation.value = widget.isLiked.value;
                  (widget.isLiked.value)
                      ? widget.likesCount.value++
                      : widget.likesCount.value--;
                  setState(() {});
                  widget.postData.isLiked = widget.isLiked.value;
                  widget.postData.likeCount = widget.likesCount.value;
                  (!widget.isLiked.value)
                      ? PostsViewModel().disLikeApiCall(
                          accessToken: widget.accessToken,
                          postId: widget.postId)
                      : PostsViewModel().likeApiCall(
                          accessToken: widget.accessToken,
                          postId: widget.postId);
                },
                icon: FaIcon(
                  (widget.isLiked.value)
                      ? FontAwesomeIcons.solidHeart
                      : FontAwesomeIcons.heart,
                  size: 20,
                  color: (widget.isLiked.value) ? Colors.pink : null,
                ),
              ),
              // like counts
              ValueListenableBuilder(
                  valueListenable: widget.likesCount,
                  builder: (context, value, child) {
                    return Text(widget.likesCount.value.toString());
                  }),
            ],
          );
        });
  }
}
