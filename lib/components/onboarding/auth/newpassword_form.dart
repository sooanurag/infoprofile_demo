import 'package:flutter/material.dart';
import 'package:infoprofile_demo/providers/onboarding/auth_provider.dart';
import 'package:infoprofile_demo/viewmodels/onboarding/auth_viewmodel.dart';

import 'package:provider/provider.dart';

import '../../../resources/colors.dart';
import '../../../resources/strings.dart';
import '../../../utils/lottie_animation.dart';
import '../../../utils/utils.dart';

class NewPasswordForm extends StatefulWidget {
  final String bearerToken;
  const NewPasswordForm({super.key, required this.bearerToken});

  @override
  State<NewPasswordForm> createState() => _NewPasswordFormState();
}

class _NewPasswordFormState extends State<NewPasswordForm> {
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _newPasswordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Consumer<AuthProvider>(builder: (context, value, child) {
        return Form(
          key: _formKey,
          child: Column(children: [
            Utils.customTextFormField(
              inputController: _newPasswordController,
              currentFocusNode: _newPasswordFocusNode,
              textInputAction: TextInputAction.next,
              invalidText: AppStrings.passwordInvalidtext,
              prefixIcon: LottieAnimations.lock,
              obscure: value.isObscure,
              suffixIcon: IconButton(
                  onPressed: () {
                    value.setObscureStatus(status: !value.isObscure);
                  },
                  icon: (value.isObscure)
                      ? const Icon(Icons.visibility_off_outlined)
                      : Icon(
                          Icons.visibility,
                          color: AppColors.blue,
                        )),
              borderRadius: 30,
              hint: "New Password",
              fillColor: Colors.white,
              isFilled: true,
              contentPadding: const EdgeInsets.all(0),
            ),
            const SizedBox(
              height: 20,
            ),
            Utils.customTextFormField(
              inputController: _confirmPasswordController,
              currentFocusNode: _confirmPasswordFocusNode,
              textInputAction: TextInputAction.done,
              invalidText: AppStrings.passwordInvalidtext,
              prefixIcon: LottieAnimations.lock,
              obscure: value.isObscure,
              suffixIcon: IconButton(
                  onPressed: () {
                    value.setObscureStatus(status: !value.isObscure);
                  },
                  icon: (value.isObscure)
                      ? const Icon(Icons.visibility_off_outlined)
                      : Icon(
                          Icons.visibility,
                          color: AppColors.blue,
                        )),
              borderRadius: 30,
              hint: "Confirm Password",
              fillColor: Colors.white,
              isFilled: true,
              contentPadding: const EdgeInsets.all(0),
            ),
            const SizedBox(
              height: 20,
            ),
            Utils.textButton(
              onPressed: () async {
                // new password APi call
                if (_formKey.currentState!.validate()) {
                  if (_newPasswordController.text !=
                      _confirmPasswordController.text) {
                    Utils.alertDialog(
                        context: context,
                        inputTitle: const Text("Error:"),
                        inputContent: const Text("Password did'nt matched!"),
                        inputActions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("close"),
                          ),
                        ]);
                  } else {
                    Utils.customDialog(
                barrierDismissible: false,
                context: context,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: CircularProgressIndicator(
                    color: AppColors.white,
                  ),
                ));
                    await AuthViewModel.onSubmitNewPassword(
                      newPassword: _newPasswordController.text,
                      bearerToken: widget.bearerToken,
                      context: context,
                      authProvider: value,
                    );
                  }
                }
              },
              buttonText: "Confirm",
            ),
          ]),
        );
      }),
    );
  }
}
