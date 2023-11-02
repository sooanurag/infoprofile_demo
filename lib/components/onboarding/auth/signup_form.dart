import 'package:flutter/material.dart';

import 'package:infoprofile_demo/providers/onboarding/auth_provider.dart';
import 'package:infoprofile_demo/resources/colors.dart';
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
  final _fullNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _usernameFocusNode = FocusNode();
  final _fullNameFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _usernameFocusNode.requestFocus();
    super.initState();
  }

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
      child: Form(
        key: _formKey,
        child: Column(children: [
          Utils.customTextFormField(
            inputController: _usernameController,
            currentFocusNode: _usernameFocusNode,
            cursorColor: AppColors.black,
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
            inputController: _fullNameController,
            currentFocusNode: _fullNameFocusNode,
            cursorColor: AppColors.black,
            textInputAction: TextInputAction.next,
            invalidText: AppStrings.fullNameInvalidtext,
            prefixIcon: LottieAnimations.person,
            borderRadius: 30,
            hint: "Full Name",
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
            cursorColor: AppColors.black,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
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
              currentFocusNode: _passwordFocusNode,
              textInputAction: TextInputAction.done,
              cursorColor: AppColors.black,
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
          const SizedBox(
            height: 20,
          ),
          Utils.textButton(
            onPressed: () async {
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
                authProvider.setSignUpEmail(
                    email: _emailController.text.trim());
                await AuthViewModel.onSubmitSignUp(
                  authProvider: authProvider,
                  context: context,
                  inputEmail: _emailController.text.trim(),
                  inputfullName: _fullNameController.text.trim(),
                  inputUsername: _usernameController.text.trim(),
                  inputPassword: _passwordController.text.trim(),
                );
              }
            },
            buttonText: AppStrings.authSignUp,
          ),
        ]),
      ),
    );
  }
}
