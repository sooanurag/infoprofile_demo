import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:infoprofile_demo/resources/colors.dart';
import 'package:infoprofile_demo/resources/fonts.dart';
import 'package:infoprofile_demo/utils/glassmorph_container.dart';

class NotificationsRoute extends StatefulWidget {
  const NotificationsRoute({super.key});

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
          style: AppFonts.headerStyle(fontWeight: FontWeight.bold,context: context),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemCount: 20,
        itemBuilder: (context, index) {
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
                    const CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(
                          "https://picsum.photos/200/200"),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Kapil sharma",
                      style: AppFonts.headerStyle(fontWeight: FontWeight.w600,context: context),
                    ),
                    const Spacer(),
                    IconButton(
                        visualDensity: VisualDensity.compact,
                        onPressed: () {},
                        icon: const Icon(Icons.person_add))
                  ],
                )),
          );
        },
      ),
    );
  }
}
