import 'package:flutter/material.dart';

import 'package:infoprofile_demo/components/onboarding/auth/otp_form.dart';
import 'package:infoprofile_demo/providers/onboarding/auth_provider.dart';
import 'package:infoprofile_demo/viewmodels/onboarding/auth_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../resources/colors.dart';
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
  final _emailFocusNode = FocusNode();
  final _otpOne = TextEditingController();
  final _otpTwo = TextEditingController();
  final _otpthree = TextEditingController();
  final _otpFour = TextEditingController();
  final _otpOneFocusNode = FocusNode();
  final _otpTwoFocusNode = FocusNode();
  final _otpthreeFocusNode = FocusNode();
  final _otpFourFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  final _emailformKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailFocusNode.requestFocus();
    super.initState();
  }

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
          Form(
            key: _emailformKey,
            child: Utils.customTextFormField(
              inputController: _emailController,
              invalidText: AppStrings.emailInvalidtext,
              prefixIcon: LottieAnimations.email,
              currentFocusNode: _emailFocusNode,
              borderRadius: 30,
              hint: "Email Address",
              fillColor: Colors.white,
              isFilled: true,
              contentPadding: const EdgeInsets.all(0),
              isEnabled: !value.isOTPsent,
            ),
          ),
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
            onPressed: () async {
              if (value.authType == AppStrings.authForgotPassword) {
                
                if (_emailformKey.currentState!.validate()) {
                  Utils.customDialog(
                    barrierDismissible: false,
                    context: context,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: CircularProgressIndicator(
                        color: AppColors.white,
                      ),
                    ));
                  await AuthViewModel.onSubmitSendOTP(
                    inputEmail: _emailController.text.trim(),
                    context: context,
                    authProvider: value,
                  );
                }
              } else if (value.authType == AppStrings.authOTP) {
                String otp =
                    '${_otpOne.text.trim()}${_otpTwo.text.trim()}${_otpthree.text.trim()}${_otpFour.text.trim()}';
                // operation on verify OTP
                
                if (_formKey.currentState!.validate()) {
                  Utils.customDialog(
                    barrierDismissible: false,
                    context: context,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: CircularProgressIndicator(
                        color: AppColors.white,
                      ),
                    ));
                  await AuthViewModel.onSubmitForgotPasswordOTPverify(
                    inputEmail: _emailController.text.trim(),
                    otp: otp,
                    context: context,
                    authProvider: value,
                  );
                }
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
