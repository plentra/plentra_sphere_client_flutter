class ConfirmCOD {
  void onSuccess(String message) {
    print("Success: $message");
  }

  void onLoading() {
    print("Loading...");
  }

  void onLoadfinished() {
    print("Load finished");
  }

  void onMaxLimitReached() {
    print("Maximum limit reached");
  }

  void onAppNotActive(String appName) {
    print("App $appName is not active");
  }

  void onError(dynamic error) {
    print("Error: $error");
  }

  void onInvalidOrder() {
    print("Invalid order");
  }

  void onNotLoggedIn() {
    print("User is not logged in");
  }
}
