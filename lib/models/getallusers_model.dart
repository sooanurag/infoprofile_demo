

import 'dart:convert';

GetAllUsersModel getAllUsersModelFromJson(dynamic value) => GetAllUsersModel.fromJson(value);

String getAllUsersModelToJson(GetAllUsersModel data) => json.encode(data.toJson());

class GetAllUsersModel {
    int statusCode;
    String type;
    List<Datum> data;

    GetAllUsersModel({
        required this.statusCode,
        required this.type,
        required this.data,
    });

    factory GetAllUsersModel.fromJson(Map<String, dynamic> json) => GetAllUsersModel(
        statusCode: json["statusCode"],
        type: json["type"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "type": type,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    String id;
    String username;
    String email;
    String password;
    String fullName;
    String profilePic;
    String profileBio;
    int accountVerify;
    int followerCount;
    int followingCount;
    int postCount;

    Datum({
        required this.id,
        required this.username,
        required this.email,
        required this.password,
        required this.fullName,
        required this.profilePic,
        required this.profileBio,
        required this.accountVerify,
        required this.followerCount,
        required this.followingCount,
        required this.postCount,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        username: json["username"],
        email: json["email"],
        password: json["password"],
        fullName: json["fullName"],
        profilePic: json["profilePic"],
        profileBio: json["profileBio"],
        accountVerify: json["accountVerify"],
        followerCount: json["followerCount"],
        followingCount: json["followingCount"],
        postCount: json["postCount"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "email": email,
        "password": password,
        "fullName": fullName,
        "profilePic": profilePic,
        "profileBio": profileBio,
        "accountVerify": accountVerify,
        "followerCount": followerCount,
        "followingCount": followingCount,
        "postCount": postCount,
    };
}
