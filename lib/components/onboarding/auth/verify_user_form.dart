import 'package:flutter/material.dart';

import 'package:infoprofile_demo/components/onboarding/auth/otp_form.dart';
import 'package:infoprofile_demo/providers/onboarding/auth_provider.dart';
import 'package:infoprofile_demo/resources/colors.dart';
import 'package:infoprofile_demo/viewmodels/onboarding/auth_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../resources/strings.dart';

import '../../../utils/utils.dart';

class VerifyUserForm extends StatefulWidget {
  const VerifyUserForm({super.key});

  @override
  State<VerifyUserForm> createState() => _VerifyUserFormState();
}

class _VerifyUserFormState extends State<VerifyUserForm> {
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
              if (!value.isVerifyingEmail) {
                _otpFourFocusNode.unfocus();
                if (_formKey.currentState!.validate()) {
                  value.setIsVerfyingEmailStatus(status: true);
                  Utils.customDialog(
                      barrierDismissible: false,
                      context: context,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: CircularProgressIndicator(
                          color: AppColors.white,
                        ),
                      ));
                  String otp =
                      "${_otpOne.text.trim()}${_otpTwo.text.trim()}${_otpthree.text.trim()}${_otpFour.text.trim()}";
                  AuthViewModel.onSubmitVerifyOTP(
                    inputEmail: value.signUpEmail,
                    inputOTP: otp,
                    context: context,
                    providerValue: value,
                  );
                } else {
                  Utils.showToastMessage(
                      AppStrings.authSubHeaders[AppStrings.authOTP]);
                }
              }
            },
            buttonText: AppStrings.authVerifyOTP,
          ),
        ]);
      }),
    );
  }
}
