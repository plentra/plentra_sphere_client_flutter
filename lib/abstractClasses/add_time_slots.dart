abstract class AddTimeSlots {
  void onSuccess(message);
  void onLoading();
  void onLoadfinished();
  void onAppNotActive(String appName);
  void onError(error);
  void onInvalidOrder();
  void onNotLoggedIn();
}
