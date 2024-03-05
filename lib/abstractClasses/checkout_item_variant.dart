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
    String paymentGatewayName,
    int paymentGatewayType,
    String paymentGatewayKey,
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
  void onLoading();
  void onLoadfinished();
  void onEmpty();
  void onNotLoggedIn();
  void onAddressNotAvailable();
  void onError(error);
  void onAppNotActive(String appName);
  void onItemNotInStock();
  void onItemNotFound();
  void onCartEmpty();
  void onTimeSlots(List<dynamic> dates, List<dynamic> slots);
  void onVariantNotFound();
  void onVariantNotInStock();
}
