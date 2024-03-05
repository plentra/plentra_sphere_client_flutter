abstract class ClearWishlist {
  void onSuccess(dynamic message);

  void onLoading();

  void onLoadfinished();

  void onNotLoggedIn();

  void onError(dynamic error);

  void onAppNotActive(String appName);
}
