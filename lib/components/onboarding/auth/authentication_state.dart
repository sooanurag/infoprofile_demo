import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';

import 'package:infoprofile_demo/providers/onboarding/authanimate_provider.dart';
import 'package:infoprofile_demo/providers/onboarding/auth_provider.dart';
import 'package:infoprofile_demo/resources/fonts.dart';
import 'package:infoprofile_demo/resources/paths.dart';
import 'package:infoprofile_demo/utils/glassmorph_container.dart';
import 'package:infoprofile_demo/utils/lottie_animation.dart';
import 'package:provider/provider.dart';

import '../../../resources/strings.dart';
import '../../../utils/utils.dart';

class AuthSignInState extends StatefulWidget {
  const AuthSignInState({super.key});

  @override
  State<AuthSignInState> createState() => _AuthSignInStateState();
}

class _AuthSignInStateState extends State<AuthSignInState> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Consumer<AuthAnimateProvider>(
        builder: (context, animateValue, child) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: SvgPicture.asset(
                    AppPaths.logoWhite,
                    height: 40,
                  ),
                ),
                SizedBox(
                  height: screenSize.height * 0.08,
                ),
                Consumer<AuthProvider>(
                  builder: (context, value, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          value.authType,
                          style: AppFonts.headerStyle(
                              context: context,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Colors.white),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          value.authTypeSubHead,
                          style: AppFonts.headerStyle(
                              context: context,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: screenSize.height * 0.04,
                        ),
                        GlassmorphContainer(
                          child: value.formWidget,
                        ).animate().moveY(),
                        SizedBox(
                          height: screenSize.height * 0.06,
                        ),
                        if (value.authType == AppStrings.authForgotPassword ||
                            value.authType == AppStrings.authOTP ||
                            value.authType == AppStrings.authVerifyUserEmail)
                          //forgot back button
                          Center(
                            child: Utils.textButton(
                              onPressed: () {
                                if (value.authType ==
                                    AppStrings.authForgotPassword) {
                                  value.setAuthType(
                                      authtype: AppStrings.authLogIn);
                                } else if (value.authType ==
                                    AppStrings.authOTP) {
                                  value.setAuthType(
                                      authtype: AppStrings.authForgotPassword);
                                  value.setIsOTPsent(status: false);
                                } else if (value.authType ==
                                    AppStrings.authVerifyUserEmail) {
                                  value.setAuthType(
                                      authtype: AppStrings.authSignUp);
                                }
                              },
                              buttonText: "Back",
                              elevation: 0,
                              backgroundColor: Colors.white24,
                              textColor: Colors.white,
                            ),
                          ),
                        if (value.authType == AppStrings.authLogIn ||
                            value.authType == AppStrings.authSignUp)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GlassmorphContainer(
                                child: LottieAnimations.facebook,
                              ),
                              GlassmorphContainer(
                                child: LottieAnimations.linkdin,
                              ),
                              GlassmorphContainer(
                                child: LottieAnimations.twitter,
                              ),
                            ],
                          ).animate().fadeIn(),
                        SizedBox(
                          height: screenSize.height * 0.08,
                        ),
                        if (value.authType == AppStrings.authLogIn ||
                            value.authType == AppStrings.authSignUp)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                value.authTypePrefix,
                                style: AppFonts.headerStyle(
                                    context: context,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                              TextButton(
                                  style: ButtonStyle(
                                      padding: MaterialStateProperty.all(
                                          EdgeInsets.zero)),
                                  onPressed: () {
                                    value.setAuthType(
                                        authtype: (value.authType ==
                                                AppStrings.authSignUp)
                                            ? AppStrings.authLogIn
                                            : AppStrings.authSignUp);
                                  },
                                  child: Text(
                                    (value.authType == AppStrings.authLogIn)
                                        ? AppStrings.authSignUp
                                        : AppStrings.authLogIn,
                                    style: AppFonts.headerStyle(
                                        context: context,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        textDecoration:
                                            TextDecoration.underline),
                                  ))
                            ],
                          )
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      )
          .animate()
          .fadeIn()
          .then()
          .animate(target: animateValue.isLoginStateChange ? 1 : 0)
          .fadeOut();
    });
  }
}
