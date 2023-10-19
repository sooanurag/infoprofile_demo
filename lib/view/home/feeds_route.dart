import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infoprofile_demo/components/home/drawer/profile_info.dart';

import 'package:infoprofile_demo/components/home/feeds/post_layout.dart';
import 'package:infoprofile_demo/models/user_model.dart';
import 'package:infoprofile_demo/resources/colors.dart';

import 'package:infoprofile_demo/resources/dummy_data.dart';
import 'package:infoprofile_demo/resources/fonts.dart';
import 'package:infoprofile_demo/resources/strings.dart';

import 'package:infoprofile_demo/utils/glassmorph_container.dart';
import 'package:infoprofile_demo/utils/utils.dart';

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
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ProfileInfo(screenSize: screenSize),
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
                        onTap: () {},
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: FaIcon(
                            Utils.drawerTileIcons[index],
                            color: AppColors.white,
                            size: screenSize.height * 0.02,
                          ),
                          title: Text(
                            AppStrings.drawerTilesTitles[index],
                            style: AppFonts.headerStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.white,
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
      appBar: AppBar(
        leadingWidth: screenSize.width * 0.08,
        leading: Builder(
          builder: (context) {
            return GestureDetector(
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                child: const CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(
                      "https://picsum.photos/200/200"),
                ));
          },
        ),
        centerTitle: false,
        title: Utils.infoprofileTypo(fontWeight: FontWeight.w600, fontSize: 22),
        actions: [
          IconButton(
            visualDensity: VisualDensity.compact,
            onPressed: () {},
            icon: const Icon(Icons.search_outlined),
          ),
          IconButton(
            visualDensity: VisualDensity.compact,
            onPressed: () {},
            icon: const Icon(Icons.notifications_outlined),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: DummyData.users.length,
        itemBuilder: (context, index) {
          UserModel userData = DummyData.users[index];
          return PostLayout(
            screenSize: screenSize,
            name: userData.fullName.toString(),
            username: userData.username.toString(),
            caption:
                "This is sample text, only for preview. this is sample text, onluy for preview purposes. This is only sample data.#ajfnakjf #fjnakjf",
          );
        },
      ),
      floatingActionButton: const GlassmorphContainer(
          hzMargin: 0,
          color: Colors.grey,
          child: Icon(
            Icons.add,
            size: 24,
          )),
    );
  }
}
