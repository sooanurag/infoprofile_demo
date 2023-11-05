import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infoprofile_demo/components/home/feeds/posts/comments_button.dart';
import 'package:infoprofile_demo/components/home/feeds/posts/like_button.dart';
import 'package:infoprofile_demo/models/prefrences_settings_model.dart';
import 'package:infoprofile_demo/viewmodels/home/posts_viewmodel.dart';
import 'package:intl/intl.dart';

import '../../../models/userfeeds_model.dart';
import '../../../resources/colors.dart';
import '../../../resources/fonts.dart';

class PostLayout extends StatefulWidget {
  // final Size screenSize;
  final PrefrencesSettings prefrencesSettings;
  final UserPosts postData;
  final UserData userData;
  final String accessToken;
  const PostLayout({
    super.key,
    // required this.screenSize,
    required this.prefrencesSettings,
    required this.userData,
    required this.postData,
    required this.accessToken,
  });

  @override
  State<PostLayout> createState() => _PostLayoutState();
}

class _PostLayoutState extends State<PostLayout> {
  ValueNotifier<bool> islikeAnimation = ValueNotifier<bool>(false);

  TextOverflow? textOverflow = TextOverflow.ellipsis;
  @override
  Widget build(BuildContext context) {
    debugPrint("layout buidcall");
    ValueNotifier<bool> isLiked = ValueNotifier<bool>(widget.postData.isLiked);
    ValueNotifier<int> likesCount =
        ValueNotifier<int>(widget.postData.likeCount);
    String? min;
    String? hours;
    String? beforeYesterday;
    String? lastYearPost;
    bool isYesterday = false;
    if (widget.postData.createdAt.day == DateTime.now().day) {
      if (widget.postData.createdAt.hour == DateTime.now().hour) {
        int minTemp = DateTime.now().minute - widget.postData.createdAt.minute;
        min = "${minTemp.toString()} mins ago";
      } else {
        min = null;
        int hoursTemp = DateTime.now().hour - widget.postData.createdAt.hour;
        if (hoursTemp > 23) {
          isYesterday = true;
        } else {
          hours = "${hoursTemp.toString()} hr ago";
        }
      }
    } else if (widget.postData.createdAt.year == DateTime.now().year) {
      min = null;
      hours = null;
      beforeYesterday = DateFormat("dd MMMM").format(widget.postData.createdAt);
    } else {
      min = null;
      lastYearPost =
          DateFormat("dd MMMM yyyy").format(widget.postData.createdAt);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundImage: (widget.userData.profilePic.length > 2)
                    ? NetworkImage(widget.userData.profilePic)
                    : null,
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        widget.userData.fullName,
                        style: AppFonts.headerStyle(
                          fontWeight: FontWeight.bold,
                          context: context,
                        ),
                      ),
                      Text(
                        " - ${min ?? hours ?? ((isYesterday) ? "Yesterday" : beforeYesterday ?? lastYearPost!)}",
                        style: AppFonts.headerStyle(
                            color: AppColors.grey, context: context),
                      ),
                    ],
                  ),
                  Text(
                    widget.userData.username,
                    style: AppFonts.headerStyle(
                        context: context,
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                visualDensity: VisualDensity.compact,
                padding: EdgeInsets.zero,
                onPressed: () {
                  // open bottom-sheet for opr
                },
                icon: FaIcon(
                  FontAwesomeIcons.ellipsisVertical,
                  size: 18,
                  color: AppColors.grey,
                ),
              )
            ],
          ),

          const SizedBox(
            height: 10,
          ),
          //caption
          SizedBox(
            // width: widget.screenSize.width * 0.9,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  textOverflow = (textOverflow == TextOverflow.ellipsis)
                      ? null
                      : TextOverflow.ellipsis;
                });
              },
              child: Text(
                (widget.postData.caption.length > 2)
                    ? "- ${widget.postData.caption}"
                    : widget.postData.caption,
                maxLines: (textOverflow == TextOverflow.ellipsis) ? 1 : null,
                overflow: textOverflow,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          // image
          GestureDetector(
            onDoubleTap: () {
              isLiked.value = !isLiked.value;
              islikeAnimation.value = !islikeAnimation.value;
              (isLiked.value) ? likesCount.value++ : likesCount.value--;
              widget.postData.isLiked = isLiked.value;
              widget.postData.likeCount = likesCount.value;
              (isLiked.value)
                  ? PostsViewModel().likeApiCall(
                      accessToken: widget.accessToken,
                      postId: widget.postData.id,
                    )
                  : PostsViewModel().disLikeApiCall(
                      accessToken: widget.accessToken,
                      postId: widget.postData.id,
                    );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: CachedNetworkImage(
                      imageUrl: widget.postData.url,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned.fill(
                    child: Center(
                      child: ValueListenableBuilder(
                          valueListenable: islikeAnimation,
                          builder: (context, value, child) {
                            return (islikeAnimation.value)
                                ? const FaIcon(
                                    FontAwesomeIcons.solidHeart,
                                    size: 80,
                                    shadows: [Shadow(blurRadius: 1)],
                                  )
                                    .animate()
                                    .scale(curve: Curves.easeIn)
                                    .then()
                                    .animate(
                                        delay:
                                            const Duration(milliseconds: 400))
                                    .fadeOut()
                                : Container();
                          }),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),

          //buttons
          Row(
            children: [
              // likes
              LikeButton(
                postData: widget.postData,
                isLiked: isLiked,
                likesCount: likesCount,
                islikeAnimation: islikeAnimation,
                accessToken: widget.accessToken,
                postId: widget.postData.id,
              ),
              //comments
              CommentsButton(
                prefrencesSettings: widget.prefrencesSettings,
                  accessToken: widget.accessToken, postData: widget.postData),
              //share button
              IconButton(
                visualDensity: VisualDensity.compact,
                onPressed: () {
                  //like
                },
                icon: const Icon(
                  Icons.share_outlined,
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
