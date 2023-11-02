import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infoprofile_demo/models/prefrences_settings_model.dart';
import 'package:infoprofile_demo/resources/colors.dart';
import 'package:infoprofile_demo/resources/routes.dart';
import 'package:infoprofile_demo/resources/strings.dart';
import 'package:infoprofile_demo/utils/utils.dart';

class CustomFloatingButton extends StatefulWidget {
  final PrefrencesSettings prefrencesSettings;
  const CustomFloatingButton({super.key, required this.prefrencesSettings});

  @override
  State<CustomFloatingButton> createState() => _CustomFloatingButtonState();
}

class _CustomFloatingButtonState extends State<CustomFloatingButton> {
  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      elevation: 20,
      animatedIcon: AnimatedIcons.menu_close,
      overlayColor: AppColors.black,
      spaceBetweenChildren: 10,
      spacing: 10,
      children: [
        SpeedDialChild(
            onTap: () {
              // open add-post
              Navigator.pushNamed(context, Routes.createPost,arguments: widget.prefrencesSettings);
            },
            shape: const CircleBorder(),
            child: const FaIcon(FontAwesomeIcons.plus),
            label: "Post"),
        SpeedDialChild(
            onTap: () {
              Navigator.pushNamed(context, Routes.profile,arguments: widget.prefrencesSettings);
            },
            shape: const CircleBorder(),
            child: const FaIcon(FontAwesomeIcons.user),
            label: "Profile"),
        SpeedDialChild(
            onTap: () {
              Utils.showToastMessage(AppStrings.notAvailabe);
            },
            shape: const CircleBorder(),
            child: const FaIcon(FontAwesomeIcons.star),
            label: "Favroits"),
      ],
    );
  }
}
