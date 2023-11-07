import 'package:infoprofile_demo/services/network/base_api_service.dart';
import 'package:infoprofile_demo/services/network/network_api_service.dart';

import '../../resources/api_payloads.dart';
import '../../resources/urls.dart';

class UserRepository {
  final BaseApiService _apiService = NetworkApiService();

  Future<dynamic> editProfileApi({
    required String accesstoken,
    required Map<String, dynamic> apiPayLoad,
  }) async {
    try {
      return await _apiService.patchApiCall(
        url: AppUrls.editProfile,
        header: ApiPayload.bearerTokenHeader(bearerToken: accesstoken),
        data: apiPayLoad,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> userFeedsApi({
    required String accessToken,
    required String pageNo,
  }) async {
    try {
      return await _apiService.getApiCall(
          url: AppUrls.userFeed,
          header: ApiPayload.bearerTokenHeader(bearerToken: accessToken),
          params: 'pageNo=$pageNo&limit=50');
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> userProfileApi({
    required String accessToken,
    required String userId,
  }) async {
    try {
      return await _apiService.getApiCall(
        url: AppUrls.userProfile,
        header: ApiPayload.bearerTokenHeader(bearerToken: accessToken),
        params: 'userId=$userId',
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> userSearchApi({
    required String accessToken,
    required String name,
  }) async {
    try {
      return await _apiService.getApiCall(
          url: AppUrls.userSearch,
          header: ApiPayload.bearerTokenHeader(bearerToken: accessToken),
          params: 'name=$name');
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getAllUsers({
    required String accessToken,
  }) async {
    try {
      return await _apiService.getApiCall(
        url: AppUrls.allUser,
        header: ApiPayload.bearerTokenHeader(bearerToken: accessToken),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> logOutApi({
    required String accessToken,
  }) async {
    try {
      return await _apiService.postApiCall(
        url: AppUrls.logOut,
        header: ApiPayload.bearerTokenHeader(bearerToken: accessToken),
      );
    } catch (e) {
      rethrow;
    }
  }
}
