import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:infoprofile_demo/models/prefrences_settings_model.dart';
import 'package:infoprofile_demo/resources/colors.dart';
import 'package:infoprofile_demo/utils/utils.dart';

class EditProfilePic extends StatefulWidget {
  final PrefrencesSettings prefrencesSettings;
  final ValueNotifier<File?> newProfilePic;
  const EditProfilePic(
      {super.key,
      required this.prefrencesSettings,
      required this.newProfilePic});

  @override
  State<EditProfilePic> createState() => _EditProfilePicState();
}

class _EditProfilePicState extends State<EditProfilePic> {
  @override
  Widget build(BuildContext context) {
    final PrefrencesSettings userData = widget.prefrencesSettings;
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        ValueListenableBuilder(
            valueListenable: widget.newProfilePic,
            builder: (context, value, child) {
              return (widget.newProfilePic.value == null)? CircleAvatar(
                backgroundImage: (userData.profilePic == null ||
                        userData.profilePic!.length < 2)
                    ? null
                    : CachedNetworkImageProvider(userData.profilePic!),
                radius: 80,
                child: (userData.profilePic == null ||
                        userData.profilePic!.length < 2)
                    ? const FaIcon(
                        FontAwesomeIcons.user,
                        size: 34,
                      )
                    : null,
              )
              : CircleAvatar(
                radius: 80,
                backgroundImage: FileImage(widget.newProfilePic.value!),
              )
              ;
            }),
        InkWell(
          borderRadius: BorderRadius.circular(100),
          onTap: () {
            showModalBottomSheet(
              showDragHandle: true,
              context: context,
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22)),
                        leading: const FaIcon(FontAwesomeIcons.camera),
                        title: const Text("Camera"),
                        onTap: () async {
                          Navigator.pop(context);
                          widget.newProfilePic.value = await Utils.selectImage(
                              source: ImageSource.camera);
                        },
                      ),
                      ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22)),
                        leading: const FaIcon(FontAwesomeIcons.images),
                        title: const Text("Gallery"),
                        onTap: () async {
                          Navigator.pop(context);
                          widget.newProfilePic.value = await Utils.selectImage(
                              source: ImageSource.gallery);
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).viewInsets.bottom,
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: CircleAvatar(
            radius: 18,
            backgroundColor: (Theme.of(context).brightness == Brightness.dark)
                ? AppColors.white
                : AppColors.black,
            child: FaIcon(
              FontAwesomeIcons.pen,
              size: 18,
              color: (Theme.of(context).brightness == Brightness.dark)
                  ? AppColors.black
                  : AppColors.white,
            ),
          ),
        ),
      ],
    );
  }
}
