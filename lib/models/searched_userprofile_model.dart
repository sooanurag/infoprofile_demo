

import 'dart:convert';

SearchUserProfileModel searchUserProfileModelFromJson(dynamic value) => SearchUserProfileModel.fromJson(value);

String searchUserProfileModelToJson(SearchUserProfileModel data) => json.encode(data.toJson());

class SearchUserProfileModel {
    int statusCode;
    String type;
    Data data;

    SearchUserProfileModel({
        required this.statusCode,
        required this.type,
        required this.data,
    });

    factory SearchUserProfileModel.fromJson(Map<String, dynamic> json) => SearchUserProfileModel(
        statusCode: json["statusCode"],
        type: json["type"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "type": type,
        "data": data.toJson(),
    };
}

class Data {
    List<UserPofile> userPofile;

    Data({
        required this.userPofile,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        userPofile: List<UserPofile>.from(json["UserPofile"].map((x) => UserPofile.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "UserPofile": List<dynamic>.from(userPofile.map((x) => x.toJson())),
    };
}

class UserPofile {
    String username;
    String email;
    String fullName;
    String profilePic;
    String profileBio;
    int followerCount;
    int followingCount;
    int postCount;
    List<UserPost> userPosts;
    bool isFollowing;
    bool isFollower;

    UserPofile({
        required this.username,
        required this.email,
        required this.fullName,
        required this.profilePic,
        required this.profileBio,
        required this.followerCount,
        required this.followingCount,
        required this.postCount,
        required this.userPosts,
        required this.isFollowing,
        required this.isFollower,
    });

    factory UserPofile.fromJson(Map<String, dynamic> json) => UserPofile(
        username: json["username"],
        email: json["email"],
        fullName: json["fullName"],
        profilePic: json["profilePic"],
        profileBio: json["profileBio"],
        followerCount: json["followerCount"],
        followingCount: json["followingCount"],
        postCount: json["postCount"],
        userPosts: List<UserPost>.from(json["UserPosts"].map((x) => UserPost.fromJson(x))),
        isFollowing: json["isFollowing"],
        isFollower: json["isFollower"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "fullName": fullName,
        "profilePic": profilePic,
        "profileBio": profileBio,
        "followerCount": followerCount,
        "followingCount": followingCount,
        "postCount": postCount,
        "UserPosts": List<dynamic>.from(userPosts.map((x) => x.toJson())),
        "isFollowing": isFollowing,
        "isFollower": isFollower,
    };
}

class UserPost {
    String id;
    String userId;
    String url;
    String caption;
    int likeCount;
    int commentCount;
    DateTime createdAt;
    bool isLiked;

    UserPost({
        required this.id,
        required this.userId,
        required this.url,
        required this.caption,
        required this.likeCount,
        required this.commentCount,
        required this.createdAt,
        required this.isLiked,
    });

    factory UserPost.fromJson(Map<String, dynamic> json) => UserPost(
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
