abstract class GetItem {
  void onResult(
    String appName,
    String appIcon,
    String itemName,
    Map<String, dynamic> extras,
    String body,
    String itemCategoryName,
    String itemCategory,
    Map<String, dynamic> itemImages,
    String itemImage,
  );
  void onLoading();
  void onLoadfinished();
  void onAnnouncement(String announcementBody);
  void onAppLocation(String appLocation, double latitude, double longitude);
  void onHomeCover(String cover);
  void onError(dynamic error);
  void onUnderConstruction();
  void onAppNotActive(String appName);
  void onVideo(String videoLink);
  void onNotFound();
  void onBadRequest(String status);
  void onFirstVariant(
    String variantTag,
    String variantId,
    Map<String, dynamic> variantExtras,
    String variantImage,
    Map<String, dynamic> variantImages,
  );
  void onVariants(List<dynamic> variants);
}
