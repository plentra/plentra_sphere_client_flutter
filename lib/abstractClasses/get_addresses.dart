abstract class GetAddresses {
  void onResult(
      String appName, int itemCount, List<Map<String, dynamic>> addresses);
  void onLoading();
  void onLoadfinished();
  void onEmpty();
  void onNotLoggedIn();
  void onError(dynamic error);
  void onAppNotActive(String appName);
}
