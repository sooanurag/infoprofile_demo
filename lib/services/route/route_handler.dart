import 'package:flutter/material.dart';
import 'package:infoprofile_demo/resources/routes.dart';
import 'package:infoprofile_demo/view/onboarding/onboarding_route.dart';

import '../../view/onboarding/splash_route.dart';

class RouteHandler {
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case Routes.splash:
        return MaterialPageRoute(builder: (context) => const SplashRoute());
      case Routes.onboarding:
        return MaterialPageRoute(builder: (context) => const OnboardingRoute());
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