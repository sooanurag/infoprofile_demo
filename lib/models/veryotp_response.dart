

import 'dart:convert';

VerifyOtpResponseModel verifyOtpResponseModelFromJson(dynamic value) => VerifyOtpResponseModel.fromJson(value);

String verifyOtpResponseModelToJson(VerifyOtpResponseModel data) => json.encode(data.toJson());

class VerifyOtpResponseModel {
    int statusCode;
    String type;
    Data data;

    VerifyOtpResponseModel({
        required this.statusCode,
        required this.type,
        required this.data,
    });

    factory VerifyOtpResponseModel.fromJson(Map<String, dynamic> json) => VerifyOtpResponseModel(
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
    String resetPasswordToken;

    Data({
        required this.resetPasswordToken,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        resetPasswordToken: json["resetPasswordToken"],
    );

    Map<String, dynamic> toJson() => {
        "resetPasswordToken": resetPasswordToken,
    };
}
