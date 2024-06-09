import "../lib/sphere_client.dart";

// Define the interface

void main() {
  String appKey = "Njg3OTU4NjIzNWRlZjYwMjA1OTE5N2FiN2ExMTM5ZDE=";
  String token =
      "eyJhbGciOiJSUzI1NiIsImtpZCI6IjNiYjg3ZGNhM2JjYjY5ZDcyYjZjYmExYjU5YjMzY2M1MjI5N2NhOGQiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoiU3llZCBZdW51cyIsInBpY3R1cmUiOiJodHRwczovL2xoMy5nb29nbGV1c2VyY29udGVudC5jb20vYS9BQWNIVHRlWGRrNEU4YThLMmhtdEtGS2FZMTV2SGNpWFZNNHd5LWVZTzVNSkNKYzBRUlk9czk2LWMiLCJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vYXVzcGlmb3gtc3RvcmUiLCJhdWQiOiJhdXNwaWZveC1zdG9yZSIsImF1dGhfdGltZSI6MTcwOTYxNTU0MywidXNlcl9pZCI6IkxPdUxTZ1dpcFVWUDY1MkJRWExPdzZ0akxRdTIiLCJzdWIiOiJMT3VMU2dXaXBVVlA2NTJCUVhMT3c2dGpMUXUyIiwiaWF0IjoxNzA5NjE1NTQzLCJleHAiOjE3MDk2MTkxNDMsImVtYWlsIjoic3llZC55dW51cy41ODFAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWQiOnRydWUsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnsiZ29vZ2xlLmNvbSI6WyIxMTQ0MTMwMjM2NTA0NjI4Njg4MzQiXSwiZW1haWwiOlsic3llZC55dW51cy41ODFAZ21haWwuY29tIl19LCJzaWduX2luX3Byb3ZpZGVyIjoiZ29vZ2xlLmNvbSJ9fQ.CCVT0eCpC2o8XfNBYI2ftl99s1JHSTtp7Z9A9ZsUgJxQvnVI_YLku4cuvqN0hRR7GhWin947zpJKneY9v2k7S8ZaCleW4shaUu5-mdv1TsncIJDcMVFUPCW8HkImHIccFKd50Vvq0R5Xi8p5AsCC3RPIl2hav2B8njQbHFTyeAfUldS6Z2dLsdkc9N6PpINghi5gvAvqQPfd7KOEi88m-mFyeI_9psf5RJWcAeLKwn2xluv74taAnkjbPV0Y8eIo5vl1VCTU86oIzxTVxeafK9MvG6fsqnOuDWpaOYhhI_G-4kkjgrydLMpMdCD4KD_ifTY2HjEk5am1VvtHOxuMiQ";

  SphereCommerce ecommerce = SphereCommerce(appKey, token);
  GetWishlistImplementation getWishlistImplementation =
      GetWishlistImplementation();

  int page = 1; // Change this to the desired page number

  ecommerce.getWishlist(page, getWishlistImplementation);
}

// void main() {
//   String emailId = "your_email@example.com"; // Change this to your email
//   String password = "your_password"; // Change this to your password

//   PlentraLoginImplementation plentraLoginImplementation =
//       PlentraLoginImplementation();

//   String appKey = "Njg3OTU4NjIzNWRlZjYwMjA1OTE5N2FiN2ExMTM5ZDE=";
//   SphereBasic sphereClient = new SphereBasic(appKey);
//   sphereClient.plentraLogin(emailId, password, plentraLoginImplementation);
// }

class PlentraLoginImplementation implements PlentraLogin {
  @override
  void onSuccess(String token) {
    print("Login successful. Token: $token");
  }

  @override
  void onLoading() {
    print("Logging in...");
  }

  @override
  void onInvalidEmailId() {
    print("Invalid email ID.");
  }

  @override
  void onEmailIdNotProvided() {
    print("Email ID not provided.");
  }

  @override
  void onPasswordNotProvided() {
    print("Password not provided.");
  }

  @override
  void onInvalidCredentials() {
    print("Invalid credentials.");
  }

  @override
  void onLoadfinished() {
    print("Login finished.");
  }

  @override
  void onError(dynamic error) {
    print("Error: $error");
  }
}

class GetWishlistImplementation implements GetWishlist {
  @override
  void onResult(
    String appName,
    int totalItemCount,
    int itemsInThisPage,
    int itemsPerPage,
    List<dynamic> items,
  ) {
    print("Result:");
    print("App Name: $appName");
    print("Total Item Count: $totalItemCount");
    print("Items in This Page: $itemsInThisPage");
    print("Items Per Page: $itemsPerPage");
    print("Items: $items");
  }

  @override
  void onLoading() {
    print("Loading wishlist...");
  }

  @override
  void onLoadfinished() {
    print("Wishlist loading finished.");
  }

  @override
  void onNextPage(int page) {
    print("Next page: $page");
  }

  @override
  void onEmpty() {
    print("Wishlist is empty.");
  }

  @override
  void onNotLoggedIn() {
    print("Not logged in.");
  }

