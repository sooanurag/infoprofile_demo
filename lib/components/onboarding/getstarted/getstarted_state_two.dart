import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:infoprofile_demo/providers/onboarding/getstarted_provider.dart';
import 'package:infoprofile_demo/resources/fonts.dart';
import 'package:infoprofile_demo/resources/strings.dart';
import 'package:infoprofile_demo/utils/glassmorph_container.dart';
import 'package:infoprofile_demo/utils/lottie_animation.dart';
import 'package:provider/provider.dart';

import '../../../resources/paths.dart';

class GetstartedStateTwo extends StatefulWidget {
  final Size screenSize;
  const GetstartedStateTwo({super.key, required this.screenSize});

  @override
  State<GetstartedStateTwo> createState() => _GetstartedStateTwoState();
}

class _GetstartedStateTwoState extends State<GetstartedStateTwo> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GetstartedProvider>(builder: (context, value, child) {
      return SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            SvgPicture.asset(
              AppPaths.logoWhite,
              width: widget.screenSize.width * 0.5,
            ).animate().fade(),
            const SizedBox(
              height: 10,
            ),
            Text(
              AppStrings.subHeading,
              style: AppFonts.headerStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 20),
            ).animate().fade(duration: const Duration(seconds: 1)).moveX(),
            const Spacer(
              flex: 2,
            ),
            Center(child: LottieAnimations.boxes),
            const Spacer(
              flex: 2,
            ),
            Center(
                child: InkWell(
              borderRadius: BorderRadius.circular(50),
              enableFeedback: true,
              onTap: () {
                value.setIsFadeOut(status: true);
                Timer(const Duration(milliseconds: 70), () {
                  value.setIsAuth(status: true);
                });
              },
              radius: 300,
              child: GlassmorphContainer(
                borderRadius: 50,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Get started",
                    style: AppFonts.headerStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ).animate().moveX(),
                ),
              ).animate().fade(),
            )),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: DefaultTextStyle(
                style: AppFonts.headerStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
                child: AnimatedTextKit(repeatForever: true, animatedTexts: [
                  TypewriterAnimatedText(AppStrings.onBoardingHeaders[0],
                      speed: const Duration(milliseconds: 100),
                      textAlign: TextAlign.center),
                  TypewriterAnimatedText(AppStrings.onBoardingHeaders[1],
                      speed: const Duration(milliseconds: 100),
                      textAlign: TextAlign.center),
                  TypewriterAnimatedText(AppStrings.onBoardingHeaders[2],
                      speed: const Duration(milliseconds: 100),
                      textAlign: TextAlign.center),
                ]),
              ).animate().fade(),
            ),
            const Spacer()
          ],
        ),
      )).animate(target: value.isFadeOut ? 1 : 0).fadeOut();
    });
  }
}
