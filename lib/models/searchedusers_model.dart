

import 'dart:convert';

SearchUserModel searchUserModelFromJson(dynamic value) => SearchUserModel.fromJson(value);

String searchUserModelToJson(SearchUserModel data) => json.encode(data.toJson());

class SearchUserModel {
    int statusCode;
    String type;
    List<Datum> data;

    SearchUserModel({
        required this.statusCode,
        required this.type,
        required this.data,
    });

    factory SearchUserModel.fromJson(Map<String, dynamic> json) => SearchUserModel(
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
    String fullName;
    String profilePic;

    Datum({
        required this.id,
        required this.username,
        required this.fullName,
        required this.profilePic,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        username: json["username"],
        fullName: json["fullName"],
        profilePic: json["profilePic"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "fullName": fullName,
        "profilePic": profilePic,
    };
}
