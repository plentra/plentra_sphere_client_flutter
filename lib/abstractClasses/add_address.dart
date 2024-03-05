abstract class AddAddress {
  void onSuccess(message);
  void onLoading();
  void onLoadfinished();
  void onNotLoggedIn();
  void onError(error);
  void onAppNotActive(String appName);
  void onAddressMaxLimitReached();
}
