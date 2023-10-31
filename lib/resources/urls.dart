import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppUrls {
  static String base = dotenv.env['apibaseUrl']!;
  // flow: signUp(sends otp to email) => verifyUser
  static String signUp = "$base/signup";
  static String verifyUser = "$base/verifyUser";
  // logIn => accessToken(return)
  static String logIn = "$base/login";
  // logOut(no parameters req, header: acessToken)
  static String logOut = "$base/logout";
  // forgotPassword(sends otp) => verifyOTP =>  resetPassword(with bearerToken)
  static String forgotPassword = "$base/forgot-password";
  static String verifyOTP = "$base/verifyOTP";
  static String resetPassword = "$base/reset-password";
  // resend OTP
  static String resendOTP = "$base/send-otp";

  // post urls:-
  static String createPost = "$base/createPost";
  static String deletePost = "$base/deletePost";
  static String editPost = "$base/editPost";
  static String getUserPost = "$base/getUserPost";
  static String getMyPost = "$base/getMyPost";

  // likes
  static String getPostLikes = "$base/getPostLikes";
  static String postLike = "$base/postLike";
  static String postDislike = "$base/postDislike";
  //comments
  static String createComment = "$base/createComment";
  static String deleteComment = "$base/deleteComment";
  static String editComment = "$base/editComment";
  static String listComments = "$base/listComments";
  //report
  static String reportPost = "$base/reportPost";

  // profile
  static String followUser = "$base/followUser";
  static String getFollowers = "$base/getFollowers";
  static String getFollowing = "$base/getFollowing";
  static String unfollowUser = "$base/unfollowUser";

  // user
  static String editProfile = "$base/editProfile";
    // user home-feeds
  static String userFeed = "$base/userFeed";
    // get user/others profile-info
  static String userProfile = "$base/userProfile";
  static String userSearch = "$base/userSearch";

  


  

}