  @override
  void onError(dynamic error) {
    print("Error: $error");
  }

  @override
  void onNoNextPage() {
    print("No next page available.");
  }

  @override
  void onAppNotActive(String appName) {
    print("App $appName is not active.");
  }
}

class AddToWishlistImplementation implements AddtoWishlist {
  @override
  void onSuccess(dynamic message) {
    print("Success: $message");
  }

  @override
  void onLoading() {
    print("Loading adding to wishlist...");
  }

  @override
  void onLoadfinished() {
    print("Adding to wishlist loading finished.");
  }

  @override
  void onNotLoggedIn() {
    print("Not logged in.");
  }

  @override
  void onError(dynamic error) {
    print("Error: $error");
  }

  @override
  void onAppNotActive(String appName) {
    print("App $appName is not active.");
  }

  @override
  void onItemAlreadyAdded() {
    print("Item is already added to the wishlist.");
  }

  @override
  void onWishlistMaxLimitReached() {
    print("Wishlist maximum limit reached.");
  }
}

class RemoveFromWishlistImplementation implements RemoveFromWishlist {
  @override
  void onSuccess(dynamic message) {
    print("Success: $message");
  }

  @override
  void onLoading() {
    print("Loading removing from wishlist...");
  }

  @override
  void onLoadfinished() {
    print("Removing from wishlist loading finished.");
  }

  @override
  void onNotLoggedIn() {
    print("Not logged in.");
  }

  @override
  void onError(dynamic error) {
    print("Error: $error");
  }

  @override
  void onAppNotActive(String appName) {
    print("App $appName is not active.");
  }
}

class GetCartImplementation implements GetCart {
  @override
  void onResult(
    String appName,
    String currency,
    String currencySymbol,
    double totalAmount,
    int totalItems,
    List<dynamic> items,
  ) {
    print("Result:");
    print("App Name: $appName");
    print("Currency: $currency");
    print("Currency Symbol: $currencySymbol");
    print("Total Amount: $totalAmount");
    print("Total Items: $totalItems");
    print("Items: $items");
  }

  @override
  void onLoading() {
    print("Loading cart...");
  }

  @override
  void onLoadfinished() {
    print("Cart loading finished.");
  }

  @override
  void onEmpty() {
    print("Cart is empty.");
  }

  @override
  void onNotLoggedIn() {
    print("Not logged in.");
  }

  @override
  void onError(dynamic error) {
    print("Error: $error");
  }

  @override
  void onAppNotActive(String appName) {
    print("App $appName is not active.");
  }
}

class ClearWishlistImplementation implements ClearWishlist {
  @override
  void onSuccess(dynamic message) {
    print("Success: $message");
  }

  @override
  void onLoading() {
    print("Loading wishlist clear...");
  }

  @override
  void onLoadfinished() {
    print("Wishlist clear loading finished.");
  }

  @override
  void onNotLoggedIn() {
    print("Not logged in.");
  }

  @override
  void onError(dynamic error) {
    print("Error: $error");
  }

  @override
  void onAppNotActive(String appName) {
    print("App $appName is not active.");
  }
}

class AddToCartVariantImplementation implements AddToCartVariant {
  @override
  void onSuccess(message) {
    print("Success: $message");
  }

  @override
  void onLoading() {
    print("Loading add to cart variant...");
  }

  @override
  void onLoadfinished() {
    print("Add to cart variant loading finished.");
  }

  @override
  void onNotLoggedIn() {
    print("Not logged in.");
  }

  @override
  void onError(error) {
    print("Error: $error");
  }

  @override
  void onAppNotActive(String appName) {
    print("App $appName is not active.");
  }

  @override
  void onItemAlreadyAdded() {
    print("Item is already added to the cart.");
  }

  @override
  void onCartMaxLimitReached() {
    print("Cart maximum limit reached.");
  }

  @override
  void onVariantNotFound() {
    print("Variant not found.");
  }

  @override
  void onVariantNotInStock() {
    print("Variant is not in stock.");
  }
}

class AddToCartImplementation implements AddToCart {
  @override
  void onSuccess(message) {
    print("Success: $message");
  }

  @override
  void onLoading() {
    print("Loading add to cart...");
  }

  @override
  void onLoadfinished() {
    print("Add to cart loading finished.");
  }

  @override
  void onNotLoggedIn() {
    print("Not logged in.");
  }

  @override
  void onError(error) {
    print("Error: $error");
  }

  @override
  void onAppNotActive(String appName) {
    print("App $appName is not active.");
  }

  @override
  void onItemAlreadyAdded() {
    print("Item is already added to the cart.");
  }

  @override
  void onItemNotInStock() {
    print("Item is not in stock.");
  }

  @override
  void onCartMaxLimitReached() {
    print("Cart maximum limit reached.");
  }

  @override
  void onVariants(variantTags) {
    print("Variants found: $variantTags");
  }
}

class UpdateCartImplementation implements UpdateCart {
  @override
  void onSuccess(message) {
    print("Success: $message");
  }

  @override
  void onLoading() {
    print("Loading update cart...");
  }

