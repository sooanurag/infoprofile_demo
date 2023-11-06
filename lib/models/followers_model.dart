

import 'dart:convert';

FollowersModel followersModelFromJson(dynamic value) => FollowersModel.fromJson(value);

String followersModelToJson(FollowersModel data) => json.encode(data.toJson());

class FollowersModel {
    int statusCode;
    String type;
    Data data;

    FollowersModel({
        required this.statusCode,
        required this.type,
        required this.data,
    });

    factory FollowersModel.fromJson(Map<String, dynamic> json) => FollowersModel(
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
    List<Follower> followers;

    Data({
        required this.followers,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        followers: List<Follower>.from(json["Followers"].map((x) => Follower.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Followers": List<dynamic>.from(followers.map((x) => x.toJson())),
    };
}

class Follower {
    User user;

    Follower({
        required this.user,
    });

    factory Follower.fromJson(Map<String, dynamic> json) => Follower(
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
