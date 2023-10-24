import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infoprofile_demo/components/home/drawer/profile_info.dart';
import 'package:infoprofile_demo/components/home/feeds/custom_floatingbutton.dart';

import 'package:infoprofile_demo/components/home/feeds/post_layout.dart';

import 'package:infoprofile_demo/models/user_model.dart';


import 'package:infoprofile_demo/resources/colors.dart';

import 'package:infoprofile_demo/resources/dummy_data.dart';
import 'package:infoprofile_demo/resources/fonts.dart';
import 'package:infoprofile_demo/resources/routes.dart';
import 'package:infoprofile_demo/resources/strings.dart';

import 'package:infoprofile_demo/utils/utils.dart';

import 'package:infoprofile_demo/viewmodels/home/feeds_viewmodel.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';


class FeedsRoute extends StatefulWidget {
  const FeedsRoute({super.key});

  @override
  State<FeedsRoute> createState() => _FeedsRouteState();
}

class _FeedsRouteState extends State<FeedsRoute> {
  

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      drawer: Drawer(
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                ProfileInfo(
                  screenSize: screenSize,
                  profileCallBack: () {
                    Navigator.pushNamed(context, Routes.profile);
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
                          child: const CircleAvatar(
                            backgroundImage: CachedNetworkImageProvider(
                                "https://picsum.photos/200/200"),
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
            onRefresh: FeedsViewModel.feedsRefreshHandler,
            color: (Theme.of(context).brightness == Brightness.dark)
                ? AppColors.black
                : AppColors.white,
            backgroundColor: AppColors.grey,
            height: screenSize.height * 0.08,
            showChildOpacityTransition: false,
            animSpeedFactor: 5,
            child: ListView.builder(
              itemCount: DummyData.users.length,
              itemBuilder: (context, index) {
                UserModel userData = DummyData.users[index];
                return PostLayout(
                  screenSize: screenSize,
                  name: userData.fullName.toString(),
                  username: userData.username.toString(),
                  imageURL: userData.profilePicture!,
                  caption:
                      "This is sample text, only for preview. this is sample text, onluy for preview purposes. This is only sample data.#ajfnakjf #fjnakjf",
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: const CustomFloatingButton(),
    );
  }
}
