import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../utils/app_exceptions.dart';
import 'base_api_service.dart';

class NetworkApiService extends BaseApiService {
  @override
  Future getApiCall({
    required String url,
    Map<String, String>? header,
    String? params,
  }) async {
    dynamic apiResponse;
    try {
      final response = await http
          .get(
            Uri.parse((params == null) ? url : '$url?$params'),
            headers: header,
          )
          .timeout(const Duration(seconds: 10));
      apiResponse = response;
      debugPrint("response: ${apiResponse.body}");
      debugPrint("==========================");
    } on SocketException {
      throw FetchDataException("No internet");
    }

    return returnResponse(apiResponse);
  }

  @override
  Future postApiCall({
    required String url,
    dynamic data,
    Map<String, String>? header,
    String? params,
  }) async {
    dynamic apiResponse;
    debugPrint('data: ${data.toString()}');
    try {
      final response = await http
          .post(
            Uri.parse((params == null) ? url : 'url?$params'),
            body: jsonEncode(data),
            headers: header,
          )
          .timeout(const Duration(seconds: 10));
      apiResponse = response;
      debugPrint("response: ${apiResponse.body}");
      debugPrint("==================");
    } on SocketException {
      throw FetchDataException("No Internet");
    }

    return returnResponse(apiResponse);
  }

  @override
  Future deleteApiCall({
    required String url,
    data,
    Map<String, String>? header,
    String? params,
  }) async {
    dynamic apiResponse;
    try {
      dynamic response = await http
          .delete(
            Uri.parse((params == null) ? url : 'url?$params'),
            headers: header,
            body: jsonEncode(data),
          )
          .timeout(const Duration(seconds: 10));
      apiResponse = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet");
    }
    return apiResponse;
  }

  @override
  Future patchApiCall({
    required String url,
    data,
    Map<String, String>? header,
    String? params,
  }) async {
    dynamic apiResponse;
    try {
      dynamic response = await http
          .patch(
            Uri.parse((params == null) ? url : '$url?$params'),
            headers: header,
            body: jsonEncode(data),
          )
          .timeout(
            const Duration(seconds: 10),
          );
      apiResponse = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet");
    }
    return apiResponse;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.body);
      case 400:
        throw BadRequestException(jsonDecode(response.body)["type"]);
      case 404:
        throw UnauthorizedException(jsonDecode(response.body)["type"]);
      default:
        throw FetchDataException(jsonDecode(response.body)["type"]);
    }
  }
}
