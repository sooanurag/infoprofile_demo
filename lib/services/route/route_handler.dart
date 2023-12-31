import 'package:flutter/material.dart';
import 'package:infoprofile_demo/models/prefrences_settings_model.dart';

import 'package:infoprofile_demo/resources/routes.dart';
import 'package:infoprofile_demo/view/actions/create_post_route.dart';
import 'package:infoprofile_demo/view/actions/postview_route.dart';
import 'package:infoprofile_demo/view/home/feeds_route.dart';
import 'package:infoprofile_demo/view/home/notifications_route.dart';
import 'package:infoprofile_demo/view/home/profile_route.dart';
import 'package:infoprofile_demo/view/actions/update_profile_route.dart';
import 'package:infoprofile_demo/view/home/search_route.dart';
import 'package:infoprofile_demo/view/onboarding/getstarted_route.dart';
import 'package:infoprofile_demo/view/onboarding/login_route.dart';
import 'package:infoprofile_demo/view/onboarding/onboarding_route.dart';
import 'package:infoprofile_demo/view/onboarding/signup_route.dart';

import '../../models/userfeeds_model.dart';
import '../../view/actions/searched_userprofile_route.dart';
import '../../view/onboarding/splash_route.dart';

class RouteHandler {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (context) => const SplashRoute());
      case Routes.onboarding:
        return MaterialPageRoute(builder: (context) => const OnboardingRoute());
      case Routes.login:
        return MaterialPageRoute(builder: (context) => const LoginRoute());
      case Routes.signup:
        return MaterialPageRoute(builder: (context) => const SignupRoute());
      case Routes.getstarted:
        return MaterialPageRoute(builder: (context) => const GetStartedRoute());
      case Routes.feeds:
        return MaterialPageRoute(
            builder: (context) => FeedsRoute(
                  prefrencesSettings: settings.arguments as PrefrencesSettings,
                ));
      case Routes.profile:
        return MaterialPageRoute(
            builder: (context) => ProfileRoute(
                  prefrencesSettings: settings.arguments as PrefrencesSettings,
                ));
      case Routes.notification:
        return MaterialPageRoute(
            builder: (context) => NotificationsRoute(
                  prefrencesSettings: settings.arguments as PrefrencesSettings,
                ));
      case Routes.search:
        return MaterialPageRoute(
            builder: (context) => SearchRoute(
                  prefrencesSettings: settings.arguments as PrefrencesSettings,
                ));
      case Routes.createPost:
        return MaterialPageRoute(
            builder: (context) => CreatePostRoute(
                  prefrencesSettings: settings.arguments as PrefrencesSettings,
                ));
      case Routes.updateProfile:
        return MaterialPageRoute(
            builder: (context) => UpdateProfileRoute(
                  prefrencesSettings: settings.arguments as PrefrencesSettings,
                ));
      case Routes.postView:
        final Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        UserPosts postData = arguments['param1'];
        UserData postUserData = arguments['param2'];
        PrefrencesSettings prefrencesSettings = arguments['param3'];

        return MaterialPageRoute(
            builder: (context) => PostViewRoute(
                  postData: postData,
                  postUserData: postUserData,
                  prefrencesSettings: prefrencesSettings,
                ));
      case Routes.userProfileView:
        final Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        String accessToken = arguments['param1'];
        String userId = arguments['param2'];
        PrefrencesSettings userData = arguments['param3'];

        return MaterialPageRoute(
            builder: (context) => SearchUserProfileRoute(
                  accessToken: accessToken,
                  userId: userId,
                  prefrencesSettings: userData,
                ));

      default:
        return MaterialPageRoute(
            builder: (context) => Scaffold(
                  appBar: AppBar(
                    title: const Text("Invaid Route"),
                  ),
                ));
    }
  }
}
