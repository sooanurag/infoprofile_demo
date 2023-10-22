import 'package:flutter/material.dart';
import 'package:infoprofile_demo/models/login_response_model.dart';
import 'package:infoprofile_demo/models/prefrences_settings_model.dart';
import 'package:infoprofile_demo/models/veryotp_response.dart';
import 'package:infoprofile_demo/repository/auth/auth_repo.dart';
import 'package:infoprofile_demo/resources/api_payloads.dart';

import 'package:infoprofile_demo/resources/routes.dart';
import 'package:infoprofile_demo/services/prefrences_service.dart';

import 'package:infoprofile_demo/utils/utils.dart';

import '../../components/onboarding/auth/newpassword_form.dart';
import '../../providers/onboarding/auth_provider.dart';
import '../../resources/strings.dart';

class AuthViewModel {
  static Future<void> onSubmitSignUp({
    required String inputEmail,
    required String inputUsername,
    required String inputPassword,
    required BuildContext context,
    required AuthProvider authProvider,
  }) async {
    await AuthRepository()
        .signUpApi(
            data: ApiPayload.signUpData(
      username: inputUsername,
      email: inputEmail,
      password: inputPassword,
    ))
        .then((value) {
      authProvider.setAuthType(authtype: AppStrings.authVerifyUserEmail);
      authProvider.setInputPassword(password: inputPassword);
      Navigator.of(context).pop();
      Utils.showToastMessage(
          (value['statusCode'] == 200) ? "Signed In!" : "Failed");
    }).onError((error, stackTrace) {
      Navigator.of(context).pop();
      Utils.showToastMessage(error.toString());
    });
  }

  static Future<void> onSubmitLogIn({
    required String inputEmail,
    required String inputPassword,
    required BuildContext context,
    required AuthProvider authProvider,
  }) async {
    await AuthRepository()
        .logInApi(
            data: ApiPayload.loginData(
      email: inputEmail,
      password: inputPassword,
    ))
        .then((value) {
      final loginResponseData = LoginResponseModel.fromJson(value);
      final userData = loginResponseData.data;
      PrefrenceService().savePrefrences(
          prefrencesSettings: PrefrencesSettings(
        accesstoken: userData.accessToken,
        email: userData.user.email,
        username: userData.user.username,
        followerCount: userData.user.followerCount,
        followingCount: userData.user.followingCount,
        postCount: userData.user.postCount,
      ));
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacementNamed(context, Routes.feeds);
    }).onError((error, stackTrace) {
      Navigator.pop(context);
      Utils.alertDialog(
          context: context,
          actionsPadding: EdgeInsets.zero,
          actionsAlignment: MainAxisAlignment.center,
          inputContent: Text(error.toString()),
          inputActions: [
            (error.toString() != AppStrings.emailNotVerified)
                ? TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("close"),
                  )
                : TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      authProvider.setSignUpEmail(email: inputEmail);
                      authProvider.setInputPassword(password: inputPassword);
                      authProvider.setAuthType(
                          authtype: AppStrings.authVerifyUserEmail);
                    },
                    child: const Text("Verify"),
                  ),
          ]);
    });
  }

  static Future<void> onSubmitVerifyOTP({
    required String inputEmail,
    required String inputOTP,
    required BuildContext context,
    required AuthProvider providerValue,
  }) async {
    if (inputOTP.length == 4) {
      await AuthRepository()
          .verifyUserApi(
              data: ApiPayload.verifyUserData(
        email: inputEmail,
        otp: inputOTP,
      ))
          .then((value) async {
        providerValue.setIsVerfyingEmailStatus(status: false);
        //login-call
        await onSubmitLogIn(
          inputEmail: inputEmail,
          inputPassword: providerValue.inputPassword,
          context: context,
          authProvider: providerValue,
        );
        if (context.mounted) {
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacementNamed(context, Routes.feeds);
          providerValue.clearCredentials();
          Utils.showToastMessage("Loged In");
        }
      }).onError((error, stackTrace) {
        Navigator.of(context).pop();
        providerValue.setIsVerfyingEmailStatus(status: false);
        Utils.showToastMessage(error.toString());
      });
    }
  }

  static Future<void> onSubmitSendOTP({
    required String inputEmail,
    required BuildContext context,
    required AuthProvider authProvider,
  }) async {
    await AuthRepository().forgotPassword(inputEmail: inputEmail).then((value) {
      Navigator.pop(context);
      authProvider.setAuthType(authtype: AppStrings.authOTP);
      authProvider.setIsOTPsent(status: true);
      authProvider.setSignUpEmail(email: inputEmail);
    }).onError((error, stackTrace) {
      Navigator.pop(context);
      Utils.alertDialog(
          context: context,
          inputContent: Text(error.toString()),
          inputActions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("close"),
            ),
          ]);
    });
  }

  static Future<void> onSubmitForgotPasswordOTPverify({
    required String inputEmail,
    required String otp,
    required BuildContext context,
    required AuthProvider authProvider,
  }) async {
    debugPrint('otp: $otp');
    await AuthRepository()
        .verifyForgotPasswordOTP(
      inputEmail: inputEmail,
      otp: otp,
    )
        .then((value) {
      Navigator.pop(context); // loading pop
      VerifyOtpResponseModel responseData =
          VerifyOtpResponseModel.fromJson(value);
      authProvider.setAuthType(authtype: AppStrings.authNewPassword);
      authProvider.setFormWidget(
          formWidget: NewPasswordForm(
              bearerToken: responseData.data.resetPasswordToken));
    }).onError((error, stackTrace) {
      Navigator.pop(context); // loading pop
      Utils.alertDialog(
          context: context,
          inputContent: Text(error.toString()),
          inputActions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("close"),
            ),
          ]);
    });
  }

  static Future<void> onSubmitNewPassword({
    required String newPassword,
    required String bearerToken,
    required BuildContext context,
    required AuthProvider authProvider,
  }) async {
    await AuthRepository()
        .newPassword(newPassword: newPassword, bearerToken: bearerToken)
        .then((value) {
      // sucess status - set authtype to login
      Navigator.pop(context);
      Utils.showToastMessage("Success");
      authProvider.setAuthType(authtype: AppStrings.authLogIn);
    }).onError((error, stackTrace) {
      Navigator.pop(context); // loading pop
      Utils.alertDialog(
          context: context,
          inputContent: Text(error.toString()),
          inputActions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("close"),
            ),
          ]);
    });
  }
}
