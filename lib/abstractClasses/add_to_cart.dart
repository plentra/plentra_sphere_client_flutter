abstract class AddToCart {
  void onSuccess(message);
  void onLoading();
  void onLoadfinished();
  void onNotLoggedIn();
  void onError(error);
  void onAppNotActive(String appName);
  void onItemAlreadyAdded();
  void onItemNotInStock();
  void onCartMaxLimitReached();
  void onVariants(variantTags);
}
