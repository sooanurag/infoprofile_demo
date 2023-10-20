import 'package:flutter/material.dart';
import 'package:infoprofile_demo/components/onboarding/auth/forgot_password_form.dart';
import 'package:infoprofile_demo/components/onboarding/auth/signin_form.dart';
import 'package:infoprofile_demo/components/onboarding/auth/verify_user_form.dart';
import 'package:infoprofile_demo/resources/strings.dart';

import '../../components/onboarding/auth/signup_form.dart';

class AuthProvider with ChangeNotifier {
  String _authType = AppStrings.authLogIn;
  String get authType => _authType;
  void setAuthType({required String authtype}) {
    _authType = authtype;
    if (authType == AppStrings.authLogIn) {
      setAuthTypeSubHead(
          authtypeSubHead: AppStrings.authSubHeaders[AppStrings.authLogIn]);
      setAuthTypePrefix(authtypePrefix: AppStrings.prefixSignUp);
      setFormWidget(formWidget: const SignInForm());
    } else if (authType == AppStrings.authSignUp) {
      setAuthTypeSubHead(
          authtypeSubHead: AppStrings.authSubHeaders[AppStrings.authSignUp]);
      setAuthTypePrefix(authtypePrefix: AppStrings.prefixLogin);
      setFormWidget(formWidget: const SignUpForm());
    } else if (authType == AppStrings.authForgotPassword) {
      setAuthTypeSubHead(
          authtypeSubHead:
              AppStrings.authSubHeaders[AppStrings.authForgotPassword]);
      setFormWidget(formWidget: const ForgotPasswordForm());
    } else if (authType == AppStrings.authOTP) {
      setAuthTypeSubHead(
          authtypeSubHead: AppStrings.authSubHeaders[AppStrings.authOTP]);
    } else if (authType == AppStrings.authVerifyUserEmail) {
      setAuthTypeSubHead(
          authtypeSubHead:
              AppStrings.authSubHeaders[AppStrings.authVerifyUserEmail]);
      setFormWidget(formWidget: const VerifyUserForm());
    }

    notifyListeners();
  }

  String _authTypePrefix = AppStrings.prefixSignUp;
  String get authTypePrefix => _authTypePrefix;
  void setAuthTypePrefix({required String authtypePrefix}) {
    _authTypePrefix = authtypePrefix;
    notifyListeners();
  }

  String _authTypeSubHead = AppStrings.authSubHeaders[AppStrings.authLogIn];
  String get authTypeSubHead => _authTypeSubHead;
  void setAuthTypeSubHead({required String authtypeSubHead}) {
    _authTypeSubHead = authtypeSubHead;
    notifyListeners();
  }

  Widget _formWidget = const SignInForm();
  Widget get formWidget => _formWidget;
  void setFormWidget({required Widget formWidget}) {
    _formWidget = formWidget;
    notifyListeners();
  }

  bool _isOTPsent = false;
  bool get isOTPsent => _isOTPsent;
  void setIsOTPsent({required bool status}) {
    _isOTPsent = status;
    notifyListeners();
  }

  bool _isSignUp = false;
  bool get isSignUp => _isSignUp;
  void setIsSignUp({required bool status}) {
    _isSignUp = status;
    notifyListeners();
  }
}
