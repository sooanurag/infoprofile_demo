

import 'dart:convert';

SearchedUsersModel searchedUsersModelFromJson(dynamic value) => SearchedUsersModel.fromJson(value);

String searchedUsersModelToJson(SearchedUsersModel data) => json.encode(data.toJson());

class SearchedUsersModel {
    int statusCode;
    String type;
    List<dynamic> data;

    SearchedUsersModel({
        required this.statusCode,
        required this.type,
        required this.data,
    });

    factory SearchedUsersModel.fromJson(Map<String, dynamic> json) => SearchedUsersModel(
        statusCode: json["statusCode"],
        type: json["type"],
        data: List<dynamic>.from(json["data"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "type": type,
        "data": List<dynamic>.from(data.map((x) => x)),
    };
}
