abstract class GetCommerceInfo {
  void onResult(
    String appName,
    String appIcon,
    int appType,
    String firebase,
    String paymentGatewayName,
    int paymentGatewayType,
    String paymentGatewayKey,
    Map<String, dynamic>
        appLocation, // Changed parameter type to Map<String, dynamic>
  );
  void onLoading();
  void onHomeCover(String homeCover);
  void onLoadfinished();
  void onError(dynamic error);
  void onAppNotActive(String appName);
}
