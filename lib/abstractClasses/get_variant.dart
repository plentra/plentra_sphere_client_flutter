abstract class GetVariant {
  void onResult(
    String variantTag,
    String variantId,
    Map<String, dynamic> variantExtras,
    String variantImage,
    Map<String, dynamic> variantImages,
  );

  void onLoading();

  void onLoadfinished();

  void onError(dynamic error);

  void onUnderConstruction();

  void onAppNotActive(String appName);

  void onNotFound();

  void onBadRequest(String status);
}
