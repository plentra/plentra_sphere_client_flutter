import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:plentra_sphere_client/abstractClasses/confirmStripePayment.dart';
//ecommerce
import 'abstractClasses/confirmCOD.dart';
import 'abstractClasses/add_time_slots.dart';
import 'abstractClasses/get_orders.dart';
import 'abstractClasses/checkout_item.dart';
import 'abstractClasses/checkout_item_variant.dart';
import 'abstractClasses/checkout_cart.dart';
import 'abstractClasses/add_address.dart';
import 'abstractClasses/update_address.dart';
import 'abstractClasses/set_default.dart';
import 'abstractClasses/remove_address.dart';
import 'abstractClasses/get_addresses.dart';
import 'abstractClasses/clear_cart.dart';
import 'abstractClasses/remove_from_cart.dart';
import 'abstractClasses/update_cart.dart';
import 'abstractClasses/add_to_cart.dart';
import 'abstractClasses/add_to_cart_variant.dart';
import 'abstractClasses/get_cart.dart';
import 'abstractClasses/clear_wishlist.dart';
import 'abstractClasses/remove_from_wishlist.dart';
import 'abstractClasses/add_to_wishlist.dart';
import 'abstractClasses/get_wishlist.dart';
import 'abstractClasses/confirmPhonePePayment.dart';
import 'abstractClasses/confirmRazorpayPayment.dart';

class SphereCommerce {
  String appKey;
  String token;

  SphereCommerce(this.appKey, this.token);

  Map<String, dynamic> check() {
    if (appKey.length == 0) {
      return {'status': false, 'field': 'appKey'};
    }
    if (token.length == 0) {
      return {'status': false, 'field': 'token'};
    }
    return {'status': true};
  }

  void getOrders(int page, GetOrders getOrders) async {
    getOrders.onLoading();

    final url = "https://api.plentrasphere.com/v2/client/index.php";
    final body = {
      'class': 'orders',
      "appKey": appKey,
      "action": "getOrders",
      "page": page.toString(),
    };

    try {
      final response = await http.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
            'Authorization': 'Bearer $token'
          },
          body: body);

      final data = json.decode(response.body);

      int code = data['response']['code'];
      String status = data['response']['status'];

      if (code == 400) {
        if (status == "no-orders") {
          getOrders.onEmpty();
          getOrders.onNoNextPage();
          getOrders.onLoadfinished();
          return;
        }
        if (status == "please-login" || status == "session-expired") {
          getOrders.onNotLoggedIn();
          getOrders.onLoadfinished();
          return;
        }
        if (status == "app-expired") {
          getOrders.onAppNotActive(data['info']['appName']);
          getOrders.onLoadfinished();
          return;
        }

        getOrders.onError(status);
        getOrders.onLoadfinished();
        return;
      }

      Map<String, dynamic> info = data['info'];

      if (info['nextPage']['status']) {
        getOrders.onNextPage(info['nextPage']['page']);
      } else {
        getOrders.onNoNextPage();
      }

      if (info['totalItemCount'] == 0) {
        getOrders.onEmpty();
        getOrders.onLoadfinished();
        return;
      }

