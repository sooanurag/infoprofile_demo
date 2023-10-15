import 'package:flutter/material.dart';

import '../../../resources/fonts.dart';
import '../../../resources/strings.dart';
import '../../../utils/lottie_animation.dart';
import '../../../utils/utils.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(children: [
        Utils.customTextFormField(
          inputController: _usernameController,
          invalidText: AppStrings.usernameInvalidtext,
          prefixIcon: LottieAnimations.person,
          borderRadius: 30,
          hint: "Username",
          fillColor: Colors.white,
          isFilled: true,
          contentPadding: const EdgeInsets.all(0),
        ),
        const SizedBox(
          height: 20,
        ),
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
        Utils.customTextFormField(
          inputController: _passwordController,
          invalidText: AppStrings.passwordInvalidtext,
          prefixIcon: LottieAnimations.lock,
          borderRadius: 30,
          hint: "Password",
          fillColor: Colors.white,
          isFilled: true,
          contentPadding: const EdgeInsets.all(0),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.zero),
                overlayColor:
                    MaterialStateProperty.all(Colors.white.withOpacity(0))),
            onPressed: () {},
            child: Text(
              "${AppStrings.authForgotPassword}?",
              style: AppFonts.headerStyle(
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
          onPressed: () {},
          buttonText: AppStrings.authSignUp,
        ),
      ]),
    );
  }
}
