import 'package:flutter/material.dart';
import 'package:infoprofile_demo/providers/onboarding/auth_provider.dart';

import '../../../utils/utils.dart';

class OtpForm extends StatefulWidget {
  final TextEditingController otpOne;
  final TextEditingController otpTwo;
  final TextEditingController otpthree;
  final TextEditingController otpFour;
  final FocusNode otpOneFocusNode;
  final FocusNode otpTwoFocusNode;
  final FocusNode otpthreeFocusNode;
  final FocusNode otpFourFocusNode;
  final GlobalKey<FormState> formKey;
  final AuthProvider value;
  const OtpForm({
    super.key,
    required this.formKey,
    required this.otpOne,
    required this.otpTwo,
    required this.otpthree,
    required this.otpFour,
    required this.otpOneFocusNode,
    required this.otpTwoFocusNode,
    required this.otpthreeFocusNode,
    required this.otpFourFocusNode,
    required this.value,
  });

  @override
  State<OtpForm> createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Utils.customTextFormField(
              inputController: widget.otpOne,
              currentFocusNode: widget.otpOneFocusNode,
              textInputAction: TextInputAction.next,
              isEnabled: !widget.value.isVerifyingEmail,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  Utils.changeFieldFocus(
                    context: context,
                    currentNode: widget.otpOneFocusNode,
                    nextNode: widget.otpTwoFocusNode,
                  );
                }
              },
              invalidText: " ",
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
              inputController: widget.otpTwo,
              currentFocusNode: widget.otpTwoFocusNode,
              textInputAction: TextInputAction.next,
              isEnabled: !widget.value.isVerifyingEmail,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  Utils.changeFieldFocus(
                    context: context,
                    currentNode: widget.otpTwoFocusNode,
                    nextNode: widget.otpthreeFocusNode,
                  );
                } else if (value.isEmpty) {
                  Utils.changeFieldFocus(
                    context: context,
                    currentNode: widget.otpTwoFocusNode,
                    nextNode: widget.otpOneFocusNode,
                  );
                }
              },
              invalidText: " ",
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
              inputController: widget.otpthree,
              currentFocusNode: widget.otpthreeFocusNode,
              textInputAction: TextInputAction.next,
              isEnabled: !widget.value.isVerifyingEmail,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  Utils.changeFieldFocus(
                    context: context,
                    currentNode: widget.otpthreeFocusNode,
                    nextNode: widget.otpFourFocusNode,
                  );
                } else if (value.isEmpty) {
                  Utils.changeFieldFocus(
                    context: context,
                    currentNode: widget.otpthreeFocusNode,
                    nextNode: widget.otpTwoFocusNode,
                  );
                }
              },
              invalidText: " ",
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
              inputController: widget.otpFour,
              currentFocusNode: widget.otpFourFocusNode,
              textInputAction: TextInputAction.done,
              isEnabled: !widget.value.isVerifyingEmail,
              onChanged: (value) {
                if (value.isEmpty) {
                  Utils.changeFieldFocus(
                    context: context,
                    currentNode: widget.otpFourFocusNode,
                    nextNode: widget.otpthreeFocusNode,
                  );
                }
              },
              invalidText: " ",
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
    );
  }
}
