import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:infoprofile_demo/components/home/drawer/profile_info.dart';
import 'package:infoprofile_demo/components/home/profile/buttons.dart';
import 'package:infoprofile_demo/utils/utils.dart';

class ProfileRoute extends StatefulWidget {
  const ProfileRoute({super.key});

  @override
  State<ProfileRoute> createState() => _ProfileRouteState();
}

class _ProfileRouteState extends State<ProfileRoute> {
  @override
  Widget build(BuildContext context) {
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
                profileCallBack: (){},
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
                child: GridView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: 20,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onLongPress: () {
                        Utils.alertDialog(
                          context: context,
                          inputContent: CachedNetworkImage(
                            imageUrl: "https://picsum.photos/200/200",
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                      child: Card(
                        margin: EdgeInsets.zero,
                        child: Center(
                          child: CachedNetworkImage(
                            imageUrl: "https://picsum.photos/200/200",
                            fit: BoxFit.cover,
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
  }
}
