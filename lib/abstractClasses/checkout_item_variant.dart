abstract class CheckoutItemVariant {
  void onResult(
    String appName,
    String appIcon,
    String currency,
    int totalItems,
    String currencySymbol,
    double totalAmount,
    String orderId,
    dynamic clientSecret,
    String customerName,
    String customerAddress,
    String customerCity,
    String customerState,
    String customerPostalCode,
    String customerPhoneNumber,
    int paymentType,
    List<dynamic> items,
  );
  void onPinCodeNotServicable();
  void onPaymentGateway(String paymentGatewayName, int paymentGatewayType,
      String paymentGatewayKey);
  void onLoading();
  void onLoadfinished();
  void onEmpty();
  void onNotLoggedIn();
  void onAddressNotAvailable();
  void onError(error);
  void onAppNotActive(String appName);

  void onTimeSlots(List<dynamic> dates, List<dynamic> slots);
  void onVariantNotFound();
}
