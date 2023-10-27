
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../resources/colors.dart';
import '../../../resources/fonts.dart';

class PostLayout extends StatefulWidget {
  final Size screenSize;
  final String name;
  final String username;
  final String caption;
  final String imageURL;
  const PostLayout(
      {super.key,
      required this.screenSize,
      required this.name,
      required this.username,
      required this.imageURL,
      this.caption = ""});

  @override
  State<PostLayout> createState() => _PostLayoutState();
}

class _PostLayoutState extends State<PostLayout> {
  bool isLiked = false;
  ValueNotifier<bool> islikeAnimation = ValueNotifier<bool>(false);
  TextOverflow? textOverflow = TextOverflow.ellipsis;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

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
              const CircleAvatar(
                radius: 24,
                backgroundImage: NetworkImage("https://picsum.photos/300/300"),
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
                        widget.name,
                        style: AppFonts.headerStyle(
                          fontWeight: FontWeight.bold,
                          context: context,
                        ),
                      ),
                      Text(
                        " - 8h",
                        style: AppFonts.headerStyle(
                            color: AppColors.grey, context: context),
                      ),
                    ],
                  ),
                  Text(
                    widget.username,
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
            width: widget.screenSize.width * 0.9,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  textOverflow = (textOverflow == TextOverflow.ellipsis)
                      ? null
                      : TextOverflow.ellipsis;
                });
              },
              child: Text(
                widget.caption,
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
              isLiked = !isLiked;
              islikeAnimation.value = !islikeAnimation.value;
              setState(() {});
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  CachedNetworkImage(
                    imageUrl: widget.imageURL,
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
              Row(
                children: [
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    onPressed: () {
                      //like
                      isLiked = !isLiked;
                      islikeAnimation.value = !islikeAnimation.value;
                      setState(() {});
                    },
                    icon: FaIcon(
                      (isLiked)
                          ? FontAwesomeIcons.solidHeart
                          : FontAwesomeIcons.heart,
                      size: 20,
                      color: (isLiked) ? Colors.pink : null,
                    ),
                  ),
                  // like counts
                  const Text("211"),
                ],
              ),
              //comments
              Row(
                children: [
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    onPressed: () {
                      //commentApi
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Column(
                              children: [
                                const SizedBox(
                                  height: 12,
                                ),
                                Divider(
                                  thickness: 5,
                                  indent: screenSize.width * 0.4,
                                  endIndent: screenSize.width * 0.4,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 12),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Comments:",
                                      style: AppFonts.headerStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                          context: context),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    padding:
                                        const EdgeInsets.symmetric(horizontal: 12),
                                    itemCount: 10,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        margin: const EdgeInsets.only(bottom: 10),
                                        height: 60,
                                        decoration: BoxDecoration(
                                            color: Colors.black26,
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            );
                          });
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.comment,
                      size: 20,
                    ),
                  ),
                  // comments counts
                  const Text("86"),
                ],
              ),
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
