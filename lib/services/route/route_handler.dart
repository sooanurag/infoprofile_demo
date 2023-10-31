import 'package:flutter/material.dart';

import 'package:infoprofile_demo/resources/routes.dart';
import 'package:infoprofile_demo/view/actions/create_post_route.dart';
import 'package:infoprofile_demo/view/home/feeds_route.dart';
import 'package:infoprofile_demo/view/home/notifications_route.dart';
import 'package:infoprofile_demo/view/home/profile_route.dart';
import 'package:infoprofile_demo/view/home/search_route.dart';
import 'package:infoprofile_demo/view/onboarding/getstarted_route.dart';
import 'package:infoprofile_demo/view/onboarding/login_route.dart';
import 'package:infoprofile_demo/view/onboarding/onboarding_route.dart';
import 'package:infoprofile_demo/view/onboarding/signup_route.dart';

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
        return MaterialPageRoute(builder: (context) => const FeedsRoute());
      case Routes.profile:
        return MaterialPageRoute(builder: (context) => const ProfileRoute());
      case Routes.notification:
        return MaterialPageRoute(
            builder: (context) => const NotificationsRoute());
      case Routes.search:
        return MaterialPageRoute(builder: (context) => const SearchRoute());
      case Routes.createPost:
        return MaterialPageRoute(builder: (context) => const CreatePostRoute());

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
