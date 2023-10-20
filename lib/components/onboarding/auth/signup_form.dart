import 'package:flutter/material.dart';
import 'package:infoprofile_demo/providers/onboarding/auth_provider.dart';
import 'package:infoprofile_demo/viewmodels/onboarding/auth_viewmodel.dart';
import 'package:provider/provider.dart';

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
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _usernameFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _emailFocusNode.dispose();
    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(children: [
        Utils.customTextFormField(
          inputController: _usernameController,
          currentFocusNode: _usernameFocusNode,
          textInputAction: TextInputAction.next,
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
          currentFocusNode: _emailFocusNode,
          textInputAction: TextInputAction.next,
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
          currentFocusNode: _passwordFocusNode,
          textInputAction: TextInputAction.done,
          invalidText: AppStrings.passwordInvalidtext,
          prefixIcon: LottieAnimations.lock,
          borderRadius: 30,
          hint: "Password",
          fillColor: Colors.white,
          isFilled: true,
          contentPadding: const EdgeInsets.all(0),
        ),
        const SizedBox(
          height: 20,
        ),
        Utils.textButton(
          onPressed: () {
            AuthViewModel.onSubmitSignUp(
              inputEmail: _emailController.text.trim(),
              inputUsername: _usernameController.text.trim(),
              inputPassword: _passwordController.text.trim(),
            );
            authProvider.setAuthType(authtype: AppStrings.authVerifyUserEmail);
          },
          buttonText: AppStrings.authSignUp,
        ),
      ]),
    );
  }
}