  @override
  void onLoadfinished() {
    print("Update cart loading finished.");
  }

  @override
  void onNotLoggedIn() {
    print("Not logged in.");
  }

  @override
  void onError(error) {
    print("Error: $error");
  }

  @override
  void onAppNotActive(String appName) {
    print("App $appName is not active.");
  }
}

class RemoveFromCartImplementation implements RemoveFromCart {
  @override
  void onSuccess(message) {
    print("Success: $message");
  }

  @override
  void onLoading() {
    print("Loading remove from cart...");
  }

  @override
  void onLoadfinished() {
    print("Remove from cart loading finished.");
  }

  @override
  void onNotLoggedIn() {
    print("Not logged in.");
  }

  @override
  void onError(error) {
    print("Error: $error");
  }

  @override
  void onAppNotActive(String appName) {
    print("App $appName is not active.");
  }
}

class ClearCartImplementation implements ClearCart {
  @override
  void onSuccess(message) {
    print("Success: $message");
  }

  @override
  void onLoading() {
    print("Loading clear cart...");
  }

  @override
  void onLoadfinished() {
    print("Clear cart loading finished.");
  }

  @override
  void onNotLoggedIn() {
    print("Not logged in.");
  }

  @override
  void onError(error) {
    print("Error: $error");
  }

  @override
  void onAppNotActive(String appName) {
    print("App $appName is not active.");
  }
}

class GetAddressesImplementation implements GetAddresses {
  @override
  void onResult(
      String appName, int itemCount, List<Map<String, dynamic>> addresses) {
    print("App Name: $appName");
    print("Item Count: $itemCount");
    print("Addresses: $addresses");
  }

  @override
  void onLoading() {
    print("Loading addresses...");
  }

  @override
  void onLoadfinished() {
    print("Loading addresses finished.");
  }

  @override
  void onEmpty() {
    print("No addresses available.");
  }

  @override
  void onNotLoggedIn() {
    print("Not logged in.");
  }

  @override
  void onError(dynamic error) {
    print("Error: $error");
  }

  @override
  void onAppNotActive(String appName) {
    print("App $appName is not active.");
  }
}

class RemoveAddressImplementation implements RemoveAddress {
  @override
  void onSuccess(message) {
    print("Success: $message");
  }

  @override
  void onLoading() {
    print("Loading...");
  }

  @override
  void onLoadfinished() {
    print("Loading finished.");
  }

  @override
  void onNotLoggedIn() {
    print("Not logged in.");
  }

  @override
  void onError(error) {
    print("Error: $error");
  }

  @override
  void onAppNotActive(String appName) {
    print("App $appName is not active.");
  }
}

class SetDefaultImplementation implements SetDefault {
  @override
  void onSuccess(message) {
    print("Success: $message");
  }

  @override
  void onLoading() {
    print("Loading...");
  }

  @override
  void onLoadfinished() {
    print("Loading finished.");
  }

  @override
  void onNotLoggedIn() {
    print("Not logged in.");
  }

  @override
  void onError(error) {
    print("Error: $error");
  }

  @override
  void onAppNotActive(String appName) {
    print("App $appName is not active.");
  }
}

class UpdateAddressImplementation implements UpdateAddress {
  @override
  void onSuccess(message) {
    print("Success: $message");
  }

  @override
  void onLoading() {
    print("Loading...");
  }

  @override
  void onLoadfinished() {
    print("Loading finished.");
  }

  @override
  void onNotLoggedIn() {
    print("Not logged in.");
  }

  @override
  void onError(error) {
    print("Error: $error");
  }

  @override
  void onAppNotActive(String appName) {
    print("App $appName is not active.");
  }
}

class AddAddressImplementation implements AddAddress {
  @override
  void onSuccess(message) {
    print("Success: $message");
  }

  @override
  void onLoading() {
    print("Loading...");
  }

  @override
  void onLoadfinished() {
    print("Loading finished.");
  }

  @override
  void onNotLoggedIn() {
    print("Not logged in.");
  }

  @override
  void onError(error) {
    print("Error: $error");
  }

  @override
  void onAppNotActive(String appName) {
    print("App $appName is not active.");
  }

  @override
  void onAddressMaxLimitReached() {
    print("Address max limit reached.");
  }
}

