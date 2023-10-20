class AppUrls {
  static const base = "https://harshitsocial.appskeeper.in/api/v1/user";
  // flow: signUp(sends otp to email) => verifyUser
  static const signUp = "$base/signup";
  static const verifyUser = "$base/verifyUser";
  // logIn => accessToken(return)
  static const logIn = "$base/login";
  // logOut(no parameters req, header: acessToken)
  static const logOut = "$base/logout";
  // forgotPassword(sends otp) => verifyOTP =>  resetPassword(with bearerToken)
  static const forgotPassword = "$base/forgot-password";
  static const verifyOTP = "$base/verifyOTP";
  static const resetPassword = "$base/reset-password";
  // resend OTP
  static const resendOTP = "$base/send-otp";
}
