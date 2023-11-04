

import 'dart:convert';

CommentsModel commentsModelFromJson(dynamic value) => CommentsModel.fromJson(value);

String commentsModelToJson(CommentsModel data) => json.encode(data.toJson());

class CommentsModel {
    int statusCode;
    String type;
    Data data;

    CommentsModel({
        required this.statusCode,
        required this.type,
        required this.data,
    });

    factory CommentsModel.fromJson(Map<String, dynamic> json) => CommentsModel(
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
    List<Comment> comments;

    Data({
        required this.comments,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        comments: List<Comment>.from(json["Comments"].map((x) => Comment.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Comments": List<dynamic>.from(comments.map((x) => x.toJson())),
    };
}

class Comment {
    String id;
    String comment;
    User user;

    Comment({
        required this.id,
        required this.comment,
        required this.user,
    });

    factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["_id"],
        comment: json["comment"],
        user: User.fromJson(json["User"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "comment": comment,
        "User": user.toJson(),
    };
}

class User {
    String id;
    String username;
    String email;
    String profilePic;

    User({
        required this.id,
        required this.username,
        required this.email,
        required this.profilePic,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        username: json["username"],
        email: json["email"],
        profilePic: json["profilePic"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "email": email,
        "profilePic": profilePic,
    };
}
