import 'package:flutter/material.dart';
import 'package:infoprofile_demo/components/home/feeds/post_layout.dart';
import 'package:infoprofile_demo/models/prefrences_settings_model.dart';
import 'package:infoprofile_demo/resources/colors.dart';

import '../../models/userfeeds_model.dart';

class PostViewRoute extends StatefulWidget {
  final PrefrencesSettings prefrencesSettings;
  final UserData postUserData;
  final UserPosts postData;
  const PostViewRoute({
    super.key,
    required this.postData,
    required this.postUserData,
    required this.prefrencesSettings,
  });

  @override
  State<PostViewRoute> createState() => _PostViewRouteState();
}

class _PostViewRouteState extends State<PostViewRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Post",
          style: TextStyle(
              color: (Theme.of(context).brightness == Brightness.dark)
                  ? AppColors.white
                  : AppColors.black),
        ),
      ),
      body: SafeArea(
          child: Center(
        child: PostLayout(
            prefrencesSettings: widget.prefrencesSettings,
            postUserData: widget.postUserData,
            postData: widget.postData,
            accessToken: widget.prefrencesSettings.accesstoken!),
      )),
    );
  }
}
