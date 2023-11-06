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
    this.userId,
    this.accesstoken,
    this.email,
    this.username,
    this.fullName,
    this.profilePic,
    this.profileBio,
    this.followerCount,
    this.followingCount,
    this.postCount,
  });
}