      getOrders.onResult(
        info['appName'],
        info['totalItemCount'],
        info['itemsInThisPage'],
        info['itemsPerPage'],
        data['orders'],
      );
      getOrders.onLoadfinished();
    } catch (e) {
      getOrders.onError(e.toString());
      getOrders.onLoadfinished();
    }
  }

  void confirmCOD(String orderId, ConfirmCOD confirmCOD, String appKey,
      String token) async {
    confirmCOD.onLoading();

    final url = "https://api.plentrasphere.com/v2/client/index.php";
    final body = {
      'class': 'payment',
      "appKey": appKey,
      "action": "confirmCOD",
      "orderId": orderId,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Authorization": "Bearer $token",
        },
        body: body,
      );

      final data = json.decode(response.body);

      int code = data['response']['code'];
      String status = data['response']['status'];

      if (code == 400) {
        if (status == "app-expired") {
          confirmCOD.onAppNotActive(data['info']['appName']);
          confirmCOD.onLoadfinished();
          return;
        }
        if (status == "session-expired") {
          confirmCOD.onNotLoggedIn();
          confirmCOD.onLoadfinished();
          return;
        }
        if (status == "max-limit-reached") {
          confirmCOD.onMaxLimitReached();
          confirmCOD.onLoadfinished();
          return;
        }
        if (status == "invalid-order") {
          confirmCOD.onInvalidOrder();
          confirmCOD.onLoadfinished();
          return;
        }

        confirmCOD.onError(status);
        confirmCOD.onLoadfinished();
        return;
      }

      confirmCOD.onSuccess(status);
      confirmCOD.onLoadfinished();
    } catch (e) {
      confirmCOD.onError(e.toString());
      confirmCOD.onLoadfinished();
    }
  }

  void confirmPhonePePayment(
    String appKey,
    String token,
    String orderId,
    ConfirmPhonePePayment confirmPhonePePayment,
  ) async {
    confirmPhonePePayment.onLoading();

    final url = "https://api.plentrasphere.com/v2/client/index.php";
    final body = {
      'class': 'payment',
      "appKey": appKey,
      "action": "confirmPhonePePayment",
      "orderId": orderId,
      'isMobile': "yes",
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Authorization": "Bearer $token",
        },
        body: body,
      );

      final data = json.decode(response.body);

      int code = data['response']['code'];
      String status = data['response']['status'];

      if (code == 400) {
        if (status == "app-expired") {
          confirmPhonePePayment.onAppNotActive(data['info']['appName']);
          confirmPhonePePayment.onLoadfinished();
          return;
        }
        // if (status == "session-expired") {
        //   confirmPhonePePayment.onNotLoggedIn();
        //   confirmPhonePePayment.onLoadfinished(ß);
        //   return;
        // }

        if (status == "invalid-order") {
          confirmPhonePePayment.onInvalidOrder();
          confirmPhonePePayment.onLoadfinished();
          return;
        }

        confirmPhonePePayment.onError(status);
        confirmPhonePePayment.onLoadfinished();
        return;
      }

      confirmPhonePePayment.onSuccess(status);
      confirmPhonePePayment.onLoadfinished();
    } catch (e) {
      confirmPhonePePayment.onError(e.toString());
      confirmPhonePePayment.onLoadfinished();
    }
  }

  void confirmRazorpayPayment(
    String appKey,
    String token,
    String orderId,
    String paymentId,
    String signature,
    ConfirmRazorpayPayment confirmRazorpayPayment,
  ) async {
    confirmRazorpayPayment.onLoading();

    final url = "https://api.plentrasphere.com/v2/client/index.php";
    final body = {
      'class': 'payment',
      "appKey": appKey,
      "action": "confirmRazorpayPayment",
      "razorpay_order_id": orderId,
      "razorpay_payment_id": paymentId,
      "razorpay_signature": signature,
      'isMobile': "yes",
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Authorization": "Bearer $token",
        },
        body: body,
      );

      final data = json.decode(response.body);

      int code = data['response']['code'];
      String status = data['response']['status'];

      if (code == 400) {
        if (status == "app-expired") {
          confirmRazorpayPayment.onAppNotActive(data['info']['appName']);
          confirmRazorpayPayment.onLoadfinished();
          return;
        }
        // if (status == "session-expired") {
        //   confirmRazorpayPayment.onNotLoggedIn();
        //   confirmRazorpayPayment.onLoadfinished(ß);
        //   return;
        // }

        if (status == "invalid-order") {
          confirmRazorpayPayment.onInvalidOrder();
          confirmRazorpayPayment.onLoadfinished();
          return;
        }

        confirmRazorpayPayment.onError(status);
        confirmRazorpayPayment.onLoadfinished();
        return;
      }

      confirmRazorpayPayment.onSuccess(status);
      confirmRazorpayPayment.onLoadfinished();
    } catch (e) {
      confirmRazorpayPayment.onError(e.toString());
      confirmRazorpayPayment.onLoadfinished();
    }
  }

  void confirmStripePayment(
    String appKey,
    String token,
    String orderId,
    ConfirmStripePayment confirmStripePayment,
  ) async {
    confirmStripePayment.onLoading();

    final url = "https://api.plentrasphere.com/v2/client/index.php";
    final body = {
      'class': 'payment',
      "appKey": appKey,
      "action": "confirmStripePayment",
      "orderId": orderId,
      'isMobile': "yes",
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Authorization": "Bearer $token",
        },
        body: body,
      );

      final data = json.decode(response.body);

      int code = data['response']['code'];
      String status = data['response']['status'];

      if (code == 400) {
        if (status == "app-expired") {
          confirmStripePayment.onAppNotActive(data['info']['appName']);
          confirmStripePayment.onLoadfinished();
          return;
        }
        // if (status == "session-expired") {
        //   confirmStripePayment.onNotLoggedIn();
        //   confirmStripePayment.onLoadfinished(ß);
        //   return;
        // }

        if (status == "invalid-order") {
          confirmStripePayment.onInvalidOrder();
          confirmStripePayment.onLoadfinished();
          return;
        }

        confirmStripePayment.onError(status);
        confirmStripePayment.onLoadfinished();
        return;
      }

      confirmStripePayment.onSuccess(status);
      confirmStripePayment.onLoadfinished();
    } catch (e) {
      confirmStripePayment.onError(e.toString());
      confirmStripePayment.onLoadfinished();
    }
  }

  void addTimeSlot(String orderId, String slotId, String dateIndex,
      AddTimeSlots addTimeSlot) async {
    addTimeSlot.onLoading();

    final url = "https://api.plentrasphere.com/v2/client/index.php";
    final body = {
      'class': 'checkout',
      "appKey": appKey,
      "action": "addTimeSlot",
      "orderId": orderId,
      "slotId": slotId,
      "dateIndex": dateIndex,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          'Authorization': 'Bearer $token'
        },
        body: body,
      );

      final data = json.decode(response.body);
      int code = data['response']['code'];
      String status = data['response']['status'];

      if (code == 400) {
        if (status == "app-expired") {
          addTimeSlot.onAppNotActive(data['info']['appName']);
          addTimeSlot.onLoadfinished();
          return;
        }
        if (status == "session-expired") {
          addTimeSlot.onNotLoggedIn();
          addTimeSlot.onLoadfinished();
          return;
        }
        if (status == "invalid-order") {
          addTimeSlot.onInvalidOrder();
          addTimeSlot.onLoadfinished();
          return;
        }

        addTimeSlot.onError(status);
        addTimeSlot.onLoadfinished();
        return;
      }

      addTimeSlot.onSuccess(status);
      addTimeSlot.onLoadfinished();
    } catch (e) {
      addTimeSlot.onError(e.toString());
      addTimeSlot.onLoadfinished();
    }
  }

  void checkoutItem(String itemId, int quantity, CheckoutItem checkout) async {
    checkout.onLoading();

    final url = "https://api.plentrasphere.com/v2/client/index.php";
    final body = {
      'class': 'checkout',
      "appKey": appKey,
      "action": "checkout",
      "isMobile": "yes",
      "hostname": "window.location.hostname",
      "itemId": itemId,
      "quantity": quantity.toString(),
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          'Authorization': 'Bearer $token'
        },
        body: body,
      );

      final data = json.decode(response.body);
      int code = data['response']['code'];
      String status = data['response']['status'];

      if (code == 400) {
        if (status == "variants-found") {
          checkout.onVariants(data['variants']);
          checkout.onLoadfinished();
          return;
        }
        if (status == "please-login" || status == "session-expired") {
          checkout.onNotLoggedIn();
          checkout.onLoadfinished();
          return;
        }
        if (status == "pincode-not-serviceable") {
          checkout.onPinCodeNotServicable();
          checkout.onLoadfinished();
          return;
        }
        if (status == "app-expired") {
          checkout.onAppNotActive(data['info']['appName']);
          checkout.onLoadfinished();
          return;
        }
        if (status == "no-addresses-available") {
          checkout.onAddressNotAvailable();
          checkout.onLoadfinished();
          return;
        }
        if (status == "item-not-found" ||
            status == "not-in-stock" ||
            status == "cart-empty") {
          checkout.onError(status);
          checkout.onLoadfinished();
          return;
        }

        checkout.onError(status);
        checkout.onLoadfinished();
        return;
      }

      Map<String, dynamic> info = data['info'];
      Map<String, dynamic> customerInfo = data['customerInfo'];

      if (info['totalItems'] == 0) {
        checkout.onEmpty();
        checkout.onLoadfinished();
        return;
      }

      if (info['timeSlots']['status']) {
        checkout.onTimeSlots(
            info['timeSlots']['dates'], info['timeSlots']['slots']);
      }

      // if (info.containsKey('paymentGatewayKey') &&
      //     info.containsKey('paymentGatewayType') &&
      //     info.containsKey('paymentGatewayName')) {
      //   checkout.onPaymentGateway(info['paymentGatewayName'],
      //       info['paymentGatewayType'], info['paymentGatewayKey']);
      // }

      if (info.containsKey("paymentGateway")) {
        var paymentGateway = info['paymentGateway'];
        if (paymentGateway['type'] == 0) {
          checkout.onRazorpay(paymentGateway['key']);
        }
        if (paymentGateway['type'] == 1) {
          checkout.onStripe(
              paymentGateway['clientSecret'], paymentGateway['publishableKey']);
        }
        if (paymentGateway['type'] == 2) {
          checkout.onPhonePe(paymentGateway['paymentLink']);
        }
      }

      checkout.onResult(
        info['appName'],
        info['appIcon'],
        info['currency'],
        info['totalItems'],
        info['currencySymbol'],
        info['totalAmount'].toDouble(),
        info['orderId'],
        customerInfo['name'],
        customerInfo['address'],
        customerInfo['city'],
        customerInfo['state'],
        customerInfo['postalCode'],
        customerInfo['phoneNumber'],
        info['paymentGateway']['paymentType'],
        data['items'],
      );
      checkout.onLoadfinished();
    } catch (e) {
      checkout.onError(e.toString());
      checkout.onLoadfinished();
    }
  }

  void checkoutItemVariant(String itemId, int quantity, String variantTag,
      CheckoutItemVariant checkout) async {
    checkout.onLoading();

    final url = "https://api.plentrasphere.com/v2/client/index.php";
    final body = {
      'class': 'checkout',
      "appKey": appKey,
      "action": "checkout",
      "isMobile": "yes",
      "hostname": "window.location.hostname",
      "itemId": itemId,
      "variantTag": variantTag,
      "quantity": quantity.toString(),
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          'Authorization': 'Bearer $token'
        },
        body: body,
      );

      final data = json.decode(response.body);
      int code = data['response']['code'];
      String status = data['response']['status'];

      if (code == 400) {
        if (status == "variant-not-found") {
          checkout.onVariantNotFound();
          checkout.onLoadfinished();
          return;
        }

        if (status == "please-login" || status == "session-expired") {
          checkout.onNotLoggedIn();
          checkout.onLoadfinished();
          return;
        }
        if (status == "pincode-not-serviceable") {
          checkout.onPinCodeNotServicable();
          checkout.onLoadfinished();
          return;
        }
        if (status == "app-expired") {
          checkout.onAppNotActive(data['info']['appName']);
          checkout.onLoadfinished();
          return;
        }
        if (status == "no-addresses-available") {
          checkout.onAddressNotAvailable();
          checkout.onLoadfinished();
          return;
        }
        if (status == "item-not-found" ||
            status == "not-in-stock" ||
            status == "cart-empty") {
          checkout.onError(status);
          checkout.onLoadfinished();
          return;
        }

        checkout.onError(status);
        checkout.onLoadfinished();
        return;
      }

      Map<String, dynamic> info = data['info'];
      Map<String, dynamic> customerInfo = data['customerInfo'];

      if (info['totalItems'] == 0) {
        checkout.onEmpty();
        checkout.onLoadfinished();
        return;
      }

      if (info['timeSlots']['status']) {
        checkout.onTimeSlots(
            info['timeSlots']['dates'], info['timeSlots']['slots']);
      }

      // if (info.containsKey('paymentGatewayKey') &&
      //     info.containsKey('paymentGatewayType') &&
      //     info.containsKey('paymentGatewayName')) {
      //   checkout.onPaymentGateway(info['paymentGatewayName'],
      //       info['paymentGatewayType'], info['paymentGatewayKey']);
      // }

      if (info.containsKey("paymentGateway")) {
        var paymentGateway = info['paymentGateway'];
        if (paymentGateway['type'] == 0) {
          checkout.onRazorpay(paymentGateway['key']);
        }
        if (paymentGateway['type'] == 1) {
          checkout.onStripe(
              paymentGateway['clientSecret'], paymentGateway['publishableKey']);
        }
        if (paymentGateway['type'] == 2) {
          checkout.onPhonePe(paymentGateway['paymentLink']);
        }
      }

      checkout.onResult(
        info['appName'],
        info['appIcon'],
        info['currency'],
        info['totalItems'],
        info['currencySymbol'],
        info['totalAmount'].toDouble(),
        info['orderId'],
        customerInfo['name'],
        customerInfo['address'],
        customerInfo['city'],
        customerInfo['state'],
        customerInfo['postalCode'],
        customerInfo['phoneNumber'],
        info['paymentGateway']['paymentType'],
        data['items'],
      );
      checkout.onLoadfinished();
    } catch (e) {
      checkout.onError(e.toString());
      checkout.onLoadfinished();
    }
  }

  void checkoutCart(CheckoutCart checkout) async {
    checkout.onLoading();

    final url = "https://api.plentrasphere.com/v2/client/index.php";
    final body = {
      'class': 'checkout',
      "appKey": appKey,
      "action": "checkout",
      "isMobile": "yes",
      "hostname": "window.location.hostname",
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          'Authorization': 'Bearer $token'
        },
        body: body,
      );

      final data = json.decode(response.body);
      int code = data['response']['code'];
      String status = data['response']['status'];

      if (code == 400) {
        if (status == "please-login" || status == "session-expired") {
          checkout.onNotLoggedIn();
          checkout.onLoadfinished();
          return;
        }
        if (status == "pincode-not-serviceable") {
          checkout.onPinCodeNotServicable();
          checkout.onLoadfinished();
          return;
        }
        if (status == "app-expired") {
          checkout.onAppNotActive(data['info']['appName']);
          checkout.onLoadfinished();
          return;
        }
        if (status == "no-addresses-available") {
          checkout.onAddressNotAvailable();
          checkout.onLoadfinished();
          return;
        }
        if (status == "item-not-found" ||
            status == "not-in-stock" ||
            status == "cart-empty") {
          checkout.onError(status);
          checkout.onLoadfinished();
          return;
        }

        checkout.onError(status);
        checkout.onLoadfinished();
      }

      Map<String, dynamic> info = data['info'];
      Map<String, dynamic> customerInfo = data['customerInfo'];

      if (info['totalItems'] == 0) {
        checkout.onEmpty();
        checkout.onLoadfinished();
        return;
      }

      if (info['timeSlots']['status']) {
        checkout.onTimeSlots(
            info['timeSlots']['dates'], info['timeSlots']['slots']);
      }

      // if (info.containsKey('paymentGatewayKey') &&
      //     info.containsKey('paymentGatewayType') &&
      //     info.containsKey('paymentGatewayName')) {
      //   checkout.onPaymentGateway(info['paymentGatewayName'],
      //       info['paymentGatewayType'], info['paymentGatewayKey']);
      // }

      if (info.containsKey("paymentGateway")) {
        var paymentGateway = info['paymentGateway'];
        if (paymentGateway['type'] == 0) {
          checkout.onRazorpay(paymentGateway['key']);
        }
        if (paymentGateway['type'] == 1) {
          checkout.onStripe(
              paymentGateway['clientSecret'], paymentGateway['publishableKey']);
        }
        if (paymentGateway['type'] == 2) {
          checkout.onPhonePe(paymentGateway['paymentLink']);
        }
      }
      checkout.onResult(
        info['appName'],
        info['appIcon'],
        info['currency'],
        info['totalItems'],
        info['currencySymbol'],
        info['totalAmount'].toDouble(),
        info['orderId'],
        customerInfo['name'],
        customerInfo['address'],
        customerInfo['city'],
        customerInfo['state'],
        customerInfo['postalCode'],
        customerInfo['phoneNumber'],
        info['paymentGateway']['paymentType'],
        data['items'],
      );
      checkout.onLoadfinished();
    } catch (e) {
      checkout.onError(e.toString());
      checkout.onLoadfinished();
    }
  }

  void addAddress(String address, AddAddress addAddress) async {
    addAddress.onLoading();

    final url = "https://api.plentrasphere.com/v2/client/index.php";
    final body = {
      'class': 'address',
      "appKey": appKey,
      "action": "addAddress",
      "address": address,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          'Authorization': 'Bearer $token'
        },
        body: body,
      );

      final data = json.decode(response.body);
      int code = data['response']['code'];
      String status = data['response']['status'];

      if (code == 400) {
        if (status == "session-expired" || status == "please-login") {
          addAddress.onNotLoggedIn();
          addAddress.onLoadfinished();
          return;
        }
        if (status == "app-expired") {
          addAddress.onAppNotActive(data['info']['appName']);
          addAddress.onLoadfinished();
          return;
        }
        if (status == "address-max-limit-reached") {
          addAddress.onAddressMaxLimitReached();
          addAddress.onLoadfinished();
          return;
        }
        addAddress.onError(status);
        addAddress.onLoadfinished();
        return;
      }

      addAddress.onSuccess(status);
      addAddress.onLoadfinished();
    } catch (e) {
      addAddress.onError(e.toString());
      addAddress.onLoadfinished();
    }
  }

  void updateAddress(String addressId, String updatedAddress,
      UpdateAddress updateAddress) async {
    updateAddress.onLoading();

    final url = "https://api.plentrasphere.com/v2/client/index.php";
    final body = {
      'class': 'address',
      "appKey": appKey,
      "action": "updateAddress",
      "addressId": addressId,
      "address": updatedAddress,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          'Authorization': 'Bearer $token'
        },
        body: body,
      );

      final data = json.decode(response.body);
      int code = data['response']['code'];
      String status = data['response']['status'];

      if (code == 400) {
        if (status == "session-expired" || status == "please-login") {
          updateAddress.onNotLoggedIn();
          updateAddress.onLoadfinished();
          return;
        }
        if (status == "app-expired") {
          updateAddress.onAppNotActive(data['info']['appName']);
          updateAddress.onLoadfinished();
          return;
        }

        updateAddress.onError(status);
        updateAddress.onLoadfinished();
        return;
      }

      updateAddress.onSuccess(status);
      updateAddress.onLoadfinished();
    } catch (e) {
      updateAddress.onError(e.toString());
      updateAddress.onLoadfinished();
    }
  }

  void setDefault(String addressId, SetDefault setDefault) async {
    setDefault.onLoading();

    final url = "https://api.plentrasphere.com/v2/client/index.php";
    final body = {
      'class': 'address',
      "appKey": appKey,
      "action": "setDefault",
      "addressId": addressId,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          'Authorization': 'Bearer $token'
        },
        body: body,
      );

      final data = json.decode(response.body);
      int code = data['response']['code'];
      String status = data['response']['status'];

      if (code == 400) {
        if (status == "session-expired" || status == "please-login") {
          setDefault.onNotLoggedIn();
          setDefault.onLoadfinished();
          return;
        }
        if (status == "app-expired") {
          setDefault.onAppNotActive(data['info']['appName']);
          setDefault.onLoadfinished();
          return;
        }

        setDefault.onError(status);
        setDefault.onLoadfinished();
        return;
      }

      setDefault.onSuccess(status);
      setDefault.onLoadfinished();
    } catch (e) {
      setDefault.onError(e.toString());
      setDefault.onLoadfinished();
    }
  }

  void removeAddress(String addressId, RemoveAddress removeAddress) async {
    removeAddress.onLoading();

    final url = "https://api.plentrasphere.com/v2/client/index.php";
    final body = {
      'class': 'address',
      "appKey": appKey,
      "action": "removeAddress",
      "addressId": addressId,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          'Authorization': 'Bearer $token'
        },
        body: body,
      );

      final data = json.decode(response.body);
      int code = data['response']['code'];
      String status = data['response']['status'];

      if (code == 400) {
        if (status == "session-expired" || status == "please-login") {
          removeAddress.onNotLoggedIn();
          removeAddress.onLoadfinished();
          return;
        }
        if (status == "app-expired") {
          removeAddress.onAppNotActive(data['info']['appName']);
          removeAddress.onLoadfinished();
          return;
        }

        removeAddress.onError(status);
        removeAddress.onLoadfinished();
        return;
      }

      removeAddress.onSuccess(status);
      removeAddress.onLoadfinished();
    } catch (e) {
      removeAddress.onError(e.toString());
      removeAddress.onLoadfinished();
    }
  }

  void getAddresses(GetAddresses getAddresses) async {
    getAddresses.onLoading();

    final url = "https://api.plentrasphere.com/v2/client/index.php";
    final body = {
      'class': 'address',
      "appKey": appKey,
      "action": "getAddresses",
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          'Authorization': 'Bearer $token'
        },
        body: body,
      );

      final data = json.decode(response.body);
      int code = data['response']['code'];
      String status = data['response']['status'];

      if (code == 400) {
        if (status == "no-addresses-available") {
          getAddresses.onEmpty();
          getAddresses.onLoadfinished();
          return;
        }
        if (status == "session-expired" || status == "please-login") {
          getAddresses.onNotLoggedIn();
          getAddresses.onLoadfinished();
          return;
        }
        if (status == "app-expired") {
          getAddresses.onAppNotActive(data['info']['appName']);
          getAddresses.onLoadfinished();
          return;
        }

        getAddresses.onError(status);
        getAddresses.onLoadfinished();
        return;
      }

      List<Map<String, dynamic>> addresses = [];
      data['addresses'].forEach((address) {
        addresses.add({
          "addressId": address['addressId'],
          "name": address['addressInfo']['name'],
          "address": address['addressInfo']['address'],
          "city": address['addressInfo']['city'],
          "state": address['addressInfo']['state'],
          "postalCode": address['addressInfo']['postalCode'],
          "phoneNumber": address['addressInfo']['phoneNumber'],
          "lat": address['addressInfo']['lat'],
          "lng": address['addressInfo']['lng'],
          "default": address['default'],
        });
      });

      getAddresses.onResult(
          data['info']['appName'], data['info']['itemCount'], addresses);
      getAddresses.onLoadfinished();
    } catch (e) {
      getAddresses.onError(e.toString());
      getAddresses.onLoadfinished();
    }
  }

  void clearCart(ClearCart clearCart) async {
    clearCart.onLoading();

    final url = "https://api.plentrasphere.com/v2/client/index.php";
    final body = {
      'class': 'cart',
      "appKey": appKey,
      "action": "clearCart",
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          'Authorization': 'Bearer $token'
        },
        body: body,
      );

      final data = json.decode(response.body);
      int code = data['response']['code'];
      String status = data['response']['status'];

      if (code == 400) {
        if (status == "session-expired" || status == "please-login") {
          clearCart.onNotLoggedIn();
          clearCart.onLoadfinished();
          return;
        }
        if (status == "app-expired") {
          clearCart.onAppNotActive(data['info']['appName']);
          clearCart.onLoadfinished();
          return;
        }

        clearCart.onError(status);
        clearCart.onLoadfinished();
        return;
      }

      clearCart.onSuccess(status);
      clearCart.onLoadfinished();
    } catch (e) {
      clearCart.onError(e.toString());
      clearCart.onLoadfinished();
    }
  }

  void removeFromCart(String itemId, RemoveFromCart removeFromCart) async {
    removeFromCart.onLoading();

    final url = "https://api.plentrasphere.com/v2/client/index.php";
    final body = {
      'class': 'cart',
      "appKey": appKey,
      "action": "removeFromCart",
      "itemId": itemId,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          'Authorization': 'Bearer $token'
        },
        body: body,
      );

      final data = json.decode(response.body);
      int code = data['response']['code'];
      String status = data['response']['status'];

      if (code == 400) {
        if (status == "session-expired" || status == "please-login") {
          removeFromCart.onNotLoggedIn();
          removeFromCart.onLoadfinished();
          return;
        }
        if (status == "app-expired") {
          removeFromCart.onAppNotActive(data['info']['appName']);
          removeFromCart.onLoadfinished();
          return;
        }

        removeFromCart.onError(status);
        removeFromCart.onLoadfinished();
        return;
      }

      removeFromCart.onSuccess(status);
      removeFromCart.onLoadfinished();
    } catch (e) {
      removeFromCart.onError(e.toString());
      removeFromCart.onLoadfinished();
    }
  }

  void updateCart(String itemId, int quantity, UpdateCart updateCart) async {
    updateCart.onLoading();

    final url = "https://api.plentrasphere.com/v2/client/index.php";
    final body = {
      'class': 'cart',
      "appKey": appKey,
      "action": "updateCart",
      "itemId": itemId,
      "quantity": quantity.toString(),
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          'Authorization': 'Bearer $token'
        },
        body: body,
      );

      final data = json.decode(response.body);
      int code = data['response']['code'];
      String status = data['response']['status'];

      if (code == 400) {
        if (status == "session-expired" || status == "please-login") {
          updateCart.onNotLoggedIn();
          updateCart.onLoadfinished();
          return;
        }
        if (status == "app-expired") {
          updateCart.onAppNotActive(data['info']['appName']);
          updateCart.onLoadfinished();
          return;
        }

        updateCart.onError(status);
        updateCart.onLoadfinished();
        return;
      }

      updateCart.onSuccess(status);
      updateCart.onLoadfinished();
    } catch (e) {
      updateCart.onError(e.toString());
      updateCart.onLoadfinished();
    }
  }

  void addToCart(String itemId, int quantity, AddToCart addToCart) async {
    addToCart.onLoading();

    final url = "https://api.plentrasphere.com/v2/client/index.php";
    final body = {
      'class': 'cart',
      "appKey": appKey,
      "action": "addToCart",
      "itemId": itemId,
      "quantity": quantity.toString(),
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          'Authorization': 'Bearer $token'
        },
        body: body,
      );

      final data = json.decode(response.body);
      int code = data['response']['code'];
      String status = data['response']['status'];

      if (code == 400) {
        if (status == "variants-found") {
          addToCart.onVariants(data['variants']);
          addToCart.onLoadfinished();
          return;
        }

        if (status == "session-expired" || status == "please-login") {
          addToCart.onNotLoggedIn();
          addToCart.onLoadfinished();
          return;
        }

        if (status == "app-expired") {
          addToCart.onAppNotActive(data['info']['appName']);
          addToCart.onLoadfinished();
          return;
        }

        if (status == "item-already-added") {
          addToCart.onItemAlreadyAdded();
          addToCart.onLoadfinished();
          return;
        }

        if (status == "not-in-stock") {
          addToCart.onItemNotInStock();
          addToCart.onLoadfinished();
          return;
        }

        if (status == "cart-max-limit-reached") {
          addToCart.onCartMaxLimitReached();
          addToCart.onLoadfinished();
          return;
        }

        addToCart.onError(status);
        addToCart.onLoadfinished();
        return;
      }

      addToCart.onSuccess(status);
      addToCart.onLoadfinished();
    } catch (e) {
      addToCart.onError(e.toString());
      addToCart.onLoadfinished();
    }
  }

  void addToCartVariant(String itemId, int quantity, String variantTag,
      AddToCartVariant addToCartVariant) async {
    addToCartVariant.onLoading();

    final url = "https://api.plentrasphere.com/v2/client/index.php";
    final body = {
      'class': 'cart',
      "appKey": appKey,
      "action": "addToCart",
      "itemId": itemId,
      "quantity": quantity.toString(),
      "variantTag": variantTag,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          'Authorization': 'Bearer $token'
        },
        body: body,
      );

      final data = json.decode(response.body);
      int code = data['response']['code'];
      String status = data['response']['status'];

      if (code == 400) {
        if (status == "session-expired" || status == "please-login") {
          addToCartVariant.onNotLoggedIn();
          addToCartVariant.onLoadfinished();
          return;
        }

        if (status == "app-expired") {
          addToCartVariant.onAppNotActive(data['info']['appName']);
          addToCartVariant.onLoadfinished();
          return;
        }

        if (status == "item-already-added") {
          addToCartVariant.onItemAlreadyAdded();
          addToCartVariant.onLoadfinished();
          return;
        }

        if (status == "not-in-stock") {
          addToCartVariant.onVariantNotInStock();
          addToCartVariant.onLoadfinished();
          return;
        }

        if (status == "cart-max-limit-reached") {
          addToCartVariant.onCartMaxLimitReached();
          addToCartVariant.onLoadfinished();
          return;
        }

        if (status == "variant-not-found") {
          addToCartVariant.onVariantNotFound();
          addToCartVariant.onLoadfinished();
          return;
        }

        addToCartVariant.onError(status);
        addToCartVariant.onLoadfinished();
        return;
      }

      addToCartVariant.onSuccess(status);
      addToCartVariant.onLoadfinished();
    } catch (e) {
      addToCartVariant.onError(e.toString());
      addToCartVariant.onLoadfinished();
    }
  }

  void getCart(GetCart getCart) async {
    getCart.onLoading();

    final url = "https://api.plentrasphere.com/v2/client/index.php";
    final body = {
      'class': 'cart',
      "appKey": appKey,
      "action": "getCart",
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          'Authorization': 'Bearer $token'
        },
        body: body,
      );

      final data = json.decode(response.body);
      int code = data['response']['code'];
      String status = data['response']['status'];

      if (code == 400) {
        if (status == "cart-empty") {
          getCart.onEmpty();
          getCart.onLoadfinished();
          return;
        }

        if (status == "session-expired" || status == "please-login") {
          getCart.onNotLoggedIn();
          getCart.onLoadfinished();
          return;
        }

        if (status == "app-expired") {
          getCart.onAppNotActive(data['info']['appName']);
          getCart.onLoadfinished();
          return;
        }

        getCart.onError(status);
        getCart.onLoadfinished();
        return;
      }

      Map<String, dynamic> info = data['info'];
      List<dynamic> items = data['items'];

      getCart.onResult(
        info['appName'],
        info['currency'],
        info['currencySymbol'],
        info['totalAmount'].toDouble().toDouble(),
        info['totalItems'],
        items,
      );
      getCart.onLoadfinished();
    } catch (e) {
      getCart.onError(e.toString());
      getCart.onLoadfinished();
    }
  }

  void clearWishlist(ClearWishlist clearWishlist) async {
    clearWishlist.onLoading();

    final url = "https://api.plentrasphere.com/v2/client/index.php";
    final body = {
      'class': 'wishlist',
      "appKey": appKey,
      "action": "clearWishlist",
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          'Authorization': 'Bearer $token'
        },
        body: body,
      );

      final data = json.decode(response.body);
      int code = data['response']['code'];
      String status = data['response']['status'];

      if (code == 400) {
        if (status == "session-expired" || status == "please-login") {
          clearWishlist.onNotLoggedIn();
          clearWishlist.onLoadfinished();
          return;
        }

        if (status == "app-expired") {
          clearWishlist.onAppNotActive(data['info']['appName']);
          clearWishlist.onLoadfinished();
          return;
        }

        clearWishlist.onError(status);
        clearWishlist.onLoadfinished();
        return;
      }

      clearWishlist.onSuccess(status);
      clearWishlist.onLoadfinished();
    } catch (e) {
      clearWishlist.onError(e.toString());
      clearWishlist.onLoadfinished();
    }
  }

  void removeFromWishlist(
      String itemId, RemoveFromWishlist removeFromWishlist) async {
    removeFromWishlist.onLoading();

    final url = "https://api.plentrasphere.com/v2/client/index.php";
    final body = {
      'class': 'wishlist',
      "appKey": appKey,
      "action": "removeFromWishlist",
      "itemId": itemId,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          'Authorization': 'Bearer $token'
        },
        body: body,
      );

      final data = json.decode(response.body);
      int code = data['response']['code'];
      String status = data['response']['status'];

      if (code == 400) {
        if (status == "session-expired" || status == "please-login") {
          removeFromWishlist.onNotLoggedIn();
          removeFromWishlist.onLoadfinished();
          return;
        }

        if (status == "app-expired") {
          removeFromWishlist.onAppNotActive(data['info']['appName']);
          removeFromWishlist.onLoadfinished();
          return;
        }

        removeFromWishlist.onError(status);
        removeFromWishlist.onLoadfinished();
        return;
      }

      removeFromWishlist.onSuccess(status);
      removeFromWishlist.onLoadfinished();
    } catch (e) {
      removeFromWishlist.onError(e.toString());
      removeFromWishlist.onLoadfinished();
    }
  }

  void addToWishlist(String itemId, AddtoWishlist addToWishlist) async {
    addToWishlist.onLoading();

    final url = "https://api.plentrasphere.com/v2/client/index.php";
    final body = {
      'class': 'wishlist',
      "appKey": appKey,
      "action": "addToWishlist",
      "itemId": itemId,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          'Authorization': 'Bearer $token'
        },
        body: body,
      );

      final data = json.decode(response.body);
      int code = data['response']['code'];
      String status = data['response']['status'];

      if (code == 400) {
        if (status == "session-expired" || status == "please-login") {
          addToWishlist.onNotLoggedIn();
          addToWishlist.onLoadfinished();
          return;
        }

        if (status == "app-expired") {
          addToWishlist.onAppNotActive(data['info']['appName']);
          addToWishlist.onLoadfinished();
          return;
        }

        if (status == "wishlist-max-limit-reached") {
          addToWishlist.onWishlistMaxLimitReached();
          addToWishlist.onLoadfinished();
          return;
        }

        if (status == "item-already-added") {
          addToWishlist.onItemAlreadyAdded();
          addToWishlist.onLoadfinished();
          return;
        }

        addToWishlist.onError(status);
        addToWishlist.onLoadfinished();
        return;
      }

      addToWishlist.onSuccess(status);
      addToWishlist.onLoadfinished();
    } catch (e) {
      addToWishlist.onError(e.toString());
      addToWishlist.onLoadfinished();
    }
  }

  void getWishlist(int page, GetWishlist getWishlist) async {
    getWishlist.onLoading();

    final url = "https://api.plentrasphere.com/v2/client/index.php";
    final body = {
      'class': 'wishlist',
      "appKey": appKey,
      "action": "getWishlist",
      "page": page.toString(),
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          'Authorization': 'Bearer $token'
        },
        body: body,
      );

      final data = json.decode(response.body);
      int code = data['response']['code'];
      String status = data['response']['status'];

      if (code == 400) {
        if (status == "session-expired" || status == "please-login") {
          getWishlist.onNotLoggedIn();
          getWishlist.onLoadfinished();
          return;
        }

        if (status == "app-expired") {
          getWishlist.onAppNotActive(data['info']['appName']);
          getWishlist.onLoadfinished();
          return;
        }

        getWishlist.onError(status);
        getWishlist.onLoadfinished();
        return;
      }

      final info = data['info'];

      if (info['nextPage']['status']) {
        getWishlist.onNextPage(info['nextPage']['page']);
      } else {
        getWishlist.onNoNextPage();
      }

      if (info['itemsInThisPage'] == 0) {
        getWishlist.onEmpty();
        getWishlist.onLoadfinished();
        return;
      }

      getWishlist.onResult(
        info['appName'],
        info['totalItemCount'],
        info['itemsInThisPage'],
        info['itemsPerPage'],
        data['items'],
      );
      getWishlist.onLoadfinished();
    } catch (e) {
      getWishlist.onError(e.toString());
      getWishlist.onLoadfinished();
    }
  }

//
}
