abstract class GetHomeLoadMore {
  void onResult(
    int totalItemCount,
    int itemsInThisPage,
    int itemsPerPage,
    List<dynamic> items,
  );
  void onLoading();
  void onLoadfinished();

  void onNextPage(int nextPage);

  void onEmpty(String appName, String appIcon);
  void onError(dynamic error);
  void onUnderConstruction();
  void onAppNotActive(String appName);
  void onNotFound();
  void onNoNextPage();
}
