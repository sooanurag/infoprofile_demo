class PrefrencesSettings {
  String? accesstoken;
  String? username;
  String? email;
  int? followerCount;
  int? followingCount;
  int? postCount;

  PrefrencesSettings({
    required this.accesstoken,
    required this.email,
    required this.username,
    required this.followerCount,
    required this.followingCount,
    required this.postCount,
  });
}
