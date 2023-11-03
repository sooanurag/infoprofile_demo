import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infoprofile_demo/components/home/drawer/profile_info.dart';
import 'package:infoprofile_demo/components/home/feeds/custom_floatingbutton.dart';
import 'package:infoprofile_demo/components/home/feeds/feeds.dart';
import 'package:infoprofile_demo/resources/colors.dart';

import 'package:infoprofile_demo/resources/fonts.dart';
import 'package:infoprofile_demo/resources/routes.dart';
import 'package:infoprofile_demo/resources/strings.dart';
import 'package:infoprofile_demo/utils/utils.dart';

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
                            Navigator.pushNamed(context, Routes.profile,
                                arguments: widget.prefrencesSettings);
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
                      Navigator.pushNamed(context, Routes.search,
                          arguments: widget.prefrencesSettings);
                    },
                    icon: const Icon(Icons.search_outlined),
                  ),
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.notification,
                          arguments: widget.prefrencesSettings);
                    },
                    icon: const Icon(Icons.notifications_outlined),
                  ),
                ],
              ),
            ];
          },
          body: Feeds(
            prefrencesSettings: userData,
            screenSize: screenSize,
          ),
        ),
      ),
      floatingActionButton: CustomFloatingButton(prefrencesSettings: userData),
    );
  }
}
