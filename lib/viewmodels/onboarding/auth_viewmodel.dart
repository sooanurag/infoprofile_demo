import 'package:infoprofile_demo/repository/auth/auth_repo.dart';
import 'package:infoprofile_demo/resources/api_payloads.dart';

class AuthViewModel {
  static void onSubmitSignUp({
    required String inputEmail,
    required String inputUsername,
    required String inputPassword,
  }) {
    AuthRepository()
        .signUpApi(
            data: ApiPayload.signUpData(
          username: inputUsername,
          email: inputEmail,
          password: inputPassword,
        ))
        .then((value) {})
        .onError((error, stackTrace) => null);
  }
}
