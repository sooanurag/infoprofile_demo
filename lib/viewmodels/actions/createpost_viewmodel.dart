import 'dart:io';

import 'package:flutter/material.dart';
import 'package:infoprofile_demo/models/prefrences_settings_model.dart';
import 'package:infoprofile_demo/providers/actions/createpost_provider.dart';

import 'package:infoprofile_demo/repository/home/posts_repo.dart';
import 'package:infoprofile_demo/resources/colors.dart';
import 'package:infoprofile_demo/resources/fonts.dart';
import 'package:infoprofile_demo/resources/strings.dart';
import 'package:infoprofile_demo/services/storage/s3_service.dart';
import 'package:infoprofile_demo/utils/utils.dart';


class CreatePostViewModel {
  Future<void> onSubmitPost({
    required File imageFile,
    required BuildContext context,
    required Size screenSize,
    required CreatePostProvider createPostProvider,
    required PrefrencesSettings prefrencesSettings,
    String? caption,
  }) async {
    String? imageUrl;
    Utils.customDialog(
        barrierDismissible: false,
        context: context,
        child: SizedBox(
          width: screenSize.width * 0.6,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.uploading,
                  style: AppFonts.headerStyle(
                    context: context,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                LinearProgressIndicator(
                  color: (Theme.of(context).brightness == Brightness.dark)
                      ? AppColors.white
                      : AppColors.black,
                ),
              ],
            ),
          ),
        ));
    debugPrint('caption: $caption');
    await S3Services()
        .upload(file: imageFile, userid: prefrencesSettings.userId!)
        .then(
      (value) {
        // Navigator.pop(context);
        imageUrl = value;
        debugPrint('imageURL: $imageUrl');
      },
    ).onError(
      (error, stackTrace) {
        Navigator.pop(context);
        Utils.alertDialog(
          context: context,
          inputTitle: const Text(AppStrings.uploadErrorTitle),
          inputContent: Text(error.toString()),
          inputActions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("close"),
            ),
          ],
        );
      },
    );
    if (imageUrl != null) {
      await PostRepository()
          .createPostApi(
        accesstoken: prefrencesSettings.accesstoken!,
        dataUrl: imageUrl!,
        caption: (caption!.isEmpty) ? " " : caption,
      )
          .then((value) {
        createPostProvider.setImageFile(image: null);
        Navigator.pop(context);
        Utils.showToastMessage(AppStrings.uploadSuccess);
        //print
        debugPrint(value.toString());
      }).onError((error, stackTrace) {
        Navigator.pop(context);
        //print
        debugPrint(error.toString());
        Utils.alertDialog(
          context: context,
          inputContent: Text(error.toString()),
          inputActions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("close"),
            ),
          ],
        );
      });
    } else {
      if (context.mounted) {
        Navigator.pop(context);
        Utils.showToastMessage(AppStrings.uploadErrorTitle);
      }
    }
  }
}