class CheckoutCartImplementation implements CheckoutCart {
  @override
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
  ) {
    print("Result:");
    print("App Name: $appName");
    print("App Icon: $appIcon");
    print("Currency: $currency");
    print("Total Items: $totalItems");
    print("Currency Symbol: $currencySymbol");
    print("Total Amount: $totalAmount");
    print("Order ID: $orderId");
    print("Client Secret: $clientSecret");

    print("Customer Name: $customerName");
    print("Customer Address: $customerAddress");
    print("Customer City: $customerCity");
    print("Customer State: $customerState");
    print("Customer Postal Code: $customerPostalCode");
    print("Customer Phone Number: $customerPhoneNumber");
    print("Payment Type: $paymentType");
    print("Items: $items");
  }

  @override
  void onPinCodeNotServicable() {
    print("Pin code not serviceable.");
  }

  @override
  void onPaymentGateway(String paymentGatewayName, int paymentGatewayType,
      String paymentGatewayKey) {
    print("PaymentGateway: $paymentGatewayName");
    print("PaymentGatewayType: $paymentGatewayType");
    print("PaymentGatewayKey: $paymentGatewayKey");
  }

  @override
  void onLoading() {
    print("Loading...");
  }

  @override
  void onLoadfinished() {
    print("Loading finished.");
  }

  @override
  void onEmpty() {
    print("Empty.");
  }

  @override
  void onNotLoggedIn() {
    print("Not logged in.");
  }

  @override
  void onAddressNotAvailable() {
    print("Address not available.");
  }

  @override
  void onError(error) {
    print("Error: $error");
  }

  @override
  void onAppNotActive(String appName) {
    print("App $appName is not active.");
  }

  @override
  void onTimeSlots(List<dynamic> dates, List<dynamic> slots) {
    print("Time Slots:");
    print("Dates: $dates");
    print("Slots: $slots");
  }
}

class CheckoutItemVariantImplementation implements CheckoutItemVariant {
  @override
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
  ) {
    print("App Name: $appName");
    print("App Icon: $appIcon");
    print("Currency: $currency");
    print("Total Items: $totalItems");
    print("Currency Symbol: $currencySymbol");
    print("Total Amount: $totalAmount");
    print("Order ID: $orderId");
    print("Client Secret: $clientSecret");

    print("Customer Name: $customerName");
    print("Customer Address: $customerAddress");
    print("Customer City: $customerCity");
    print("Customer State: $customerState");
    print("Customer Postal Code: $customerPostalCode");
    print("Customer Phone Number: $customerPhoneNumber");
    print("Payment Type: $paymentType");
    print("Items: $items");
  }

  @override
  void onVariantNotFound() {
    print("Variant not found");
  }

  @override
  void onPinCodeNotServicable() {
    print("Pincode not serviceable");
  }

  @override
  void onPaymentGateway(String paymentGatewayName, int paymentGatewayType,
      String paymentGatewayKey) {
    print("PaymentGateway: $paymentGatewayName");
    print("PaymentGatewayType: $paymentGatewayType");
    print("PaymentGatewayKey: $paymentGatewayKey");
  }

  @override
  void onLoading() {
    print("Loading...");
  }

  @override
  void onLoadfinished() {
    print("Load finished");
  }

  @override
  void onEmpty() {
    print("Empty");
  }

  @override
  void onNotLoggedIn() {
    print("Not logged in");
  }

  @override
  void onAddressNotAvailable() {
    print("Address not available");
  }

  @override
  void onError(error) {
    print("Error: $error");
  }

  @override
  void onAppNotActive(String appName) {
    print("App not active: $appName");
  }

  @override
  void onTimeSlots(List<dynamic> dates, List<dynamic> slots) {
    print("Dates: $dates");
    print("Slots: $slots");
  }
}

class CheckoutItemImplementation implements CheckoutItem {
  @override
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
  ) {
    print("Result:");
    print("App Name: $appName");
    print("App Icon: $appIcon");
    print("Currency: $currency");
    print("Total Items: $totalItems");
    print("Currency Symbol: $currencySymbol");
    print("Total Amount: $totalAmount");
    print("Order ID: $orderId");
    print("Client Secret: $clientSecret");

    print("Customer Name: $customerName");
    print("Customer Address: $customerAddress");
    print("Customer City: $customerCity");
    print("Customer State: $customerState");
    print("Customer Postal Code: $customerPostalCode");
    print("Customer Phone Number: $customerPhoneNumber");
    print("Payment Type: $paymentType");
    print("Items: $items");
  }

  @override
  void onPinCodeNotServicable() {
    print("Pin code not serviceable.");
  }

  @override
  void onPaymentGateway(String paymentGatewayName, int paymentGatewayType,
      String paymentGatewayKey) {
    print("PaymentGateway: $paymentGatewayName");
    print("PaymentGatewayType: $paymentGatewayType");
    print("PaymentGatewayKey: $paymentGatewayKey");
  }

  @override
  void onLoading() {
    print("Loading...");
  }

  @override
  void onLoadfinished() {
    print("Loading finished.");
  }

  @override
  void onEmpty() {
    print("Empty.");
  }

  @override
  void onNotLoggedIn() {
    print("Not logged in.");
  }

  @override
  void onAddressNotAvailable() {
    print("Address not available.");
  }

  @override
  void onError(error) {
    print("Error: $error");
  }

  @override
  void onAppNotActive(String appName) {
    print("App $appName is not active.");
  }

  @override
  void onTimeSlots(List<dynamic> dates, List<dynamic> slots) {
    print("Time Slots:");
    print("Dates: $dates");
    print("Slots: $slots");
  }

  @override
  void onVariants(variantTags) {
    print("Variants: $variantTags");
  }
}

class AddTimeSlotsImplementation implements AddTimeSlots {
  @override
  void onSuccess(message) {
    print("Success: $message");
  }

  @override
  void onLoading() {
    print("Loading...");
  }

