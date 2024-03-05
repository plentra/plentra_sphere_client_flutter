abstract class GetPage {
  void onResult(
      String appName, String appIcon, String pageTitle, String pageBody);
  void onLoading();
  void onLoadfinished();
  void onHomeCover(String cover);
  void onAppLocation(String appLocation, double latitude, double longitude);
  void onAnnouncement(String announcementBody);
  void onError(dynamic error);
  void onUnderConstruction();
  void onAppNotActive(String appName);
  void onNotFound();
}
