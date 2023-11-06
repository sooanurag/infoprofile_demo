import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:infoprofile_demo/models/followers_model.dart';
import 'package:infoprofile_demo/models/following_model.dart';
import 'package:infoprofile_demo/resources/strings.dart';

import 'package:infoprofile_demo/viewmodels/home/profile_viewmodel.dart';

import '../../../models/searched_userprofile_model.dart';
import '../../../resources/fonts.dart';

class SearchedProfileInfo extends StatefulWidget {
  final double? radius;
  final UserPofile userPofileData;
  final String accessToken;
  final String searchedUserId;
  const SearchedProfileInfo({
    super.key,
    this.radius,
    required this.searchedUserId,
    required this.accessToken,
    required this.userPofileData,
  });

  @override
  State<SearchedProfileInfo> createState() => _SearchedProfileInfoState();
}

class _SearchedProfileInfoState extends State<SearchedProfileInfo> {
  @override
  Widget build(BuildContext context) {
    final userData = widget.userPofileData;
    return Align(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
              onLongPress: () {
                // profile dialog
              },
              child: CircleAvatar(
                radius: widget.radius,
                backgroundImage: (userData.profilePic.length < 2)
                    ? null
                    : CachedNetworkImageProvider(userData.profilePic),
              )),
          const SizedBox(
            height: 20,
          ),

          Text(
            (userData.fullName.length < 2) ? "N/A" : userData.fullName,
            style: AppFonts.headerStyle(
                fontWeight: FontWeight.bold, context: context),
          ),

          Text(
            (userData.profileBio.length > 2)
                ? '# ${userData.profileBio}'
                : '#_none',
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
                            accessToken: widget.accessToken,
                            userId: widget.searchedUserId,
                          ),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.hasData) {
                                FollowersModel followersModel =
                                    FollowersModel.fromJson(snapshot.data);
                                List<Follower> followerList =
                                    followersModel.data.followers;

                                return (followerList.isNotEmpty)
                                    ? ListView.builder(
                                        itemCount: followerList.length,
                                        itemBuilder: (context, index) {
                                          Follower currentFollower =
                                              followerList[index];
                                          return ListTile(
                                            title: Text(
                                                currentFollower.user.username),
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
                            accessToken: widget.accessToken,
                            userId: widget.searchedUserId,
                          ),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.hasData) {
                                FollowingModel followingModel =
                                    FollowingModel.fromJson(snapshot.data);
                                List<Following> followingList =
                                    followingModel.data.following;

                                return (followingList.isNotEmpty)
                                    ? ListView.builder(
                                        itemCount: followingList.length,
                                        itemBuilder: (context, index) {
                                          Following currentFollowing =
                                              followingList[index];
                                          return ListTile(
                                            title: Text(
                                                currentFollowing.user.username),
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
                  text: '${userData.followingCount}  ',
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
                      text: "${userData.followerCount}  ",
                    ),
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
  }
}