  @override
  void onLoadfinished() {
    print("Loading finished.");
  }

  @override
  void onAppNotActive(String appName) {
    print("App $appName is not active.");
  }

  @override
  void onError(error) {
    print("Error: $error");
  }

  @override
  void onInvalidOrder() {
    print("Invalid order.");
  }

  @override
  void onNotLoggedIn() {
    print("User is not logged in.");
  }
}

class ConfirmCODImplementation implements ConfirmCOD {
  @override
  void onSuccess(message) {
    print("Success: $message");
  }

  @override
  void onLoading() {
    print("Confirming COD...");
  }

  @override
  void onLoadfinished() {
    print("Confirmation finished.");
  }

  @override
  void onMaxLimitReached() {
    print("Maximum limit reached.");
  }

  @override
  void onAppNotActive(String appName) {
    print("App $appName is not active.");
  }

  @override
  void onError(error) {
    print("Error confirming COD: $error");
  }

  @override
  void onInvalidOrder() {
    print("Invalid order.");
  }

  @override
  void onNotLoggedIn() {
    print("User is not logged in.");
  }
}

class GetOrdersImplementation implements GetOrders {
  @override
  void onResult(
    String appName,
    int totalItemCount,
    int itemsInThisPage,
    int itemsPerPage,
    List<dynamic> orders,
  ) {
    print("App Name: $appName");
    print("Total Item Count: $totalItemCount");
    print("Items in This Page: $itemsInThisPage");
    print("Items Per Page: $itemsPerPage");
    print("Orders: $orders");
  }

  @override
  void onLoading() {
    print("Loading orders...");
  }

  @override
  void onLoadfinished() {
    print("Orders loading finished.");
  }

  @override
  void onNextPage(int page) {
    print("Next Page: $page");
  }

  @override
  void onEmpty() {
    print("No orders available.");
  }

  @override
  void onNotLoggedIn() {
    print("User is not logged in.");
  }

  @override
  void onError(dynamic error) {
    print("Error fetching orders: $error");
  }

  @override
  void onNoNextPage() {
    print("No next page available.");
  }

  @override
  void onAppNotActive(String appName) {
    print("App $appName is not active.");
  }
}

class GetHomeImplementation implements GetHome {
  @override
  void onResult(
    String appName,
    String appIcon,
    int totalItemCount,
    int itemsInThisPage,
    int itemsPerPage,
    List<dynamic> items,
  ) {
    print("App Name: $appName");
    print("App Icon: $appIcon");
    print("Total Item Count: $totalItemCount");
    print("Items in This Page: $itemsInThisPage");
    print("Items Per Page: $itemsPerPage");
    print("Items: $items");
  }

  @override
  void onLoading() {
    print("Loading home page...");
  }

  @override
  void onLoadfinished() {
    print("Home page loading finished.");
  }

  @override
  void onPopup(String popupTitle, String popupMessage) {
    print("Popup: $popupTitle - $popupMessage");
  }

  @override
  void onAnnouncement(String announcementBody) {
    print("Announcement: $announcementBody");
  }

  @override
  void onMessage(String messageTitle, String messageBody) {
    print("Message: $messageTitle - $messageBody");
  }

  @override
  void onAppLocation(String appLocation, double latitude, double longitude) {
    print(
        "App Location: $appLocation, Latitude: $latitude, Longitude: $longitude");
  }

  @override
  void onNextPage(int nextPage) {
    print("Next Page: $nextPage");
  }

  @override
  void onHomeCover(String cover) {
    print("Home Cover: $cover");
  }

  @override
  void onFooter(String text, List<dynamic> pageLinks) {
    print("Footer Text: $text");
    print("Page Links:");
  }

  @override
  void onEmpty(String appName, String appIcon) {
    print("Empty Home Page for $appName");
  }

  @override
  void onError(dynamic error) {
    print("Error fetching home page: $error");
  }

  @override
  void onUnderConstruction() {
    print("Home page is under construction.");
  }

  @override
  void onAppNotActive(String appName) {
    print("App $appName is not active.");
  }

  @override
  void onNotFound() {
    print("Home page not found.");
  }

  @override
  void onNoNextPage() {
    print("No next page available.");
  }

  @override
  void onItemRail(List<dynamic> categoryIds) {
    print("Item Rail Category IDs: $categoryIds");
  }
}

class GetHomeLoadMoreImplementation implements GetHomeLoadMore {
  @override
  void onResult(
    int totalItemCount,
    int itemsInThisPage,
    int itemsPerPage,
    List<dynamic> items,
  ) {
    print("Total Item Count: $totalItemCount");
    print("Items in This Page: $itemsInThisPage");
    print("Items Per Page: $itemsPerPage");
    print("Items: $items");
  }

  @override
  void onLoading() {
    print("Loading home page...");
  }

  @override
  void onLoadfinished() {
    print("Home page loading finished.");
  }

  @override
  void onNextPage(int nextPage) {
    print("Next Page: $nextPage");
  }

  @override
  void onEmpty(String appName, String appIcon) {
    print("Empty Home Page for $appName");
  }

