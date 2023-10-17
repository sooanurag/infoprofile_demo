class UserModel {
  String? id;
  String? username;
  String? fullName;
  String? emailId;
  String? profilePicture;
  String? info;

  UserModel({
    this.id,
    this.username,
    this.fullName,
    this.emailId,
    this.profilePicture,
    this.info,
  });

  UserModel.fromMap({required Map<String, dynamic> map}) {
    id = map["_id"];
    username = map["username"];
    fullName = map["fullName"];
    emailId = map["emailId"];
    profilePicture = map["profilePicture"];
    info = map["info"];
  }

  Map<String, dynamic> toMap() {
    return {
      "_id": id,
      "username": username,
      "fullName": fullName,
      "emailId": emailId,
      "profilePicture": profilePicture,
      "info": info,
    };
  }
}
