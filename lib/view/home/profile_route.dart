import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:infoprofile_demo/components/home/drawer/profile_info.dart';
import 'package:infoprofile_demo/components/home/profile/buttons.dart';
import 'package:infoprofile_demo/models/userposts_model.dart';
import 'package:infoprofile_demo/providers/home/user_provider.dart';
import 'package:infoprofile_demo/resources/colors.dart';
import 'package:infoprofile_demo/resources/strings.dart';
import 'package:infoprofile_demo/utils/utils.dart';
import 'package:infoprofile_demo/viewmodels/home/profile_viewmodel.dart';
import 'package:provider/provider.dart';

class ProfileRoute extends StatefulWidget {
  const ProfileRoute({super.key});

  @override
  State<ProfileRoute> createState() => _ProfileRouteState();
}

class _ProfileRouteState extends State<ProfileRoute> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final userData = userProvider.userData;
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Column(
            children: [
              ProfileInfo(
                userProvider: userProvider,
                profileCallBack: () {},
                radius: screenSize.width * 0.1,
                screenSize: screenSize,
              ),
              const SizedBox(
                height: 20,
              ),
              // buttons
              ProfileButtons(
                  editProfile: () {},
                  share: () {},
                  discoverUsers: () {},
                  screenSize: screenSize),
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
                        } else {
                          //print
                          debugPrint('post data: ${snapshot.data.toString()}');
                          UserPostsModel userPostsData =
                              UserPostsModel.fromJson(snapshot.data);
                          List<Post> postsList = userPostsData.data.posts;
                          return GridView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: postsList.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10),
                            itemBuilder: (context, index) {
                              return InkWell(
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
                                        borderRadius: BorderRadius.circular(12),
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
