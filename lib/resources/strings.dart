class AppStrings {
  static const List<String> onBoardingHeaders = [
    "Connect with the people arround you.",
    "View information with the help of visiting card.",
    "You do much more with Infoprofile."
  ];
  static const String subHeading =
      "A community which defines you the way you want and increase your social worth.";
  static const String authLogIn = "Log In";
  static const String authSignUp = "Sign Up";
  static const String authProfileDetails = "Profile Details";
  static const String authForgotPassword = "Forgot Password";
  static const String authOTP = "OTP Authentication";
  static const String authSendOTP = "Send OTP";
  static const String authreSendOTP = "Resend OTP";
  static const String authVerifyOTP = "Verify";
  static const String authVerifyUserEmail = "Email Verification";
  static Map<String, dynamic> authSubHeaders = {
    authVerifyUserEmail:
        "Please enter 4-digits code sent on your Email address.",
    authLogIn:
        "Enter your username or email and password or use social-media authentication to login.",
    authSignUp:
        "Enter your email address and password to register yourself as new user.",
    authProfileDetails:
        "Please provide the following details to get yourself started.",
    authForgotPassword:
        "Enter the email address associated with your account so that we can send an OTP to reset your password.",
    authOTP: "Please enter 4-digits code sent on your Email address.",
  };

  //log-in
  static const emailInvalidtext = "Enter your email address!";
  static const usernameInvalidtext = "Crete a unique username!";
  static const passwordInvalidtext = "Enter your password!";
  static const prefixSignUp = "Don't have an account?";
  static const prefixLogin = "Already have an account?";

  //drawer
  static List<String> drawerTilesTitles = [
    "Profile",
    "Premium",
    "Favourits",
    "Archive",
    "Acitvity",
    "Settings",
  ];
  // EXCEPTIONS
  static const emailNotVerified =
      "Error during communication: ACCOUNT_NOT_VERIFIED";
}
