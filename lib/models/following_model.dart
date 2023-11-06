

import 'dart:convert';

FollowingModel followingModelFromJson(dynamic value) => FollowingModel.fromJson(value);

String followingModelToJson(FollowingModel data) => json.encode(data.toJson());

class FollowingModel {
    int statusCode;
    String type;
    Data data;

    FollowingModel({
        required this.statusCode,
        required this.type,
        required this.data,
    });

    factory FollowingModel.fromJson(Map<String, dynamic> json) => FollowingModel(
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
    List<Following> following;

    Data({
        required this.following,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        following: List<Following>.from(json["Following"].map((x) => Following.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Following": List<dynamic>.from(following.map((x) => x.toJson())),
    };
}

class Following {
    User user;

    Following({
        required this.user,
    });

    factory Following.fromJson(Map<String, dynamic> json) => Following(
        user: User.fromJson(json["User"]),
    );

    Map<String, dynamic> toJson() => {
        "User": user.toJson(),
    };
}

class User {
    String id;
    String username;
    String email;
    String profilePic;
    int accountVerify;

    User({
        required this.id,
        required this.username,
        required this.email,
        required this.profilePic,
        required this.accountVerify,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        username: json["username"],
        email: json["email"],
        profilePic: json["profilePic"],
        accountVerify: json["accountVerify"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "email": email,
        "profilePic": profilePic,
        "accountVerify": accountVerify,
    };
}
