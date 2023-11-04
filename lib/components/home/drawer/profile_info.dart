import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infoprofile_demo/models/prefrences_settings_model.dart';

import '../../../resources/fonts.dart';

class ProfileInfo extends StatefulWidget {
  // final Size screenSize;
  final double? radius;
  final VoidCallback profileCallBack;
  final PrefrencesSettings prefrencesSettings;
  const ProfileInfo({
    super.key,
    // required this.screenSize,
    this.radius,
    required this.profileCallBack,
    required this.prefrencesSettings,
  });

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  @override
  Widget build(BuildContext context) {
    final userData = widget.prefrencesSettings;
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
                radius: widget.radius,
                backgroundImage: (userData.profilePic == null ||
                        userData.profilePic!.length < 2)
                    ? null
                    : CachedNetworkImageProvider(userData.profilePic!),
              ),
            ),
            IconButton(
                visualDensity: VisualDensity.compact,
                onPressed: () {
                  // bottomsheet
                },
                icon: const FaIcon(
                  FontAwesomeIcons.ellipsisVertical,
                  size: 18,
                ))
          ],
        ),
        const SizedBox(
          height: 20,
        ),

        Text(
          userData.fullName ?? "N/A",
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
        const SizedBox(
          height: 10,
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
                  fontSize: 14,
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
