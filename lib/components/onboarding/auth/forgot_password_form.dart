import 'package:flutter/material.dart';
import 'package:infoprofile_demo/components/onboarding/auth/otp_form.dart';
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
  final _otpOneFocusNode = FocusNode();
  final _otpTwoFocusNode = FocusNode();
  final _otpthreeFocusNode = FocusNode();
  final _otpFourFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _otpOne.dispose();
    _otpTwo.dispose();
    _otpthree.dispose();
    _otpFour.dispose();
    _otpOneFocusNode.dispose();
    _otpTwoFocusNode.dispose();
    _otpthreeFocusNode.dispose();
    _otpFourFocusNode.dispose();
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
              child: OtpForm(
                formKey: _formKey,
                otpOne: _otpOne,
                otpTwo: _otpTwo,
                otpthree: _otpthree,
                otpFour: _otpFour,
                otpOneFocusNode: _otpOneFocusNode,
                otpTwoFocusNode: _otpTwoFocusNode,
                otpthreeFocusNode: _otpthreeFocusNode,
                otpFourFocusNode: _otpFourFocusNode,
                value: value,
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
