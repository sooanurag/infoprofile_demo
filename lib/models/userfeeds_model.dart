

import 'dart:convert';

UserFeedsModel userFeedsModelFromJson(dynamic value) => UserFeedsModel.fromJson(value);

String userFeedsModelToJson(UserFeedsModel data) => json.encode(data.toJson());

class UserFeedsModel {
    int statusCode;
    String type;
    List<UserFeed> userFeed;

    UserFeedsModel({
        required this.statusCode,
        required this.type,
        required this.userFeed,
    });

    factory UserFeedsModel.fromJson(Map<String, dynamic> json) => UserFeedsModel(
        statusCode: json["statusCode"],
        type: json["type"],
        userFeed: List<UserFeed>.from(json["User_Feed"].map((x) => UserFeed.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "type": type,
        "User_Feed": List<dynamic>.from(userFeed.map((x) => x.toJson())),
    };
}

class UserFeed {
    UserData userData;
    UserPosts userPosts;

    UserFeed({
        required this.userData,
        required this.userPosts,
    });

    factory UserFeed.fromJson(Map<String, dynamic> json) => UserFeed(
        userData: UserData.fromJson(json["UserData"]),
        userPosts: UserPosts.fromJson(json["UserPosts"]),
    );

    Map<String, dynamic> toJson() => {
        "UserData": userData.toJson(),
        "UserPosts": userPosts.toJson(),
    };
}

class UserData {
    String id;
    String username;
    String email;
    String profilePic;
    String fullName;

    UserData({
        required this.id,
        required this.username,
        required this.email,
        required this.profilePic,
        required this.fullName,
    });

    factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["_id"],
        username: json["username"],
        email: json["email"],
        profilePic: json["profilePic"],
        fullName: json["fullName"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "email": email,
        "profilePic": profilePic,
        "fullName": fullName,
    };
}

class UserPosts {
    String id;
    String userId;
    String url;
    String caption;
    int likeCount;
    int commentCount;
    DateTime createdAt;
    bool isLiked;

    UserPosts({
        required this.id,
        required this.userId,
        required this.url,
        required this.caption,
        required this.likeCount,
        required this.commentCount,
        required this.createdAt,
        required this.isLiked,
    });

    factory UserPosts.fromJson(Map<String, dynamic> json) => UserPosts(
        id: json["_id"],
        userId: json["userId"],
        url: json["url"],
        caption: json["caption"],
        likeCount: json["likeCount"],
        commentCount: json["commentCount"],
        createdAt: DateTime.parse(json["createdAt"]),
        isLiked: json["isLiked"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "url": url,
        "caption": caption,
        "likeCount": likeCount,
        "commentCount": commentCount,
        "createdAt": createdAt.toIso8601String(),
        "isLiked": isLiked,
    };
}
