import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:infoprofile_demo/components/home/profile/searched_userprofile.dart';
import 'package:infoprofile_demo/models/prefrences_settings_model.dart';
import 'package:infoprofile_demo/models/searched_userprofile_model.dart';
import 'package:infoprofile_demo/providers/home/search_provider.dart';
import 'package:infoprofile_demo/resources/strings.dart';
import 'package:infoprofile_demo/viewmodels/home/search_viewmodel.dart';
import 'package:provider/provider.dart';
import '../../components/home/profile/buttons.dart';
import '../../models/userfeeds_model.dart';
import '../../resources/colors.dart';
import '../../resources/routes.dart';
import '../../utils/utils.dart';
import '../../viewmodels/home/notifications_viewmodel.dart';

class SearchUserProfileRoute extends StatefulWidget {
  final String accessToken;
  final String userId;
  final PrefrencesSettings prefrencesSettings;
  const SearchUserProfileRoute({
    super.key,
    required this.prefrencesSettings,
    required this.accessToken,
    required this.userId,
  });

  @override
  State<SearchUserProfileRoute> createState() => _SearchUserProfileRouteState();
}

class _SearchUserProfileRouteState extends State<SearchUserProfileRoute> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SearchViewModel().getUserProfile(
          accessToken: widget.accessToken, userId: widget.userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            SearchUserProfileModel searchUserProfileModel =
                SearchUserProfileModel.fromJson(snapshot.data);
            UserPofile userPofileData =
                searchUserProfileModel.data.userPofile[0];
            final SearchProvider searchProvider =
                Provider.of<SearchProvider>(context, listen: false);
            Future.delayed(
                Duration.zero,
                () => searchProvider.setFollowStatsu(
                    status:
                        userPofileData.isFollowing ? 'Unfollow' : 'Follow'));

            return Scaffold(
              appBar: AppBar(
                title: Text(
                  userPofileData.username,
                  style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppColors.white
                          : AppColors.black),
                ),
              ),
              body: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: Column(
                    children: [
                      SearchedProfileInfo(
                        accessToken: widget.accessToken,
                        searchedUserId: widget.userId,
                        userPofileData: userPofileData,
                        radius: 60,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // buttons
                      Consumer<SearchProvider>(
                          builder: (context, value, child) {
                        return ProfileButtons(
                          buttonOneTitle: value.followStatus,
                          editProfile: () async {
                            //follow
                            (value.followStatus == 'Follow')
                                ? await SearchViewModel().followUser(
                                    searchProvider: value,
                                    accessToken: widget.accessToken,
                                    followingId: widget.userId)
                                : await SearchViewModel().unFollowUser(
                                    searchProvider: value,
                                    accessToken: widget.accessToken,
                                    followingId: widget.userId);
                            if (value.followStatus == 'Unfollow') {
                              await NotificationsViewModel().addNotification(
                                accessToken: widget.accessToken,
                                postUserId: widget.userId,
                                postId: widget.userId,
                                type: 'FOLLOW_USER',
                              );
                            }
                          },
                          share: () {
                            // share profile in pop-menu
                          },
                          discoverUsers: () {
                            // suggestionlist
                          },
                        );
                      }),
                      // buttons end
                      // grid view,
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: GridView.builder(
                          cacheExtent: 1000,
                          padding: EdgeInsets.zero,
                          itemCount: userPofileData.userPosts.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10),
                          itemBuilder: (context, index) {
                            UserPost currentPost =
                                userPofileData.userPosts[index];
                            return InkWell(
                              onTap: () {
                                UserPosts postData = UserPosts(
                                  id: currentPost.id,
                                  userId: currentPost.userId,
                                  url: currentPost.url,
                                  caption: currentPost.caption,
                                  likeCount: currentPost.likeCount,
                                  commentCount: currentPost.commentCount,
                                  createdAt: currentPost.createdAt,
                                  isLiked: false,
                                );
                                UserData postUserData = UserData(
                                  id: widget.userId,
                                  username: userPofileData.username,
                                  email: userPofileData.email,
                                  profilePic: userPofileData.profilePic,
                                  fullName: userPofileData.fullName,
                                );
                                Navigator.pushNamed(context, Routes.postView,
                                    arguments: {
                                      'param1': postData,
                                      'param2': postUserData,
                                      'param3': widget.prefrencesSettings,
                                    });
                              },
                              onLongPress: () {
                                Utils.alertDialog(
                                  backgroundColor: AppColors.black,
                                  insetPadding: const EdgeInsets.all(40),
                                  contentPadding: EdgeInsets.zero,
                                  context: context,
                                  inputContent: AspectRatio(
                                    aspectRatio: 1,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: CachedNetworkImage(
                                        imageUrl: currentPost.url,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: Card(
                                margin: EdgeInsets.zero,
                                child: Center(
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl: currentPost.url,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Center(
              child: Text(AppStrings.hasError),
            );
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
