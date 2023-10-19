import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infoprofile_demo/resources/colors.dart';

import '../../../resources/fonts.dart';

class ProfileInfo extends StatefulWidget {
  final Size screenSize;
  final double? radius;
  final VoidCallback profileCallBack;
  const ProfileInfo({super.key, required this.screenSize, this.radius,required this.profileCallBack});

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  @override
  Widget build(BuildContext context) {
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
          "Anurag Gupta",
          style: AppFonts.headerStyle(fontWeight: FontWeight.bold,context: context),
        ),
        Text(
          "@username",
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
                text: "719 ",
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
                  const TextSpan(text: "0 "),
                  TextSpan(
                    text: "Followers",
                    style: AppFonts.headerStyle(color: Colors.grey,context: context),
                  ),
                ]),
          ),
        ),
      ],
    );
  }
}
