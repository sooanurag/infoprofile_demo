import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infoprofile_demo/components/home/drawer/profile_info.dart';
import 'package:infoprofile_demo/components/home/feeds/custom_floatingbutton.dart';
import 'package:infoprofile_demo/components/home/feeds/feeds.dart';
import 'package:infoprofile_demo/providers/home/user_provider.dart';
import 'package:infoprofile_demo/resources/colors.dart';

import 'package:infoprofile_demo/resources/fonts.dart';
import 'package:infoprofile_demo/resources/routes.dart';
import 'package:infoprofile_demo/resources/strings.dart';
import 'package:infoprofile_demo/services/prefrences_service.dart';
import 'package:infoprofile_demo/utils/utils.dart';
import 'package:infoprofile_demo/viewmodels/home/feeds_viewmodel.dart';
import 'package:provider/provider.dart';

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
                  isDrawer: true,
                  prefrencesSettings: userData,
                  radius: 40,
                  profileCallBack: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, Routes.profile,
                        arguments: userData);
                  },
                ),
                const Divider(
                  color: Colors.grey,
                  thickness: 1,
                  height: 30,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: AppStrings.drawerTilesTitles.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () async {
                          if (index == 0) {
                            Navigator.pushNamed(context, Routes.profile,
                                arguments: widget.prefrencesSettings);
                          }
                          if (index ==
                              AppStrings.drawerTilesTitles.length - 1) {
                            await FeedsViewModel()
                                .logOut(accessToken: userData.accesstoken!);
                            PrefrenceService().deletePrefrences();
                            if (mounted) {
                              Navigator.popUntil(
                                  context, (route) => route.isFirst);
                              Navigator.pushReplacementNamed(
                                  context, Routes.getstarted);
                            }
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
                          ),
                          title: Text(
                            AppStrings.drawerTilesTitles[index],
                            style: AppFonts.headerStyle(
                              context: context,
                              fontWeight: FontWeight.w600,
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
                leadingWidth: 44,
                centerTitle: false,
                leading: Builder(
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: GestureDetector(onTap: () {
                        Scaffold.of(context).openDrawer();
                      }, child: Consumer<UserProvider>(
                          builder: (context, value, child) {
                        return (value.profilePicUrl == null)
                            ? CircleAvatar(
                                backgroundImage: (userData.profilePic == null ||
                                        userData.profilePic!.length < 2)
                                    ? null
                                    : CachedNetworkImageProvider(
                                        userData.profilePic!),
                              )
                            : CircleAvatar(
                                backgroundImage: CachedNetworkImageProvider(
                                    value.profilePicUrl!),
                              );
                      })),
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
          body: Feeds(prefrencesSettings: userData),
        ),
      ),
      floatingActionButton: CustomFloatingButton(prefrencesSettings: userData),
    );
  }
}
