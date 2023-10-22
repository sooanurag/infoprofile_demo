
import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(dynamic json) => LoginResponseModel.fromJson(json);

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
    int statusCode;
    String type;
    Data data;

    LoginResponseModel({
        required this.statusCode,
        required this.type,
        required this.data,
    });

    factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
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
    User user;
    String accessToken;

    Data({
        required this.user,
        required this.accessToken,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: User.fromJson(json["user"]),
        accessToken: json["accessToken"],
    );

    Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "accessToken": accessToken,
    };
}

class User {
    String id;
    String username;
    String email;
    String password;
    int accountVerify;
    int followerCount;
    int followingCount;
    int postCount;
    DateTime createdAt;
    int v;

    User({
        required this.id,
        required this.username,
        required this.email,
        required this.password,
        required this.accountVerify,
        required this.followerCount,
        required this.followingCount,
        required this.postCount,
        required this.createdAt,
        required this.v,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        username: json["username"],
        email: json["email"],
        password: json["password"],
        accountVerify: json["accountVerify"],
        followerCount: json["followerCount"],
        followingCount: json["followingCount"],
        postCount: json["postCount"],
        createdAt: DateTime.parse(json["createdAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "email": email,
        "password": password,
        "accountVerify": accountVerify,
        "followerCount": followerCount,
        "followingCount": followingCount,
        "postCount": postCount,
        "createdAt": createdAt.toIso8601String(),
        "__v": v,
    };
}
