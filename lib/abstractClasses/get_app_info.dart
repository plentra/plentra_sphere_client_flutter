abstract class GetAppInfo {
  void onResult(
    String appName,
    String appIcon,
    int appType,
    Map<String, dynamic> appLocation,
  );
  void onLoading();
  void onHomeCover(String homeCover);
  void onLoadfinished();
  void onError(dynamic error);
  void onAppNotActive(String appName);
}
