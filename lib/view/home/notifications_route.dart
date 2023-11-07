import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infoprofile_demo/models/prefrences_settings_model.dart';
import 'package:infoprofile_demo/resources/colors.dart';
import 'package:infoprofile_demo/resources/fonts.dart';
import 'package:infoprofile_demo/resources/strings.dart';
import 'package:infoprofile_demo/utils/glassmorph_container.dart';
import 'package:infoprofile_demo/viewmodels/home/notifications_viewmodel.dart';

import '../../models/notifications_model.dart';

class NotificationsRoute extends StatefulWidget {
  final PrefrencesSettings prefrencesSettings;
  const NotificationsRoute({super.key, required this.prefrencesSettings});

  @override
  State<NotificationsRoute> createState() => _NotificationsRouteState();
}

class _NotificationsRouteState extends State<NotificationsRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notifications",
          style: AppFonts.headerStyle(
              fontWeight: FontWeight.bold, context: context),
        ),
      ),
      body: FutureBuilder(
        future: NotificationsViewModel().getNotifications(
            accessToken: widget.prefrencesSettings.accesstoken!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              // snapshot
              NotificationsModel notificationsModel =
                  NotificationsModel.fromJson(snapshot.data);
              List<Datum> data = notificationsModel.data;
              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  Datum currentNotification = data[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: GlassmorphContainer(
                        borderRadius: 10,
                        hzMargin: 0,
                        color: (Theme.of(context).brightness == Brightness.dark)
                            ? AppColors.darkPruple
                            : AppColors.grey,
                        child: Row(
                          children: [
                             CircleAvatar(
                              backgroundColor: Colors.white24,
                              backgroundImage: (currentNotification.image.length <2)?null : CachedNetworkImageProvider(currentNotification.image),
                              child: (currentNotification.image.length <2)? const FaIcon(
                                FontAwesomeIcons.exclamation,
                              ): null,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${currentNotification.title}:',
                                  style: AppFonts.headerStyle(
                                      fontWeight: FontWeight.w600,
                                      context: context),
                                ),
                                Text(
                                  currentNotification.message,
                                  style: AppFonts.headerStyle(
                                      fontWeight: FontWeight.w400,
                                      context: context),
                                ),
                              ],
                            ),

                            // const Spacer(),
                            // IconButton(
                            //     visualDensity: VisualDensity.compact,
                            //     onPressed: () {},
                            //     icon: const Icon(Icons.delete))
                          ],
                        )),
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
      ),
    );
  }
}
