abstract class UpdateCart {
  void onSuccess(message);
  void onLoading();
  void onLoadfinished();
  void onNotLoggedIn();
  void onError(error);
  void onAppNotActive(String appName);
}
