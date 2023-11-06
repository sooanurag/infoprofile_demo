import 'package:flutter/material.dart';
import 'package:infoprofile_demo/models/prefrences_settings_model.dart';
import 'package:infoprofile_demo/providers/home/user_provider.dart';
import 'package:infoprofile_demo/repository/home/posts_repo.dart';
import 'package:infoprofile_demo/repository/home/profile_repo.dart';
import 'package:infoprofile_demo/repository/home/user_repo.dart';
import 'package:infoprofile_demo/services/prefrences_service.dart';
import 'package:infoprofile_demo/utils/utils.dart';
import 'package:provider/provider.dart';

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
    final userProvider = Provider.of<UserProvider>(context, listen: false);
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
      userProvider.setusername(username: username);
      userProvider.setfullName(fullName: fullName);
      userProvider.setProfilePicUrl(url: profilePic);
      userProvider.setprofileBio(profileBio: profileBio);
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
      userProvider.setusername(username: username);
      userProvider.setfullName(fullName: fullName);
      userProvider.setProfilePicUrl(url: profilePic);
    } else if (username != null && fullName != null && profileBio != null) {
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
      userProvider.setusername(username: username);
      userProvider.setfullName(fullName: fullName);
      userProvider.setprofileBio(profileBio: profileBio);
    } else if (username != null && profilePic != null && profileBio != null) {
      payLoad = {
        'profilePic': profilePic,
        'username': username,
        'profileBio': profileBio,
      };
      await PrefrenceService().savePrefrences(
        prefrencesSettings: PrefrencesSettings(
          username: username,
          profilePic: profilePic,
          profileBio: profileBio,
        ),
      );
      userProvider.setusername(username: username);
      userProvider.setProfilePicUrl(url: profilePic);
      userProvider.setprofileBio(profileBio: profileBio);
    }
    else if (fullName != null && profilePic != null && profileBio != null) {
      payLoad = {
        'profilePic': profilePic,
        'username': username,
        'profileBio': profileBio,
      };
      await PrefrenceService().savePrefrences(
        prefrencesSettings: PrefrencesSettings(
          fullName: fullName,
          profilePic: profilePic,
          profileBio: profileBio,
        ),
      );
      userProvider.setfullName(fullName: fullName);
      userProvider.setProfilePicUrl(url: profilePic);
      userProvider.setprofileBio(profileBio: profileBio);
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
      userProvider.setusername(username: username);
      userProvider.setfullName(fullName: fullName);
    } else if (fullName != null && profileBio != null) {
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
      userProvider.setfullName(fullName: fullName);
      userProvider.setprofileBio(profileBio: profileBio);
    } else if (username != null && profileBio != null) {
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
      userProvider.setusername(username: username);
      userProvider.setprofileBio(profileBio: profileBio);
    } else if (username != null && profilePic != null) {
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
      userProvider.setusername(username: username);
      userProvider.setProfilePicUrl(url: profilePic);
    } else if (fullName != null && profilePic != null) {
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
      userProvider.setfullName(fullName: fullName);
      userProvider.setProfilePicUrl(url: profilePic);
    } else if (profileBio != null && profilePic != null) {
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
      userProvider.setProfilePicUrl(url: profilePic);
      userProvider.setprofileBio(profileBio: profileBio);
    } else if (username != null) {
      payLoad = {
        'username': username,
      };
      await PrefrenceService().savePrefrences(
        prefrencesSettings: PrefrencesSettings(
          username: username,
        ),
      );
      userProvider.setusername(username: username);
    } else if (fullName != null) {
      payLoad = {
        'fullName': fullName,
      };
      await PrefrenceService().savePrefrences(
        prefrencesSettings: PrefrencesSettings(fullName: fullName),
      );
      userProvider.setfullName(fullName: fullName);
    } else if (profilePic != null) {
      payLoad = {
        'profilePic': profilePic,
      };
      await PrefrenceService().savePrefrences(
        prefrencesSettings: PrefrencesSettings(profilePic: profilePic),
      );
      userProvider.setProfilePicUrl(url: profilePic);
    } else if (profileBio != null) {
      payLoad = {
        'profileBio': profileBio,
      };
      await PrefrenceService().savePrefrences(
        prefrencesSettings: PrefrencesSettings(profileBio: profileBio),
      );
      userProvider.setprofileBio(profileBio: profileBio);
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

  Future<dynamic> getFollowers({
    required String accessToken,
    required String userId,
  }) async {
    dynamic response;
    try {
      response = await ProfileRepository()
          .getUsersFollowersApi(accessToken: accessToken, userId: userId);
      // debugPrint('## Follower: $response');
      //update count
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getFollowing({
    required String accessToken,
    required String userId,
  }) async {
    dynamic response;
    debugPrint('accesstoken: $accessToken\n_id: $userId');
    try {
      response = await ProfileRepository()
          .getUsersFollowingApi(accessToken: accessToken, userId: userId);
      // debugPrint('## following: $response');
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
