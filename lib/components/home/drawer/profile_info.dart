import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infoprofile_demo/providers/home/user_provider.dart';

import '../../../resources/fonts.dart';

class ProfileInfo extends StatefulWidget {
  final Size screenSize;
  final double? radius;
  final VoidCallback profileCallBack;
  final UserProvider userProvider;
  const ProfileInfo({
    super.key,
    required this.screenSize,
    this.radius,
    required this.profileCallBack,
    required this.userProvider,
  });

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  @override
  Widget build(BuildContext context) {
    final userData = widget.userProvider.userData;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // profile and burger
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: widget.profileCallBack,
              child: CircleAvatar(
                radius: widget.radius ?? widget.screenSize.width * 0.08,
                backgroundImage: (userData.profilePic==null || userData.profilePic!.isEmpty)? null: CachedNetworkImageProvider(userData.profilePic!),
              ),
            ),
            IconButton(
                visualDensity: VisualDensity.compact,
                onPressed: () {
                  // bottomsheet
                },
                icon: FaIcon(
                  FontAwesomeIcons.ellipsisVertical,
                  size: widget.screenSize.height * 0.02,
                ))
          ],
        ),
        SizedBox(
          height: widget.screenSize.height * 0.015,
        ),
        //fullname - ** provider missing
        Text(
          userData.fullName??"N/A",
          style: AppFonts.headerStyle(
              fontWeight: FontWeight.bold, context: context),
        ),
        Text(
          '@${userData.username}',
          style: AppFonts.headerStyle(
            context: context,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.italic,
            color: Colors.grey,
          ),
        ),
        SizedBox(
          height: widget.screenSize.height * 0.01,
        ),
        // follower-following
        InkWell(
          onTap: () {
            // bottomsheet
          },
          child: RichText(
            text: TextSpan(
                text: '${userData.followingCount} ',
                style: AppFonts.headerStyle(
                  context: context,
                  fontWeight: FontWeight.bold,
                  fontSize: widget.screenSize.height * 0.015,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: "Following  ",
                    style: AppFonts.headerStyle(
                      context: context,
                      color: Colors.grey,
                    ),
                  ),
                   TextSpan(text: "${userData.followerCount} "),
                  TextSpan(
                    text: "Followers",
                    style: AppFonts.headerStyle(
                        color: Colors.grey, context: context),
                  ),
                ]),
          ),
        ),
      ],
    );
  }
}
