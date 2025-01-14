class ConfirmPhonePePayment {
  void onSuccess(String message) {
    print("Success: $message");
  }

  void onLoading() {
    print("Loading...");
  }

  void onLoadfinished() {
    print("Load finished");
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

  void onPaymentFailed() {
    print("payment failed");
  }
}
