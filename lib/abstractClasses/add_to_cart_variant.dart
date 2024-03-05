abstract class AddToCartVariant {
  void onSuccess(message);
  void onLoading();
  void onLoadfinished();
  void onNotLoggedIn();
  void onError(error);
  void onAppNotActive(String appName);
  void onItemAlreadyAdded();
  void onCartMaxLimitReached();
  void onVariantNotFound();
  void onVariantNotInStock();
}
