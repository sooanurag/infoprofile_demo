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

  // post urls:-
  static const createPost = "$base/createPost";
  static const deletePost = "$base/deletePost";
  static const editPost = "$base/editPost";
  // likes
  static const getPostLikes = "$base/getPostLikes";
  static const postLike = "$base/postLike";
  static const postDislike = "$base/postDislike";
  //comments
  static const createComment = "$base/createComment";
  static const deleteComment = "$base/deleteComment";
  static const editComment = "$base/editComment";
  static const listComments = "$base/listComments";
  //report
  static const reportPost = "$base/reportPost";

  // profile
  static const followUser = "$base/followUser";
  static const getFollowers = "$base/getFollowers";
  static const getFollowing = "$base/getFollowing";
  static const unfollowUser = "$base/unfollowUser";

  // user
  static const editProfile = "$base/editProfile";
    // user home-feeds
  static const userFeed = "$base/userFeed";
    // get user/others profile-info
  static const userProfile = "$base/userProfile";
  


  

}
