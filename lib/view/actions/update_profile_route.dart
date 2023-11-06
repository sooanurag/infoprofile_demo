import 'dart:io';

import 'package:flutter/material.dart';
import 'package:infoprofile_demo/components/actions/edit_profile/edit_profile_form.dart';
import 'package:infoprofile_demo/components/actions/edit_profile/edit_profilepic.dart';
import 'package:infoprofile_demo/models/prefrences_settings_model.dart';

class UpdateProfileRoute extends StatefulWidget {
  final PrefrencesSettings prefrencesSettings;
  const UpdateProfileRoute({
    super.key,
    required this.prefrencesSettings,
  });

  @override
  State<UpdateProfileRoute> createState() => _UpdateProfileRouteState();
}

class _UpdateProfileRouteState extends State<UpdateProfileRoute> {
  @override
  Widget build(BuildContext context) {
    final PrefrencesSettings userData = widget.prefrencesSettings;
    ValueNotifier<File?> newProfilePic = ValueNotifier<File?>(null);
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile")),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),
              EditProfilePic(
                prefrencesSettings: userData,
                newProfilePic: newProfilePic,
              ),
              const SizedBox(
                height: 20,
              ),
              EditProfileForm(
                prefrencesSettings: userData,
                newProfilePic: newProfilePic,
              )
            ],
          ),
        ),
      ),
    );
  }
}
