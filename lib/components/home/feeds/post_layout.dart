import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
  TextOverflow? textOverflow = TextOverflow.ellipsis;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //profilePic
          const CircleAvatar(
            backgroundImage: NetworkImage("https://picsum.photos/300/300"),
          ),
          const SizedBox(
            width: 10,
          ),
          //content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.name,
                          style: AppFonts.headerStyle(
                              fontWeight: FontWeight.bold, context: context),
                        ),
                        Text(
                          " - 8h",
                          style: AppFonts.headerStyle(
                              color: AppColors.grey, context: context),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 18,
                      width: 8,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          // open bottom-sheet for opr
                        },
                        icon: FaIcon(
                          FontAwesomeIcons.ellipsisVertical,
                          size: 18,
                          color: AppColors.grey,
                        ),
                      ),
                    )
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
                const SizedBox(
                  height: 5,
                ),
                //caption
                SizedBox(
                  width: widget.screenSize.width * 0.8,
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
                      maxLines:
                          (textOverflow == TextOverflow.ellipsis) ? 1 : null,
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
                    setState(() {});
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                      imageUrl: widget.imageURL,
                    ),
                  ),
                ),

                //buttons
                Row(
                  children: [
                    // likes
                    Row(
                      children: [
                        SizedBox(
                          width: 35,
                          child: IconButton(
                            onPressed: () {
                              //like
                              isLiked = !isLiked;
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
                        ),
                        // like counts
                        const Text("211"),
                      ],
                    ),
                    //comments
                    Row(
                      children: [
                        SizedBox(
                          width: 35,
                          child: IconButton(
                            onPressed: () {
                              //like
                            },
                            icon: const FaIcon(
                              FontAwesomeIcons.comment,
                              size: 20,
                            ),
                          ),
                        ),
                        // comments counts
                        const Text("86"),
                      ],
                    ),
                    //share button
                    SizedBox(
                      width: 35,
                      child: IconButton(
                        onPressed: () {
                          //like
                        },
                        icon: const Icon(
                          Icons.share_outlined,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
