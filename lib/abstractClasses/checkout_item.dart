abstract class CheckoutItem {
  void onResult(
    String appName,
    String appIcon,
    String currency,
    int totalItems,
    String currencySymbol,
    double totalAmount,
    String orderId,
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
  void onRazorpay(String key);
  void onStripe(String clientSecret, String publishableKey);
  void onPhonePe(String paymentLink);
  void onLoading();
  void onLoadfinished();
  void onEmpty();
  void onNotLoggedIn();
  void onAddressNotAvailable();
  void onError(error);
  void onAppNotActive(String appName);

  void onTimeSlots(List<dynamic> dates, List<dynamic> slots);
  void onVariants(variantTags);
}
