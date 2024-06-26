abstract class GetCommerceInfo {
  void onResult(
    String appName,
    String appIcon,
    int appType,
    Map<String, dynamic>
        appLocation, // Changed parameter type to Map<String, dynamic>
  );
  void onfirebaseAuth(String obj);
  void onPaymentGateway(String paymentGatewayName, int paymentGatewayType,
      String paymentGatewayKey);
  void onLoading();
  void onHomeCover(String homeCover);
  void onLoadfinished();
  void onError(dynamic error);
  void onAppNotActive(String appName);
}