  @override
  void onError(dynamic error) {
    print("Error fetching home page: $error");
  }

  @override
  void onUnderConstruction() {
    print("Home page is under construction.");
  }

  @override
  void onAppNotActive(String appName) {
    print("App $appName is not active.");
  }

  @override
  void onNotFound() {
    print("Home page not found.");
  }

  @override
  void onNoNextPage() {
    print("No next page available.");
  }
}

class GetPageImplementation implements GetPage {
  @override
  void onResult(
      String appName, String appIcon, String pageTitle, String pageBody) {
    print("App Name: $appName");
    print("App Icon: $appIcon");
    print("Page Title: $pageTitle");
    print("Page Body: $pageBody");
  }

  @override
  void onLoading() {
    print("Loading page...");
  }

  @override
  void onLoadfinished() {
    print("Page loading finished.");
  }

  @override
  void onHomeCover(String cover) {
    print("Home cover: $cover");
  }

  @override
  void onAppLocation(String appLocation, double latitude, double longitude) {
    print(
        "App Location: $appLocation, Latitude: $latitude, Longitude: $longitude");
  }

  @override
  void onAnnouncement(String announcementBody) {
    print("Announcement: $announcementBody");
  }

  @override
  void onError(dynamic error) {
    print("Error fetching page: $error");
  }

  @override
  void onUnderConstruction() {
    print("Page is under construction.");
  }

  @override
  void onAppNotActive(String appName) {
    print("App $appName is not active.");
  }

  @override
  void onNotFound() {
    print("Page not found.");
  }
}

class GetLauncherImplementation implements GetLauncher {
  @override
  void onResult(
    String appName,
    String appIcon,
    String launcherName,
    String launcherIcon,
    int totalItemCount,
    int itemsInThisPage,
    int itemsPerPage,
    List<dynamic> items,
  ) {
    print("App Name: $appName");
    print("App Icon: $appIcon");
    print("Launcher Name: $launcherName");
    print("Launcher Icon: $launcherIcon");
    print("Total Item Count: $totalItemCount");
    print("Items In This Page: $itemsInThisPage");
    print("Items Per Page: $itemsPerPage");
    print("Items: $items");
  }

  @override
  void onLoading() {
    print("Loading launcher...");
  }

  @override
  void onLoadfinished() {
    print("Launcher loading finished.");
  }

  @override
  void onAnnouncement(String announcementBody) {
    print("Announcement: $announcementBody");
  }

  @override
  void onAppLocation(String appLocation, double latitude, double longitude) {
    print(
        "App Location: $appLocation, Latitude: $latitude, Longitude: $longitude");
  }

  @override
  void onNextPage(int nextPage) {
    print("Next page: $nextPage");
  }

  @override
  void onLauncherCover(String cover) {
    print("Launcher cover: $cover");
  }

  @override
  void onEmpty(String appName, String appIcon, String launcherName,
      String launcherIcon) {
    print(
        "Empty launcher: App Name: $appName, App Icon: $appIcon, Launcher Name: $launcherName, Launcher Icon: $launcherIcon");
  }

  @override
  void onError(dynamic error) {
    print("Error fetching launcher: $error");
  }

  @override
  void onUnderConstruction() {
    print("Launcher is under construction.");
  }

  @override
  void onAppNotActive(String appName) {
    print("App $appName is not active.");
  }

  @override
  void onNotFound() {
    print("Launcher not found.");
  }

  @override
  void onNoNextPage() {
    print("No next page available.");
  }
}

class GetLauncherLoadMoreImplementation implements GetLauncherLoadMore {
  @override
  void onResult(
    int totalItemCount,
    int itemsInThisPage,
    int itemsPerPage,
    List<dynamic> items,
  ) {
    print("Total Item Count: $totalItemCount");
    print("Items In This Page: $itemsInThisPage");
    print("Items Per Page: $itemsPerPage");
    print("Items: $items");
  }

  @override
  void onLoading() {
    print("Loading launcher items...");
  }

  @override
  void onLoadfinished() {
    print("Launcher items loading finished.");
  }

  @override
  void onNextPage(int nextPage) {
    print("Next page: $nextPage");
  }

  @override
  void onEmpty() {
    print("No launcher items found.");
  }

  @override
  void onError(dynamic error) {
    print("Error fetching launcher items: $error");
  }

  @override
  void onUnderConstruction() {
    print("Launcher items are under construction.");
  }

  @override
  void onAppNotActive(String appName) {
    print("App $appName is not active.");
  }

  @override
  void onNotFound() {
    print("Launcher items not found.");
  }

  @override
  void onNoNextPage() {
    print("No next page available.");
  }
}

class GetItemsSearchLoadMoreImplementation implements GetItemsSearchLoadMore {
  @override
  void onResult(
    int totalItemCount,
    int itemsInThisPage,
    int itemsPerPage,
    List<dynamic> items,
  ) {
    print("Total Item Count: $totalItemCount");
    print("Items In This Page: $itemsInThisPage");
    print("Items Per Page: $itemsPerPage");
    print("Items: $items");
  }

