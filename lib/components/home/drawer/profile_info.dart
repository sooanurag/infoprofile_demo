import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:infoprofile_demo/models/followers_model.dart';
import 'package:infoprofile_demo/models/following_model.dart';
import 'package:infoprofile_demo/models/prefrences_settings_model.dart';
import 'package:infoprofile_demo/providers/home/user_provider.dart';
import 'package:infoprofile_demo/resources/strings.dart';
import 'package:infoprofile_demo/services/prefrences_service.dart';
import 'package:infoprofile_demo/viewmodels/home/profile_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../resources/fonts.dart';

class ProfileInfo extends StatefulWidget {
  final bool? isDrawer;
  final double? radius;
  final VoidCallback profileCallBack;
  final PrefrencesSettings prefrencesSettings;
  const ProfileInfo({
    super.key,
    this.radius,
    this.isDrawer = false,
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
    return Consumer<UserProvider>(builder: (context, value, child) {
      return Align(
        alignment:
            (!widget.isDrawer!) ? Alignment.center : Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: (!widget.isDrawer!)
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
                onTap: widget.profileCallBack,
                child: (value.profilePicUrl == null)
                    ? CircleAvatar(
                        radius: widget.radius,
                        backgroundImage: (userData.profilePic == null ||
                                userData.profilePic!.length < 2)
                            ? null
                            : CachedNetworkImageProvider(userData.profilePic!),
                      )
                    : CircleAvatar(
                        radius: widget.radius,
                        backgroundImage:
                            CachedNetworkImageProvider(value.profilePicUrl!),
                      )),
            const SizedBox(
              height: 20,
            ),

            Text(
              (value.fullName == null)
                  ? userData.fullName ?? "N/A"
                  : value.fullName!,
              style: AppFonts.headerStyle(
                  fontWeight: FontWeight.bold, context: context),
            ),
            if (widget.isDrawer!)
              Text(
                (value.username == null)
                    ? '@${userData.username}'
                    : '@${value.username!}',
                style: AppFonts.headerStyle(
                  context: context,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey,
                ),
              ),

            if (!widget.isDrawer!)
              Text(
                (value.profileBio == null)
                    ? '# ${userData.profileBio!}'
                    : '# ${value.profileBio}',
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
              onTap: () async {
                // bottomsheet
                final userProvider =
                    Provider.of<UserProvider>(context, listen: false);
                showModalBottomSheet(
                  showDragHandle: true,
                  context: context,
                  builder: (context) {
                    return DefaultTabController(
                      length: 2,
                      child: Scaffold(
                        backgroundColor: Colors.transparent,
                        appBar: AppBar(
                          backgroundColor: Colors.transparent,
                          automaticallyImplyLeading: false,
                          title: const TabBar(tabs: [
                            Tab(
                              text: "Followers",
                            ),
                            Tab(
                              text: "Following",
                            )
                          ]),
                        ),
                        body: TabBarView(children: [
                          //tab1
                          FutureBuilder(
                            future: ProfileViewModel().getFollowers(
                              accessToken:
                                  widget.prefrencesSettings.accesstoken!,
                              userId: widget.prefrencesSettings.userId!,
                            ),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.hasData) {
                                  FollowersModel followersModel =
                                      FollowersModel.fromJson(snapshot.data);
                                  List<Follower> followerList =
                                      followersModel.data.followers;
                                  userProvider.setFollowersCount(
                                      count: followerList.length);
                                  PrefrenceService().savePrefrences(
                                      prefrencesSettings: PrefrencesSettings(
                                          followerCount: followerList.length));
                                  // debugPrint("length: ${followerList.length}");
                                  return (followerList.isNotEmpty)
                                      ? ListView.builder(
                                          itemCount: followerList.length,
                                          itemBuilder: (context, index) {
                                            Follower currentFollower =
                                                followerList[index];
                                            return ListTile(
                                              title: Text(currentFollower
                                                  .user.username),
                                              leading: CircleAvatar(
                                                backgroundImage: (currentFollower
                                                            .user
                                                            .profilePic
                                                            .length <
                                                        2)
                                                    ? null
                                                    : CachedNetworkImageProvider(
                                                        currentFollower
                                                            .user.profilePic,
                                                      ),
                                              ),
                                            );
                                          },
                                        )
                                      : const Center(
                                          child: Text("No Followers."),
                                        );
                                } else if (snapshot.hasError) {
                                  return const Center(
                                    child: Text(AppStrings.hasError),
                                  );
                                } else {
                                  return const Center(
                                    child: Text("No Follower."),
                                  );
                                }
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          ),
                          //tab2
                          FutureBuilder(
                            future: ProfileViewModel().getFollowing(
                              accessToken:
                                  widget.prefrencesSettings.accesstoken!,
                              userId: widget.prefrencesSettings.userId!,
                            ),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.hasData) {
                                  FollowingModel followingModel =
                                      FollowingModel.fromJson(snapshot.data);
                                  List<Following> followingList =
                                      followingModel.data.following;
                                  userProvider.setFollowingCount(
                                      count: followingList.length);
                                  PrefrenceService().savePrefrences(
                                      prefrencesSettings: PrefrencesSettings(
                                          followingCount:
                                              followingList.length));

                                  return (followingList.isNotEmpty)
                                      ? ListView.builder(
                                          itemCount: followingList.length,
                                          itemBuilder: (context, index) {
                                            Following currentFollowing =
                                                followingList[index];
                                            return ListTile(
                                              title: Text(currentFollowing
                                                  .user.username),
                                              leading: CircleAvatar(
                                                backgroundImage: (currentFollowing
                                                            .user
                                                            .profilePic
                                                            .length <
                                                        2)
                                                    ? null
                                                    : CachedNetworkImageProvider(
                                                        currentFollowing
                                                            .user.profilePic,
                                                      ),
                                              ),
                                            );
                                          },
                                        )
                                      : const Center(
                                          child: Text("No Following."),
                                        );
                                } else if (snapshot.hasError) {
                                  return const Center(
                                    child: Text(AppStrings.hasError),
                                  );
                                } else {
                                  return const Center(
                                    child: Text("No Following."),
                                  );
                                }
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          ),
                        ]),
                      ),
                    );
                  },
                );
              },
              child: RichText(
                text: TextSpan(
                    text: (value.followingCountt == null)
                        ? '${userData.followingCount}  '
                        : '${value.followingCountt}  ',
                    style: AppFonts.headerStyle(
                      context: context,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: "Following   ",
                        style: AppFonts.headerStyle(
                          context: context,
                          color: Colors.grey,
                        ),
                      ),
                      TextSpan(
                          text: (value.followerCount == null)
                              ? "${userData.followerCount}  "
                              : "${value.followerCount}  "),
                      TextSpan(
                        text: "Followers",
                        style: AppFonts.headerStyle(
                            color: Colors.grey, context: context),
                      ),
                    ]),
              ),
            ),
          ],
        ),
      );
    });
  }
}
