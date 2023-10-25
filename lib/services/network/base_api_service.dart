abstract class BaseApiService {
  Future<dynamic> getApiCall({
    required String url,
    Map<String, String>? header,
    String? params,
  });
  Future<dynamic> postApiCall({
    required String url,
    dynamic data,
    Map<String, String>? header,
    String? params,
  });

  Future<dynamic> deleteApiCall({
    required String url,
    dynamic data,
    Map<String, String>? header,
    String? params,
  });

  Future<dynamic> patchApiCall({
    required String url,
    dynamic data,
    Map<String, String>? header,
    String? params,
  });
}
