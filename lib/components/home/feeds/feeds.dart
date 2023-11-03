import 'package:flutter/material.dart';
import 'package:infoprofile_demo/components/home/feeds/post_layout.dart';
import 'package:infoprofile_demo/models/prefrences_settings_model.dart';
import 'package:infoprofile_demo/models/userfeeds_model.dart';
import 'package:infoprofile_demo/providers/home/feeds_provider.dart';
import 'package:infoprofile_demo/resources/colors.dart';
import 'package:infoprofile_demo/resources/fonts.dart';
import 'package:infoprofile_demo/resources/strings.dart';
import 'package:infoprofile_demo/utils/lottie_animation.dart';
import 'package:infoprofile_demo/viewmodels/home/feeds_viewmodel.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';

class Feeds extends StatefulWidget {
  final PrefrencesSettings prefrencesSettings;
  final Size screenSize;
  const Feeds(
      {super.key, required this.prefrencesSettings, required this.screenSize});

  @override
  State<Feeds> createState() => _FeedsState();
}

class _FeedsState extends State<Feeds> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final FeedsProvider feedsProvider = Provider.of(context, listen: false);
    final userData = widget.prefrencesSettings;
    return LiquidPullToRefresh(
      onRefresh: () async {
        setState(() {
          
        });
      },
      color: (Theme.of(context).brightness == Brightness.dark)
          ? AppColors.black
          : AppColors.white,
      backgroundColor: AppColors.grey,
      height: widget.screenSize.height * 0.08,
      showChildOpacityTransition: false,
      animSpeedFactor: 5,
      child: FutureBuilder(
        future: FeedsViewModel().userFeedsApiCall(
          accessToken: userData.accesstoken!,
          feedsProvider: feedsProvider,
          pageNo: 1,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Center(
                child: Text(AppStrings.hasError),
              );
            } else {
              UserFeedsModel feedsData = UserFeedsModel.fromJson(snapshot.data);
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
                      itemCount: feedsProvider.feedsList.length,
                      itemBuilder: (context, index) {
                        UserFeed currentFeed = feedsProvider.feedsList[index];
                        return PostLayout(
                          screenSize: widget.screenSize,
                          userData: currentFeed.userData,
                          postData: currentFeed.userPosts,
                          accessToken: userData.accesstoken!,
                        );
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
    );
  }
}
