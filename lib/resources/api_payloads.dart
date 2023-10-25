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
        "otp": otp,
      };

  static Map<String, String> resetPasswordData({
    required String newPassword,
  }) =>
      {
        'newPassword': newPassword,
      };

  static Map<String, String> basicAuthHeader = {
    'Authorization': 'Basic c29jaWFsTWVkaWE6c29jaWFsQDEyMw==',
    'Content-Type': 'application/json; charset=UTF-8',
  };
  static Map<String, String> contentTypeHeader = {
    'Content-Type': 'application/json; charset=UTF-8',
  };
  static Map<String, String> bearerTokenHeader({required String bearerToken}) =>
      {
        'Authorization': bearerToken,
        'Content-Type': 'application/json; charset=UTF-8'
      };

  // end On-boarding payloads

  // post payloads
  //==== post
  static Map<String, String> createPostData({
    required String postUrl,
    required String mediaType,
    String? caption,
  }) =>
      {
        "url": postUrl,
        "mediaType": mediaType,
        "caption": caption ?? "",
      };

  static Map<String, String> editPostData({
    String? caption,
  }) =>
      {
        "caption": caption ?? "",
      };

  static Map<String, String> createCommentData({
    required String comment,
  }) =>
      {
        "comment": comment,
      };

  static Map<String, String> editCommentData({
    required String comment,
  }) =>
      {
        "comment": comment,
      };

  // end

  // profile payloads
  static Map<String, dynamic> editProfiletData({
    String? username,
    String? profilePic,
    String? profileBio,
  }) =>
      {
        "username": username,
        "profilePic": profilePic,
        "profileBio": profileBio,
      };

  // end
}
