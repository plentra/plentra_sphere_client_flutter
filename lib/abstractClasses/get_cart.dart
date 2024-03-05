abstract class GetCart {
  void onResult(
    String appName,
    String currency,
    String currencySymbol,
    double totalAmount,
    int totalItems,
    List<dynamic> items,
  );

  void onLoading();

  void onLoadfinished();

  void onEmpty();

  void onNotLoggedIn();

  void onError(dynamic error);

  void onAppNotActive(String appName);
}
