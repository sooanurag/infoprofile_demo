

import 'dart:convert';

NotificationsModel notificationsModelFromJson(dynamic value) => NotificationsModel.fromJson(value);

String notificationsModelToJson(NotificationsModel data) => json.encode(data.toJson());

class NotificationsModel {
    int statusCode;
    String type;
    List<Datum> data;

    NotificationsModel({
        required this.statusCode,
        required this.type,
        required this.data,
    });

    factory NotificationsModel.fromJson(Map<String, dynamic> json) => NotificationsModel(
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
    String senderId;
    String receiverId;
    String activityId;
    String status;
    String type;
    String title;
    String message;
    String image;

    Datum({
        required this.id,
        required this.senderId,
        required this.receiverId,
        required this.activityId,
        required this.status,
        required this.type,
        required this.title,
        required this.message,
        required this.image,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        senderId: json["senderId"],
        receiverId: json["receiverId"],
        activityId: json["activityId"],
        status: json["status"],
        type: json["type"],
        title: json["title"],
        message: json["message"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "senderId": senderId,
        "receiverId": receiverId,
        "activityId": activityId,
        "status": status,
        "type": type,
        "title": title,
        "message": message,
        "image": image,
    };
}
