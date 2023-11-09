import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:infoprofile_demo/components/home/drawer/profile_info.dart';
import 'package:infoprofile_demo/components/home/profile/buttons.dart';
import 'package:infoprofile_demo/models/getallusers_model.dart';
import 'package:infoprofile_demo/models/prefrences_settings_model.dart';
import 'package:infoprofile_demo/models/userposts_model.dart';
import 'package:infoprofile_demo/providers/home/user_provider.dart';
import 'package:infoprofile_demo/repository/home/user_repo.dart';

import 'package:infoprofile_demo/resources/colors.dart';
import 'package:infoprofile_demo/resources/routes.dart';
import 'package:infoprofile_demo/resources/strings.dart';

import 'package:infoprofile_demo/utils/utils.dart';
import 'package:infoprofile_demo/viewmodels/home/profile_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../models/userfeeds_model.dart';

class ProfileRoute extends StatefulWidget {
  final PrefrencesSettings prefrencesSettings;
  const ProfileRoute({super.key, required this.prefrencesSettings});

  @override
  State<ProfileRoute> createState() => _ProfileRouteState();
}

class _ProfileRouteState extends State<ProfileRoute>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final userData = widget.prefrencesSettings;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Consumer<UserProvider>(builder: (context, value, child) {
          return Text(
            (value.username == null)
                ? '@${userData.username}'
                : '@${value.username!}',
            style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppColors.white
                    : AppColors.black),
          );
        }),
      ),
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Column(
            children: [
              ProfileInfo(
                prefrencesSettings: userData,
                profileCallBack: () {},
                radius: 60,
              ),
              const SizedBox(
                height: 20,
              ),
              // buttons
              ProfileButtons(
                editProfile: () {
                  Navigator.pushNamed(context, Routes.updateProfile,
                      arguments: widget.prefrencesSettings);
                },
                share: () {
                  // share profile in pop-menu
                },
                discoverUsers: () async {
                  // suggestionlist
                  await showModalBottomSheet(
                    showDragHandle: true,
                    context: context,
                    builder: (context) {
                      return FutureBuilder(
                        future: UserRepository().getAllUsers(
                            accessToken:
                                widget.prefrencesSettings.accesstoken!),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.hasData) {
                              GetAllUsersModel getAllUsersModel =
                                  GetAllUsersModel.fromJson(snapshot.data);
                              List<Datum> data = getAllUsersModel.data;
                              return ListView.builder(
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  Datum currentUser = data[index];
                                  return InkWell(
                                    onTap: () {
                                      // open userprofile
                                      Navigator.pushNamed(
                                          context, Routes.userProfileView,
                                          arguments: {
                                            'param1': userData.accesstoken,
                                            'param2': currentUser.id,
                                            'param3': userData,
                                          });
                                    },
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        backgroundImage:
                                            (currentUser.profilePic.length < 2)
                                                ? null
                                                : CachedNetworkImageProvider(
                                                    currentUser.profilePic),
                                      ),
                                      title: Text(currentUser.fullName),
                                      subtitle:
                                          Text('@${currentUser.username}'),
                                    ),
                                  );
                                },
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
                    },
                  );
                },
              ),
              // buttons end
              // grid view,
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: FutureBuilder(
                    future: ProfileViewModel().userPostsApiCall(
                        accessToken: userData.accesstoken!,
                        userId: userData.userId!),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text(AppStrings.noPostsFound),
                          );
                        } else if (snapshot.hasData) {
                          UserPostsModel userPostsData =
                              UserPostsModel.fromJson(snapshot.data);
                          List<Post> postsList = userPostsData.data.posts;
                          return (postsList.isNotEmpty)
                              ? GridView.builder(
                                  cacheExtent: 1000,
                                  padding: EdgeInsets.zero,
                                  itemCount: postsList.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          mainAxisSpacing: 10,
                                          crossAxisSpacing: 10),
                                  itemBuilder: (context, index) {
                                    Post currentPost = postsList[index];
                                    return InkWell(
                                      onTap: () {
                                        UserPosts postData = UserPosts(
                                          id: currentPost.id,
                                          userId: currentPost.userId,
                                          url: currentPost.url,
                                          caption: currentPost.caption,
                                          likeCount: currentPost.likeCount,
                                          commentCount:
                                              currentPost.commentCount,
                                          createdAt: currentPost.createdAt,
                                          isLiked: false,
                                        );
                                        UserData postUserData = UserData(
                                          id: userData.userId!,
                                          username: userData.username!,
                                          email: userData.email!,
                                          profilePic: userData.profilePic!,
                                          fullName: userData.fullName!,
                                        );
                                        Navigator.pushNamed(
                                            context, Routes.postView,
                                            arguments: {
                                              'param1': postData,
                                              'param2': postUserData,
                                              'param3': userData,
                                            });
                                      },
                                      onLongPress: () {
                                        Utils.alertDialog(
                                          backgroundColor: AppColors.black,
                                          insetPadding:
                                              const EdgeInsets.all(40),
                                          contentPadding: EdgeInsets.zero,
                                          context: context,
                                          inputContent: AspectRatio(
                                            aspectRatio: 1,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: CachedNetworkImage(
                                                imageUrl: postsList[index].url,
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
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                imageUrl: postsList[index].url,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : const Center(
                                  child: Text("No Posts"),
                                );
                        } else {
                          return const Center(
                            child: Text("No Posts"),
                          );
                        }
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            color: (Theme.of(context).brightness ==
                                    Brightness.dark)
                                ? AppColors.white
                                : AppColors.black,
                          ),
                        );
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
