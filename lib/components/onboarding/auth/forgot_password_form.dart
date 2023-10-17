import 'package:flutter/material.dart';
import 'package:infoprofile_demo/providers/onboarding/auth_provider.dart';
import 'package:provider/provider.dart';

import '../../../resources/strings.dart';
import '../../../utils/lottie_animation.dart';
import '../../../utils/utils.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _emailController = TextEditingController();
  final _otpOne = TextEditingController();
  final _otpTwo = TextEditingController();
  final _otpthree = TextEditingController();
  final _otpFour = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _otpOne.dispose();
    _otpTwo.dispose();
    _otpthree.dispose();
    _otpFour.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Consumer<AuthProvider>(builder: (context, value, child) {
        return Column(children: [
          Utils.customTextFormField(
            inputController: _emailController,
            invalidText: AppStrings.emailInvalidtext,
            prefixIcon: LottieAnimations.email,
            borderRadius: 30,
            hint: "Email Address",
            fillColor: Colors.white,
            isFilled: true,
            contentPadding: const EdgeInsets.all(0),
            isEnabled: !value.isOTPsent,
          ),

          // const SizedBox(
          //   height: 20,
          // ),
          if (value.authType == AppStrings.authOTP)
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 24, left: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Utils.customTextFormField(
                      inputController: _otpOne,
                      invalidText: "",
                      contentPadding: EdgeInsets.zero,
                      fillColor: Colors.white,
                      isFilled: true,
                      textAlign: TextAlign.center,
                      inputFontSize: 22,
                      maxLength: 1,
                      cursorColor: Colors.black12,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Utils.customTextFormField(
                      inputController: _otpTwo,
                      invalidText: "",
                      contentPadding: EdgeInsets.zero,
                      fillColor: Colors.white,
                      isFilled: true,
                      textAlign: TextAlign.center,
                      inputFontSize: 22,
                      maxLength: 1,
                      cursorColor: Colors.black12,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Utils.customTextFormField(
                      inputController: _otpthree,
                      invalidText: "",
                      contentPadding: EdgeInsets.zero,
                      fillColor: Colors.white,
                      isFilled: true,
                      textAlign: TextAlign.center,
                      inputFontSize: 22,
                      maxLength: 1,
                      cursorColor: Colors.black12,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Utils.customTextFormField(
                      inputController: _otpFour,
                      invalidText: "",
                      contentPadding: EdgeInsets.zero,
                      fillColor: Colors.white,
                      isFilled: true,
                      textAlign: TextAlign.center,
                      inputFontSize: 22,
                      maxLength: 1,
                      cursorColor: Colors.black12,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(
            height: 20,
          ),
          Utils.textButton(
            onPressed: () {
              if (value.authType == AppStrings.authForgotPassword) {
                value.setAuthType(authtype: AppStrings.authOTP);
                value.setIsOTPsent(status: true);
              } else if (value.authType == AppStrings.authOTP) {
                // operation on verify OTP
              }
            },
            buttonText: (value.authType == AppStrings.authForgotPassword)
                ? AppStrings.authSendOTP
                : AppStrings.authVerifyOTP,
          ),
        ]);
      }),
    );
  }
}
