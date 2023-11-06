import 'dart:io';

import 'package:flutter/material.dart';
import 'package:infoprofile_demo/models/prefrences_settings_model.dart';
import 'package:infoprofile_demo/resources/colors.dart';
import 'package:infoprofile_demo/services/storage/s3_service.dart';
import 'package:infoprofile_demo/utils/utils.dart';
import 'package:infoprofile_demo/viewmodels/home/profile_viewmodel.dart';

class EditProfileForm extends StatefulWidget {
  final PrefrencesSettings prefrencesSettings;
  final ValueNotifier<File?> newProfilePic;
  const EditProfileForm({
    super.key,
    required this.prefrencesSettings,
    required this.newProfilePic,
  });

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  final _fullNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _bioController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _fullNameController.dispose();
    _usernameController.dispose();
    _bioController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final PrefrencesSettings userData = widget.prefrencesSettings;
    if (userData.fullName!.length > 1) {
      _fullNameController.text = userData.fullName!;
    }
    if (userData.userId!.length > 1) {
      _usernameController.text = userData.username!;
    }
    if (userData.profileBio!.length > 1) {
      _bioController.text = userData.profileBio!;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Utils.customTextFormField(
              cursorColor: (Theme.of(context).brightness == Brightness.dark)
                  ? AppColors.white
                  : AppColors.black,
              inputFontColor: (Theme.of(context).brightness == Brightness.dark)
                  ? AppColors.white
                  : AppColors.black,
              inputController: _fullNameController,
              invalidText: "",
              isBorder: false,
              border: const UnderlineInputBorder(),
              label: "Name",
              textInputAction: TextInputAction.next),
          const SizedBox(
            height: 10,
          ),
          Utils.customTextFormField(
              cursorColor: (Theme.of(context).brightness == Brightness.dark)
                  ? AppColors.white
                  : AppColors.black,
              inputFontColor: (Theme.of(context).brightness == Brightness.dark)
                  ? AppColors.white
                  : AppColors.black,
              inputController: _usernameController,
              invalidText: "",
              isBorder: false,
              border: const UnderlineInputBorder(),
              label: "Username",
              textInputAction: TextInputAction.next),
          const SizedBox(
            height: 10,
          ),
          Utils.customTextFormField(
            cursorColor: (Theme.of(context).brightness == Brightness.dark)
                ? AppColors.white
                : AppColors.black,
            inputFontColor: (Theme.of(context).brightness == Brightness.dark)
                ? AppColors.white
                : AppColors.black,
            inputController: _bioController,
            invalidText: "",
            isBorder: false,
            border: const UnderlineInputBorder(),
            label: "Bio",
            textInputAction: TextInputAction.done,
          ),
          const SizedBox(
            height: 40,
          ),
          Utils.textButton(
              onPressed: () async {
                if (widget.newProfilePic.value != null ||
                    userData.fullName?.trim() != _fullNameController.text ||
                    userData.username?.trim() != _usernameController.text ||
                    userData.profileBio?.trim() != _bioController.text) {
                  Utils.customDialog(
                      barrierDismissible: false,
                      context: context,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: CircularProgressIndicator(
                          color: AppColors.white,
                        ),
                      ));
                  debugPrint('image file: ${widget.newProfilePic.value}');
                  String? imageUrl;
                  if (widget.newProfilePic.value != null) {
                    imageUrl = await S3Services().upload(
                      file: widget.newProfilePic.value!,
                      userid: widget.prefrencesSettings.userId!,
                    );
                    debugPrint('imageUrl: $imageUrl');
                  }
                  if (context.mounted) {
                    await ProfileViewModel().updateProfile(
                        accesstoken: widget.prefrencesSettings.accesstoken!,
                        context: context,
                        fullName: (_fullNameController.text !=
                                userData.fullName?.trim())
                            ? _fullNameController.text
                            : null,
                        username: (_usernameController.text !=
                                userData.username?.trim())
                            ? _usernameController.text
                            : null,
                        profileBio:
                            (_bioController.text != userData.profileBio?.trim())
                                ? _bioController.text
                                : null,
                        profilePic: imageUrl);
                  }
                } else {
                  Utils.showToastMessage("Saved");
                  Navigator.pop(context);
                }
              },
              buttonText: "Save"),
        ],
      ),
    );
  }
}
