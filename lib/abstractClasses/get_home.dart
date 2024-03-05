abstract class GetHome {
  void onResult(
    String appName,
    String appIcon,
    int totalItemCount,
    int itemsInThisPage,
    int itemsPerPage,
    List<dynamic> items,
  );
  void onLoading();
  void onLoadfinished();
  void onPopup(String popupTitle, String popupMessage);
  void onAnnouncement(String announcementBody);
  void onMessage(String messageTitle, String messageBody);
  void onAppLocation(String appLocation, double latitude, double longitude);
  void onNextPage(int nextPage);
  void onHomeCover(String cover);
  void onFooter(String text, List<dynamic> pageLinks);
  void onEmpty(String appName, String appIcon);
  void onError(dynamic error);
  void onUnderConstruction();
  void onAppNotActive(String appName);
  void onNotFound();
  void onNoNextPage();
  void onItemRail(List<dynamic> categoryIds);
}
