class ApiPayload {

  // On-boarding payloads

  static Map<String, String> resendOTPData({
    required String email,
  }) =>
      {
        'email': email,
      };

  static Map<String, String> signUpData({
    required String username,
    required String email,
    required String password,
  }) =>
      {
        'username': username,
        'email': email,
        'password': password,
      };

  static Map<String, String> verifyUserData({
    required String email,
    required String otp,
  }) =>
      {
        'email': email,
        'otp': otp,
      };

  static Map<String, String> loginData({
    required String email,
    required String password,
  }) =>
      {
        'email': email,
        'password': password,
      };
  
  static Map<String, String> forgotPasswordData({
    required String email,
  }) =>
      {
        'email': email,
      };

  static Map<String, String> verifyOTPData({
    required String email,
    required String otp,
  }) =>
      {
        'email': email,
        'otp': otp,
      };
  
  static Map<String, String> resetPasswordData({
    required String newPassword,

  }) =>
      {
        'newPassword': newPassword,
      };

  static Map<String, String> basicAuthHeader = {
    'Authorization' : 'Basic c29jaWFsTWVkaWE6c29jaWFsQDEyMw==',
    'Content-Type': 'application/json; charset=UTF-8',
  };
  static Map<String, String> contentTypeHeader = {
    'Content-Type': 'application/json; charset=UTF-8',
  };
  static Map<String, String> bearerTokenHeader({required String bearerToken})=> {
    'Authorization' : bearerToken,
    'Content-Type': 'application/json; charset=UTF-8'
  };

  // end On-boarding payloads
}
