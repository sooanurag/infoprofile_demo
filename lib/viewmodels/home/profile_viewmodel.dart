import 'package:flutter/material.dart';
import 'package:infoprofile_demo/models/prefrences_settings_model.dart';
import 'package:infoprofile_demo/repository/home/posts_repo.dart';
import 'package:infoprofile_demo/repository/home/user_repo.dart';
import 'package:infoprofile_demo/services/prefrences_service.dart';
import 'package:infoprofile_demo/utils/utils.dart';

class ProfileViewModel {
  Future<dynamic> userPostsApiCall({
    required String accessToken,
    required String userId,
  }) async {
    try {
      dynamic response = await PostRepository().getMyPostApi(
        accessToken: accessToken,
      );
      debugPrint('posts: ${response.toString()}');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateProfile({
    required String accesstoken,
    required BuildContext context,
    String? username,
    String? fullName,
    String? profilePic,
    String? profileBio,
  }) async {
    debugPrint(
        'username: $username\nfullName: $fullName\nprofilePic: $profilePic\nprofileBio: $profileBio');
    Map<String, dynamic> payLoad = {};
    if (username != null &&
        fullName != null &&
        profilePic != null &&
        profileBio != null) {
      payLoad = {
        'fullName': fullName,
        'username': username,
        'profilePic': profilePic,
        'profileBio': profileBio,
      };
      await PrefrenceService().savePrefrences(
        prefrencesSettings: PrefrencesSettings(
          username: username,
          fullName: fullName,
          profilePic: profilePic,
          profileBio: profileBio,
        ),
      );
    } else if (username != null && fullName != null && profilePic != null) {
      payLoad = {
        'fullName': fullName,
        'username': username,
        'profilePic': profilePic,
      };
      await PrefrenceService().savePrefrences(
        prefrencesSettings: PrefrencesSettings(
          username: username,
          fullName: fullName,
          profilePic: profilePic,
        ),
      );
    } 
    else if (username != null && fullName != null && profileBio != null) {
      payLoad = {
        'fullName': fullName,
        'username': username,
        'profileBio': profileBio,
      };
      await PrefrenceService().savePrefrences(
        prefrencesSettings: PrefrencesSettings(
          username: username,
          fullName: fullName,
          profileBio: profileBio,
        ),
      );
    }
    else if (username != null && fullName != null) {
      payLoad = {
        'fullName': fullName,
        'username': username,
      };
      await PrefrenceService().savePrefrences(
        prefrencesSettings: PrefrencesSettings(
          username: username,
          fullName: fullName,
        ),
      );
    } 
    else if (fullName != null && profileBio != null) {
      payLoad = {
        'fullName': fullName,
        'profileBio': profileBio,
      };
      await PrefrenceService().savePrefrences(
        prefrencesSettings: PrefrencesSettings(
          fullName: fullName,
          profileBio: profileBio,
        ),
      );
    }
    else if (username != null && profileBio != null) {
      payLoad = {
        'username': username,
        'profileBio': profileBio,
      };
      await PrefrenceService().savePrefrences(
        prefrencesSettings: PrefrencesSettings(
          username: username,
          profileBio: profileBio,
        ),
      );
    }
    else if (username != null && profilePic != null) {
      payLoad = {
        'username': username,
        'profilePic': profilePic,
      };
      await PrefrenceService().savePrefrences(
        prefrencesSettings: PrefrencesSettings(
          username: username,
          profilePic: profilePic,
        ),
      );
    }
    else if (fullName != null && profilePic != null) {
      payLoad = {
        'fullName': fullName,
        'profilePic': profilePic,
      };
      await PrefrenceService().savePrefrences(
        prefrencesSettings: PrefrencesSettings(
          fullName: fullName,
          profilePic: profilePic,
        ),
      );
    }
    else if (profileBio != null && profilePic != null) {
      payLoad = {
        'profileBio': profileBio,
        'profilePic': profilePic,
      };
      await PrefrenceService().savePrefrences(
        prefrencesSettings: PrefrencesSettings(
          fullName: fullName,
          profilePic: profilePic,
        ),
      );
    }
    else if (username != null) {
      payLoad = {
        'username': username,
      };
      await PrefrenceService().savePrefrences(
        prefrencesSettings: PrefrencesSettings(
          username: username,
        ),
      );
    } else if (fullName != null) {
      payLoad = {
        'fullName': fullName,
      };
      await PrefrenceService().savePrefrences(
        prefrencesSettings: PrefrencesSettings(
          fullName: fullName
        ),
      );
    } else if (profilePic != null) {
      payLoad = {
        'profilePic': profilePic,
      };
      await PrefrenceService().savePrefrences(
        prefrencesSettings: PrefrencesSettings(
          profilePic: profilePic
        ),
      );
    } else if (profileBio != null) {
      payLoad = {
        'profileBio': profileBio,
      };
      await PrefrenceService().savePrefrences(
        prefrencesSettings: PrefrencesSettings(
          profileBio: profileBio
        ),
      );
    }
    if (payLoad.isNotEmpty) {
      debugPrint(payLoad.toString());
      await UserRepository()
          .editProfileApi(
        accesstoken: accesstoken,
        apiPayLoad: payLoad,
      )
          .then((value) {
        Navigator.pop(context);
        Navigator.pop(context);
        Utils.showToastMessage("Saved");
      }).onError((error, stackTrace) {
        Navigator.pop(context);
        debugPrint("update profile: $error");
        Utils.showToastMessage(error.toString());
      });
    }
  }
}
