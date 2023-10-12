import 'dart:async';

import 'package:flutter/material.dart';
import 'package:infoprofile_demo/providers/theme_provider.dart';
import 'package:infoprofile_demo/utils/lottie_animation.dart';
import 'package:provider/provider.dart';
import '../../resources/routes.dart';

class SplashRoute extends StatefulWidget {
  const SplashRoute({super.key});

  @override
  State<SplashRoute> createState() => _SplashRouteState();
}

class _SplashRouteState extends State<SplashRoute> {
   @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, Routes.onboarding);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer<ThemeProvider>(
          builder: (context,value,child) {
            return (value.themeMode == ThemeMode.light)?LottieAnimations.logoDelayed
            :LottieAnimations.logoDelayed;
          }
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(bottom: 30),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "by Anurag Gupta",
            ),
          ],
        ),
      ),
    );
  }
}