  @override
  void onLoading() {
    print("Loading items...");
  }

  @override
  void onLoadfinished() {
    print("Items loading finished.");
  }

  @override
  void onNextPage(int nextPage) {
    print("Next page: $nextPage");
  }

  @override
  void onEmpty() {
    print("No items found.");
  }

  @override
  void onError(dynamic error) {
    print("Error fetching items: $error");
  }

  @override
  void onUnderConstruction() {
    print("Items are under construction.");
  }

  @override
  void onAppNotActive(String appName) {
    print("App $appName is not active.");
  }

  @override
  void onNotFound() {
    print("Items not found.");
  }

  @override
  void onNoNextPage() {
    print("No next page available.");
  }
}

class GetItemsSearchImplementation implements GetItemsSearch {
  @override
  void onResult(
    String appName,
    String appIcon,
    int totalItemCount,
    int itemsInThisPage,
    int itemsPerPage,
    List<dynamic> items,
  ) {
    print("App Name: $appName");
    print("App Icon: $appIcon");
    print("Total Item Count: $totalItemCount");
    print("Items In This Page: $itemsInThisPage");
    print("Items Per Page: $itemsPerPage");
    print("Items: $items");
  }

  @override
  void onLoading() {
    print("Loading items...");
  }

  @override
  void onLoadfinished() {
    print("Items loading finished.");
  }

  @override
  void onNextPage(int nextPage) {
    print("Next page: $nextPage");
  }

  @override
  void onHomeCover(String cover) {
    print("Home Cover: $cover");
  }

  @override
  void onEmpty(String appName, String appIcon) {
    print("Empty response. App Name: $appName, App Icon: $appIcon");
  }

  @override
  void onError(dynamic error) {
    print("Error fetching items: $error");
  }

  @override
  void onUnderConstruction() {
    print("Items are under construction.");
  }

  @override
  void onAppNotActive(String appName) {
    print("App $appName is not active.");
  }

  @override
  void onNotFound() {
    print("Items not found.");
  }

  @override
  void onNoNextPage() {
    print("No next page available.");
  }
}

class GetItemsImplementation implements GetItems {
  @override
  void onResult(
    String categoryId,
    String appName,
    String appIcon,
    String categoryName,
    String categoryIcon,
    int totalItemCount,
    int itemsInThisPage,
    int itemsPerPage,
    List<dynamic> items,
  ) {
    print("App Name: $appName");
    print("App Icon: $appIcon");
    print("Category Name: $categoryName");
    print("Category Icon: $categoryIcon");
    print("Total Item Count: $totalItemCount");
    print("Items In This Page: $itemsInThisPage");
    print("Items Per Page: $itemsPerPage");
    print("Items: $items");
  }

  @override
  void onLoading() {
    print("Loading items...");
  }

  @override
  void onLoadfinished() {
    print("Items loading finished.");
  }

  @override
  void onAnnouncement(String announcementBody) {
    print("Announcement: $announcementBody");
  }

  @override
  void onAppLocation(String appLocation, double latitude, double longitude) {
    print(
        "App Location: $appLocation, Latitude: $latitude, Longitude: $longitude");
  }

  @override
  void onNextPage(int nextPage) {
    print("Next page: $nextPage");
  }

  @override
  void onHomeCover(String cover) {
    print("Home Cover: $cover");
  }

  @override
  void onEmpty(String appName, String appIcon, String categoryName,
      String categoryIcon) {
    print(
        "Empty response. App Name: $appName, App Icon: $appIcon, Category Name: $categoryName, Category Icon: $categoryIcon");
  }

  @override
  void onError(dynamic error) {
    print("Error fetching items: $error");
  }

  @override
  void onUnderConstruction() {
    print("Items are under construction.");
  }

  @override
  void onAppNotActive(String appName) {
    print("App $appName is not active.");
  }

  @override
  void onNotFound() {
    print("Items not found.");
  }

  @override
  void onNoNextPage() {
    print("No next page available.");
  }
}

class GetItemsLoadMoreImplementation implements GetItemsLoadMore {
  @override
  void onResult(
    String categoryId,
    int totalItemCount,
    int itemsInThisPage,
    int itemsPerPage,
    List<dynamic> items,
  ) {
    print("Total Item Count: $totalItemCount");
    print("Items In This Page: $itemsInThisPage");
    print("Items Per Page: $itemsPerPage");
    print("Items: $items");
  }

  @override
  void onLoading() {
    print("Loading items...");
  }

  @override
  void onLoadfinished() {
    print("Items loading finished.");
  }

  @override
  void onNextPage(int nextPage) {
    print("Next page: $nextPage");
  }

  @override
  void onEmpty() {
    print("No items found.");
  }

  @override
  void onError(dynamic error) {
    print("Error fetching items: $error");
  }

  @override
  void onUnderConstruction() {
    print("Items are under construction.");
  }

  @override
  void onAppNotActive(String appName) {
    print("App $appName is not active.");
  }

  @override
  void onNotFound() {
    print("Items not found.");
  }

  @override
  void onNoNextPage() {
    print("No next page available.");
  }
}

