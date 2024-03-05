abstract class GetItemsSearch {
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
  void onNextPage(int nextPage);
  void onHomeCover(String cover);
  void onEmpty(String appName, String appIcon);
  void onError(dynamic error);
  void onUnderConstruction();
  void onAppNotActive(String appName);
  void onNotFound();
  void onNoNextPage();
}
