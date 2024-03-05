abstract class GetItems {
  void onResult(
    String appName,
    String appIcon,
    String categoryName,
    String categoryIcon,
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
  void onHomeCover(String cover);
  void onEmpty(
      String appName, String appIcon, String categoryName, String categoryIcon);
  void onError(dynamic error);
  void onUnderConstruction();
  void onAppNotActive(String appName);
  void onNotFound();
  void onNoNextPage();
}