class GetVariantImplementation implements GetVariant {
  @override
  void onResult(
    String variantTag,
    String variantId,
    Map<String, dynamic> variantExtras,
    String variantImage,
    Map<String, dynamic> variantImages,
  ) {
    print("Variant Tag: $variantTag");
    print("Variant ID: $variantId");
    print("Variant Extras: $variantExtras");
    print("Variant Image: $variantImage");
    print("Variant Images: $variantImages");
    print("Variant Images: $variantImages");
  }

  @override
  void onLoading() {
    print("Loading variant...");
  }

  @override
  void onLoadfinished() {
    print("Variant loading finished.");
  }

  @override
  void onError(dynamic error) {
    print("Error fetching variant: $error");
  }

  @override
  void onUnderConstruction() {
    print("Variant is under construction.");
  }

  @override
  void onAppNotActive(String appName) {
    print("App $appName is not active.");
  }

  @override
  void onNotFound() {
    print("Variant not found.");
  }

  @override
  void onBadRequest(String status) {
    print("Bad request: $status");
  }
}

class GetItemImplementation implements GetItem {
  @override
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
  ) {
    print("appName: $appName");
    print("appIcon: $appIcon");
    print("itemName: $itemName");
    print("extras: $extras");
    print("body: $body");
    print("itemCategoryName: $itemCategoryName");
    print("itemCategory: $itemCategory");
    print("itemImages: $itemImages");
    print("itemImage: $itemImage");
  }

  @override
  void onLoading() {
    print("Loading...");
  }

  @override
  void onLoadfinished() {
    print("Loading finished.");
  }

  @override
  void onAnnouncement(String announcementBody) {
    print("Announcement: $announcementBody");
  }

  @override
  void onAppLocation(String appLocation, double latitude, double longitude) {
    print("App Location: $appLocation");
  }

  @override
  void onHomeCover(String cover) {
    print("Home Cover: $cover");
  }

  @override
  void onError(dynamic error) {
    print("Error: $error");
    print("Stack trace:\n${StackTrace.current}");
  }

  @override
  void onUnderConstruction() {
    print("Under construction.");
  }

  @override
  void onAppNotActive(String appName) {
    print("App not active: $appName");
  }

  @override
  void onVideo(String videoLink) {
    print("Video Link: $videoLink");
  }

  @override
  void onNotFound() {
    print("Item not found.");
  }

  @override
  void onBadRequest(String status) {
    print("Bad request: $status");
  }

  @override
  void onFirstVariant(
    String variantTag,
    String variantId,
    Map<String, dynamic> variantExtras,
    String variantImage,
    Map<String, dynamic> variantImages,
  ) {
    print("First Variant Tag: $variantTag");
    print("First Variant ID: $variantId");
    print("Variant Extras: $variantExtras");
    print("Variant Image: $variantImage");
    print("Variant Images: $variantImages");
  }

  @override
  void onVariants(List<dynamic> variants) {
    print("Variants: $variants");
  }
}

class GetAppInfoImplementation implements GetAppInfo {
  @override
  void onResult(
    String appName,
    String appIcon,
    int appType,
    Map<String, dynamic> appLocation,
  ) {
    print("appName: $appName, "
        "appIcon: $appIcon, "
        "appType: $appType, "
        "appLocation: $appLocation");
  }

  @override
  void onLoading() {
    print("loading started");
  }

  @override
  void onHomeCover(String homeCover) {
    print(homeCover);
  }

  @override
  void onLoadfinished() {
    print("finished");
  }

  @override
  void onError(dynamic error) {
    print(error);
  }

  @override
  void onAppNotActive(String appName) {
    print("App not active: $appName");
  }

  @override
  void onWhatsappChat(int dialingCode, int phoneNumber) {
    print(
        "Dialing code: ${dialingCode.toString()}. Phone Number:  ${phoneNumber.toString()}");
  }
}

class GetCommerceInfoImplementation implements GetCommerceInfo {
  @override
  void onResult(
    String appName,
    String appIcon,
    int appType,
    Map<String, dynamic>
        appLocation, // Changed parameter type to Map<String, dynamic>
  ) {
    print("appName: $appName, "
        "appIcon: $appIcon, "
        "appType: $appType, "
        "appLocation: $appLocation"); // Print the map directly
  }

  @override
  void onLoading() {
    print("loading started");
  }

  @override
  void onHomeCover(String homeCover) {
    print(homeCover);
  }

  @override
  void onLoadfinished() {
    print("finished");
  }

  @override
  void onError(dynamic error) {
    print(error);
  }

  @override
  void onAppNotActive(String appName) {
    print("App not active: $appName");
  }

  @override
  void onPaymentGateway(String paymentGatewayName, int paymentGatewayType,
      String paymentGatewayKey) {
    print("PaymentGateway: $paymentGatewayName");
    print("PaymentGatewayType: $paymentGatewayType");
    print("PaymentGatewayKey: $paymentGatewayKey");
  }

  @override
  void onfirebaseAuth(String obj) {
    print("firebase object: $obj");
  }
}
