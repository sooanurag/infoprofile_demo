import 'package:flutter/material.dart';
import 'package:infoprofile_demo/resources/api_payloads.dart';
import 'package:infoprofile_demo/resources/urls.dart';
import 'package:infoprofile_demo/services/network/base_api_service.dart';
import 'package:infoprofile_demo/services/network/network_api_service.dart';

class AuthRepository {
  final BaseApiService _apiService = NetworkApiService();

  Future<dynamic> signUpApi(
      {required dynamic data}) async {
    dynamic jsonResponse;
    try {
      dynamic response = await _apiService.postApiCall(
        url: AppUrls.signUp,
        data: data,
        header: ApiPayload.basicAuthHeader,
      );
      debugPrint(response.toString());
      jsonResponse = response;
    } catch (e) {
      rethrow;
    }
    return jsonResponse;
  }
  Future<dynamic> verifyUserApi(
      {required dynamic data}) async {
    dynamic jsonResponse;
    try {
      dynamic response = await _apiService.postApiCall(
        url: AppUrls.verifyUser,
        data: data,
        header: ApiPayload.contentTypeHeader,
      );
      debugPrint(response.toString());
      jsonResponse = response;
    } catch (e) {
      rethrow;
    }
    return jsonResponse;
  }

  Future<dynamic> logInApi(
      {required dynamic data}) async {
    dynamic jsonResponse;
    try {
      dynamic response = await _apiService.postApiCall(
        url: AppUrls.logIn,
        data: data,
        header: ApiPayload.contentTypeHeader,
      );
      debugPrint(response.toString());
      jsonResponse = response;
    } catch (e) {
      rethrow;
    }
    return jsonResponse;
  }

  Future<dynamic> logOutApi(
      {required String bearerToken}) async {
    dynamic jsonResponse;
    try {
      dynamic response = await _apiService.postApiCall(
        url: AppUrls.logOut,
        header: ApiPayload.bearerTokenHeader(bearerToken: bearerToken),
      );
      debugPrint(response.toString());
      jsonResponse = response;
    } catch (e) {
      rethrow;
    }
    return jsonResponse;
  }

  Future<dynamic> resendOTPApi(
      {required dynamic data}) async {
    dynamic jsonResponse;
    try {
      dynamic response = await _apiService.postApiCall(
        url: AppUrls.resendOTP,
        data: data,
        header: ApiPayload.contentTypeHeader,
      );
      debugPrint(response.toString());
      jsonResponse = response;
    } catch (e) {
      rethrow;
    }
    return jsonResponse;
  }
}
