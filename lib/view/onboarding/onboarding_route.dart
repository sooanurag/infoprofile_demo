import 'package:flutter/material.dart';
import 'package:infoprofile_demo/providers/theme_provider.dart';
import 'package:infoprofile_demo/resources/fonts.dart';
import 'package:infoprofile_demo/resources/strings.dart';
import 'package:infoprofile_demo/utils/lottie_animation.dart';
import 'package:infoprofile_demo/utils/utils.dart';
import 'package:provider/provider.dart';

class OnboardingRoute extends StatefulWidget {
  const OnboardingRoute({super.key});

  @override
  State<OnboardingRoute> createState() => _OnboardingRouteState();
}

class _OnboardingRouteState extends State<OnboardingRoute> {
  final PageController _pageController = PageController();

  final animations = [
    LottieAnimations.onBoardingOne,
    LottieAnimations.onBoardingTwo,
    LottieAnimations.onBoardingThree,
  ];
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: PageView.builder(
          controller: _pageController,
          itemCount: 3,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (index == 0)
                          Utils.textButton(
                            onPressed: () {
                              _pageController.animateToPage(
                                2,
                                duration: const Duration(seconds: 1),
                                curve: Curves.ease,
                              );
                            },
                            elevation: 1,
                            hzPadding: 10,
                            fontSize: 14,
                            buttonText: "Skip",
                          ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            AppStrings.onBoardingHeaders[index],
                            style: AppFonts.headerStyle(
                                fontSize: 28, fontWeight: FontWeight.bold),
                          ),
                          animations[index],
                          const Spacer(
                            flex: 1,
                          ),
                          if (index != 2)
                            Utils.textButton(
                              onPressed: () {
                                _pageController.nextPage(
                                    duration: const Duration(seconds: 1),
                                    curve: Curves.ease);
                              },
                              elevation: 3,
                              hzPadding: 26,
                              buttonText: "Next",

                            ),
                          if (index == 2)
                            Utils.textButton(
                              onPressed: () {},
                              buttonText: "Get Started",
                              elevation: 3,
                              fontSize: 18,
                              hzPadding: 36,

                            ),
                          const Spacer(
                            flex: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
