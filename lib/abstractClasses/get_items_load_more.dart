abstract class GetItemsLoadMore {
  void onResult(
    String categoryId,
    int totalItemCount,
    int itemsInThisPage,
    int itemsPerPage,
    List<dynamic> items,
  );
  void onLoading();
  void onLoadfinished();
  void onNextPage(int nextPage);
  void onEmpty();
  void onError(dynamic error);
  void onUnderConstruction();
  void onAppNotActive(String appName);
  void onNotFound();
  void onNoNextPage();
}
