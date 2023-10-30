class PrefrencesSettings {
  String? userId;
  String? accesstoken;
  String? username;
  String? fullName;
  String? profilePic;
  String? profileBio;
  String? email;
  int? followerCount;
  int? followingCount;
  int? postCount;

  PrefrencesSettings({
    required this.userId,
    required this.accesstoken,
    required this.email,
    required this.username,
    required this.fullName,
    required this.profilePic,
    required this.profileBio,
    required this.followerCount,
    required this.followingCount,
    required this.postCount,
  });
}
