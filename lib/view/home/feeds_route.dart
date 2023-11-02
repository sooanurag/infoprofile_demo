import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infoprofile_demo/components/home/drawer/profile_info.dart';
import 'package:infoprofile_demo/components/home/feeds/custom_floatingbutton.dart';
import 'package:infoprofile_demo/models/userfeeds_model.dart';

import 'package:infoprofile_demo/resources/colors.dart';

import 'package:infoprofile_demo/resources/fonts.dart';
import 'package:infoprofile_demo/resources/routes.dart';
import 'package:infoprofile_demo/resources/strings.dart';

import 'package:infoprofile_demo/services/prefrences_service.dart';
import 'package:infoprofile_demo/utils/lottie_animation.dart';

import 'package:infoprofile_demo/utils/utils.dart';

import 'package:infoprofile_demo/viewmodels/home/feeds_viewmodel.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../models/prefrences_settings_model.dart';

class FeedsRoute extends StatefulWidget {
  final PrefrencesSettings prefrencesSettings;
  const FeedsRoute({
    super.key,
    required this.prefrencesSettings,
  });

  @override
  State<FeedsRoute> createState() => _FeedsRouteState();
}

class _FeedsRouteState extends State<FeedsRoute> {
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    int pageNo = 1;
    PrefrencesSettings userData = widget.prefrencesSettings;
    return Scaffold(
      drawer: Drawer(
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                ProfileInfo(
                  prefrencesSettings: userData,
                  screenSize: screenSize,
                  profileCallBack: () {
                    Navigator.pushNamed(context, Routes.profile,
                        arguments: userData);
                  },
                ),
                Divider(
                  color: Colors.grey,
                  thickness: 1,
                  height: screenSize.height * 0.04,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: AppStrings.drawerTilesTitles.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          if (index == 0) {
                            Navigator.pushNamed(context, Routes.profile);
                          }
                        },
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: FaIcon(
                            Utils.drawerTileIcons[index],
                            color: (Theme.of(context).brightness ==
                                    Brightness.dark)
                                ? AppColors.white
                                : AppColors.black,
                            size: screenSize.height * 0.02,
                          ),
                          title: Text(
                            AppStrings.drawerTilesTitles[index],
                            style: AppFonts.headerStyle(
                              context: context,
                              fontWeight: FontWeight.bold,
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
      ),
      body: SafeArea(
        bottom: false,
        child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                floating: true,
                snap: true,
                leadingWidth: screenSize.width * 0.1,
                centerTitle: false,
                leading: Builder(
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: GestureDetector(
                          onTap: () {
                            Scaffold.of(context).openDrawer();
                          },
                          child: CircleAvatar(
                            backgroundImage: (userData.profilePic == null ||
                                    userData.profilePic!.length < 2)
                                ? null
                                : CachedNetworkImageProvider(
                                    userData.profilePic!),
                          )),
                    );
                  },
                ),
                title: Utils.infoprofileTypo(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                    context: context),
                actions: [
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.search);
                    },
                    icon: const Icon(Icons.search_outlined),
                  ),
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.notification);
                    },
                    icon: const Icon(Icons.notifications_outlined),
                  ),
                ],
              ),
            ];
          },
          body: LiquidPullToRefresh(
            onRefresh: () async {
              Future.delayed(const Duration(seconds: 1));
            },
            color: (Theme.of(context).brightness == Brightness.dark)
                ? AppColors.black
                : AppColors.white,
            backgroundColor: AppColors.grey,
            height: screenSize.height * 0.08,
            showChildOpacityTransition: false,
            animSpeedFactor: 5,
            child: FutureBuilder(
              future: FeedsViewModel().userFeedsApiCall(
                accessToken: userData.accesstoken!,
                pageNo: 1,
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text(AppStrings.hasError),
                    );
                  } else {
                    debugPrint(snapshot.data.toString());
                    UserFeedsModel feedsData =
                        UserFeedsModel.fromJson(snapshot.data);
                    List<UserFeed> feedsList = feedsData.userFeed;
                    return (feedsList.isEmpty)
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 80,
                                    child: (Theme.of(context).brightness ==
                                            Brightness.dark)
                                        ? LottieAnimations.followWhite
                                        : LottieAnimations.followBlack,
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Text(
                                    "Add Friends",
                                    style: AppFonts.headerStyle(
                                        context: context,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemCount: feedsList.length,
                            itemBuilder: (context, index) {
                              return Container();
                            },
                          );
                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ),
      ),
      floatingActionButton: const CustomFloatingButton(),
    );
  }
}
