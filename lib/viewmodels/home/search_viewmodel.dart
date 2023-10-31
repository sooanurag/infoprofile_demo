import 'package:flutter/material.dart';


import '../../repository/home/user_repo.dart';

class SearchViewModel {
  Future<dynamic> onSubmitSearch({
    required String accessToken,
    required String inputName,
    required BuildContext context,
  }) async {
    if(inputName.isNotEmpty){
    try {
      return await UserRepository().userSearchApi(
        accessToken: accessToken,
        name: inputName,
      );
    } catch (e) {
      rethrow;
    }}
  }
}
