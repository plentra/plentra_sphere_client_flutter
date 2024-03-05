abstract class GetLauncher {
  void onResult(
    String appName,
    String appIcon,
    String launcherName,
    String launcherIcon,
    int totalItemCount,
    int itemsInThisPage,
    int itemsPerPage,
    List<dynamic> items,
  );
  void onLoading();
  void onLoadfinished();
  void onAnnouncement(String announcementBody);
  void onAppLocation(String appLocation, double latitude, double longitude);
  void onNextPage(int nextPage);
  void onLauncherCover(String cover);
  void onEmpty(
      String appName, String appIcon, String launcherName, String launcherIcon);
  void onError(dynamic error);
  void onUnderConstruction();
  void onAppNotActive(String appName);
  void onNotFound();
  void onNoNextPage();
}
