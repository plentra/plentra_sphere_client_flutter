abstract class GetWishlist {
  void onResult(
    String appName,
    int totalItemCount,
    int itemsInThisPage,
    int itemsPerPage,
    List<dynamic> items,
  );

  void onLoading();

  void onLoadfinished();

  void onNextPage(int page);

  void onEmpty();

  void onNotLoggedIn();

  void onError(dynamic error);

  void onNoNextPage();

  void onAppNotActive(String appName);
}
