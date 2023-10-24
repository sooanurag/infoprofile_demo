class FeedsViewModel {
  static Future<void> feedsRefreshHandler() async {
    // refersh feeds api-call
    return await Future.delayed(const Duration(seconds: 2)); //placeholder
  }
}
