import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:infoprofile_demo/components/home/feeds/post_layout.dart';
import 'package:infoprofile_demo/models/user_model.dart';

import 'package:infoprofile_demo/resources/dummy_data.dart';

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
      appBar: AppBar(
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
