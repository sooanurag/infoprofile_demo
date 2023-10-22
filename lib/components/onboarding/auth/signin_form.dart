import 'package:flutter/material.dart';
import 'package:infoprofile_demo/providers/onboarding/auth_provider.dart';
import 'package:infoprofile_demo/resources/fonts.dart';

import 'package:infoprofile_demo/utils/lottie_animation.dart';
import 'package:infoprofile_demo/utils/utils.dart';
import 'package:infoprofile_demo/viewmodels/onboarding/auth_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../resources/colors.dart';
import '../../../resources/strings.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(children: [
        Utils.customTextFormField(
          inputController: _emailController,
          invalidText: AppStrings.emailInvalidtext,
          prefixIcon: LottieAnimations.email,
          borderRadius: 30,
          hint: "Email Address",
          fillColor: Colors.white,
          isFilled: true,
          contentPadding: const EdgeInsets.all(0),
        ),
        const SizedBox(
          height: 20,
        ),
        Consumer<AuthProvider>(builder: (context, value, child) {
          return Utils.customTextFormField(
            inputController: _passwordController,
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
            hint: "Password",
            fillColor: Colors.white,
            isFilled: true,
            contentPadding: const EdgeInsets.all(0),
          );
        }),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.zero),
                overlayColor:
                    MaterialStateProperty.all(Colors.white.withOpacity(0))),
            onPressed: () {
              authProvider.setAuthType(authtype: AppStrings.authForgotPassword);
            },
            child: Text(
              "${AppStrings.authForgotPassword}?",
              style: AppFonts.headerStyle(
                  context: context,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 12),
            ),
          ),
        ),
        // const SizedBox(
        //   height: 10,
        // ),
        Utils.textButton(
          onPressed: () async {
            // login api call
            Utils.customDialog(
                    barrierDismissible: false,
                    context: context,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: CircularProgressIndicator(
                        color: AppColors.white,
                      ),
                    ));
            AuthViewModel.onSubmitLogIn(
              context: context,
              authProvider: authProvider,
              inputEmail: _emailController.text.trim(),
              inputPassword: _passwordController.text.trim(),
            );
            
          },
          buttonText: AppStrings.authLogIn,
        ),
      ]),
    );
  }
}
