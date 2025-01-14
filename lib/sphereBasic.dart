import 'dart:convert';
import 'package:http/http.dart' as http;
import 'abstractClasses/get_app_info.dart';
import 'abstractClasses/get_commerce_info.dart';
import 'abstractClasses/get_item.dart';
import 'abstractClasses/get_variant.dart';
import 'abstractClasses/get_items.dart';
import 'abstractClasses/get_items_load_more.dart';
import 'abstractClasses/get_items_search.dart';
import 'abstractClasses/get_items_search_load_more.dart';
import 'abstractClasses/get_launcher_load_more.dart';
import 'abstractClasses/get_launcher.dart';
import 'abstractClasses/get_page.dart';
import 'abstractClasses/get_home_load_more.dart';
import 'abstractClasses/get_home.dart';
import 'abstractClasses/plentra_login.dart';

class SphereBasic {
  String appKey;

  SphereBasic(this.appKey);

  void plentraLogin(
      String emailId, String password, PlentraLogin plentraLogin) async {
    plentraLogin.onLoading();

    if (emailId.isEmpty) {
      plentraLogin.onEmailIdNotProvided();
      plentraLogin.onLoadfinished();
      return;
    }

    if (password.isEmpty) {
      plentraLogin.onPasswordNotProvided();
      plentraLogin.onLoadfinished();
      return;
    }

    final loginUrl =
        "https://api.plentrasphere.com/v2/client/accounts/index.php";
    final loginBody = {
      "email": emailId,
      "password": password,
      "action": "getLoginToken",
    };

    try {
      final loginResponse = await http.post(
        Uri.parse(loginUrl),
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: loginBody,
      );

      final loginData = json.decode(loginResponse.body);
      int loginCode = loginData['response']['code'];
      String loginStatus = loginData['response']['status'];

      if (loginCode == 400) {
        if (loginStatus == "invalid-email") {
          plentraLogin.onInvalidEmailId();
          plentraLogin.onLoadfinished();
          return;
        }

        if (loginStatus == "invalid-credentials") {
          plentraLogin.onInvalidCredentials();
          plentraLogin.onLoadfinished();
          return;
        }

        plentraLogin.onError(loginStatus);
        plentraLogin.onLoadfinished();
        return;
      }

      final loginToken = loginData['token'];

      final adminUrl =
          "https://api.plentrasphere.com/v2/client/admin/index.php";
      final adminBody = {
        "action": "loggin",
        "token": loginToken,
        "type": "auth",
      };

      final adminResponse = await http.post(
        Uri.parse(adminUrl),
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: adminBody,
      );

      final adminData = json.decode(adminResponse.body);
      int adminCode = adminData['response']['code'];
      String adminStatus = adminData['response']['status'];

      if (adminCode == 400) {
        plentraLogin.onError(adminStatus);
        plentraLogin.onLoadfinished();
        return;
      }

      final adminToken = adminData['token'];

      plentraLogin.onSuccess(adminToken);
      plentraLogin.onLoadfinished();
    } catch (e) {
      print(e);
      plentraLogin.onError(e.toString());
      plentraLogin.onLoadfinished();
    }
  }

  Future<void> getCommerceInfo(GetCommerceInfo getCommerceInfo) async {
    getCommerceInfo.onLoading();

    final url = Uri.parse(
        'https://api.plentrasphere.com/v2/client/?class=default&action=getCommerceInfo&appKey=$appKey');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        final code = jsonData['response']['code'];
        final status = jsonData['response']['status'];
        final info = jsonData['info'];

        if (code == 400) {
          if (status == "app-expired") {
            getCommerceInfo.onAppNotActive(info['appName']);
            getCommerceInfo.onLoadfinished();
            return;
          }
          getCommerceInfo.onError(status);
          getCommerceInfo.onLoadfinished();
          return;
        }

        if (info['homeCover']['status']) {
          getCommerceInfo.onHomeCover(info['homeCover']['image']);
        }

        if (info['firebase']['status'] == true) {
          getCommerceInfo.onfirebaseAuth(jsonEncode(info['firebase']));
        }

        if (info.containsKey('paymentGatewayKey') &&
            info.containsKey('paymentGatewayType') &&
            info.containsKey('paymentGatewayName')) {
          getCommerceInfo.onPaymentGateway(info['paymentGatewayName'],
              info['paymentGatewayType'], info['paymentGatewayKey']);
        }

        getCommerceInfo.onResult(
          info['appName'],
          info['appIcon'],
          info['appType'],

          info['appLocation'], // Pass the appLocation map directly
        );
        getCommerceInfo.onLoadfinished();
      } else {
        getCommerceInfo.onError('HTTP ${response.statusCode}');
        getCommerceInfo.onLoadfinished();
      }
    } catch (e) {
      getCommerceInfo.onError(e.toString());
      getCommerceInfo.onLoadfinished();
    }
  }

  Future<void> getAppInfo(GetAppInfo getAppInfo) async {
    getAppInfo.onLoading();

    final url = Uri.parse(
        'https://api.plentrasphere.com/v2/client/?class=default&action=getAppInfo&appKey=$appKey');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        final code = jsonData['response']['code'];
        final status = jsonData['response']['status'];
        final info = jsonData['info'];

        if (code == 400) {
          if (status == "app-expired") {
            getAppInfo.onAppNotActive(info['appName']);
            getAppInfo.onLoadfinished();
            return;
          }

          getAppInfo.onError(status);
          getAppInfo.onLoadfinished();
          return;
        }

        if (info['homeCover']['status']) {
          getAppInfo.onHomeCover(info['homeCover']['image']);
        }

        if (info['whatsappChat']['status']) {
          getAppInfo.onWhatsappChat(info['whatsappChat']['dialingCode']['code'],
              info['whatsappChat']['phoneNumber']);
        }

        getAppInfo.onResult(
          info['appName'],
          info['appIcon'],
          info['appType'],
          info['appLocation'],
        );
        getAppInfo.onLoadfinished();
      } else {
        getAppInfo.onError('HTTP ${response.statusCode}');
        getAppInfo.onLoadfinished();
      }
    } catch (e) {
      getAppInfo.onError(e.toString());
      getAppInfo.onLoadfinished();
    }
  }

  Future<void> getItem(String itemId, GetItem getItem) async {
    getItem.onLoading();

    final url = Uri.parse(
        'https://api.plentrasphere.com/v2/client/?class=default&action=getItem&appKey=${this.appKey}&itemId=$itemId');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final code = jsonData['response']['code'];
        final status = jsonData['response']['status'];
        final info = jsonData['info'];

        if (code == 401) {
          getItem.onError(status);
          getItem.onLoadfinished();
          return;
        } else if (code == 404) {
          getItem.onNotFound();
          getItem.onLoadfinished();
          return;
        } else if (code == 400) {
          if (status == "app-expired") {
            getItem.onAppNotActive(info['appName']);
            getItem.onLoadfinished();
            return;
          }
          getItem.onError(status);
          getItem.onLoadfinished();
          return;
        } else if (code == 406) {
          getItem.onError(status);
          getItem.onLoadfinished();
          return;
        }

        if (status == "under-construction") {
          getItem.onUnderConstruction();
          getItem.onLoadfinished();
          return;
        }

        if (jsonData['announcement']['status']) {
          getItem.onAnnouncement(jsonData['announcement']['announcementBody']);
        }

        if (info['appLocation']['status']) {
          final location = info['appLocation'];

          getItem.onAppLocation(
            location['location'],
            (location['lat']),
            (location['lon']),
          );
        }

        if (info['homeCover']['status']) {
          getItem.onHomeCover(info['homeCover']['image']);
        }

        if (jsonData['video']['status']) {
          getItem.onVideo(jsonData['video']['video']);
        }

        getItem.onResult(
          info['appName'],
          info['appIcon'],
          jsonData['itemName'],
          jsonData['extras'],
          utf8.decode(base64.decode(jsonData['body'])),
          jsonData['itemCategoryName'],
          jsonData['itemCategory'],
          jsonData['itemImages'],
          jsonData['itemImage'],
        );

        if (jsonData['variants']['status']) {
          final firstVariant = jsonData['variants']['firstVariant'];
          getItem.onFirstVariant(
            firstVariant['variantTag'],
            firstVariant['variantId'],
            firstVariant['variantExtras'],
            firstVariant['variantImage'],
            firstVariant['variantImages'],
          );

          getItem.onVariants(jsonData['variants']['variants']);
        }
        getItem.onLoadfinished();
      } else {
        getItem.onError('HTTP ${response.statusCode}');
        getItem.onLoadfinished();
      }
    } catch (e) {
      getItem.onError(e.toString());
      getItem.onLoadfinished();
    }
  }

  Future<void> getVariant(String variantId, GetVariant getVariant) async {
    getVariant.onLoading();

    final url = Uri.parse(
        'https://api.plentrasphere.com/v2/client/?class=default&action=getVariant&appKey=$appKey&variantId=$variantId');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        final code = jsonData['response']['code'];
        final status = jsonData['response']['status'];

        if (code == 401) {
          getVariant.onError(status);
          getVariant.onLoadfinished();
          return;
        } else if (code == 404) {
          getVariant.onNotFound();
          getVariant.onLoadfinished();
          return;
        } else if (code == 400) {
          if (status == "app-expired") {
            getVariant.onAppNotActive(jsonData['info']['appName']);
            getVariant.onLoadfinished();
            return;
          }

          getVariant.onError(status);
          getVariant.onLoadfinished();
          return;
        } else if (code == 406) {
          getVariant.onError(status);
          return;
        }

        if (status == "under-construction") {
          getVariant.onUnderConstruction();
          getVariant.onLoadfinished();
          return;
        }

        getVariant.onResult(
          jsonData['variantTag'],
          jsonData['variantId'],
          jsonData['variantExtras'],
          jsonData['variantImage'],
          jsonData['variantImages'],
        );

        getVariant.onLoadfinished();
      } else {
        getVariant.onError('HTTP ${response.statusCode}');
        getVariant.onLoadfinished();
      }
    } catch (e) {
      getVariant.onError(e.toString());
      getVariant.onLoadfinished();
    }
  }

  Future<void> getItemsLoadMore(
    String itemCategory,
    int itemsPageNumber,
    GetItemsLoadMore getItemsLoadMore,
  ) async {
    getItemsLoadMore.onLoading();

    final url = Uri.parse(
        'https://api.plentrasphere.com/v2/client/?class=default&action=getItems&appKey=$appKey&page=$itemsPageNumber&categoryId=$itemCategory');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        final code = jsonData['response']['code'];
        final status = jsonData['response']['status'];

        if (code == 401) {
          getItemsLoadMore.onError(status);
          getItemsLoadMore.onLoadfinished();
          return;
        } else if (code == 404) {
          getItemsLoadMore.onNotFound();
          getItemsLoadMore.onLoadfinished();
          return;
        } else if (code == 400) {
          if (status == "app-expired") {
            getItemsLoadMore.onAppNotActive(jsonData['info']['appName']);
            getItemsLoadMore.onLoadfinished();
            return;
          }

          getItemsLoadMore.onError(status);
          getItemsLoadMore.onLoadfinished();
          return;
        } else if (code == 406) {
          getItemsLoadMore.onError(status);
          return;
        }

        if (status == "under-construction") {
          getItemsLoadMore.onUnderConstruction();
          getItemsLoadMore.onLoadfinished();
          return;
        }

        final info = jsonData['info'];
        final itemsInThisPage = (info['itemsInThisPage']);
        final totalItemCount = (info['totalItemCount']);

        if (info['nextPage']['status']) {
          getItemsLoadMore.onNextPage(info['nextPage']['page']);
        } else {
          getItemsLoadMore.onNoNextPage();
        }

        if (itemsInThisPage != 0) {
          final List<dynamic> items = [];
          final _items = jsonData['items'];

          _items.forEach((element) {
            items.add({
              'itemName': element['itemName'],
              'itemId': element['itemId'],
              'extras': element['extras'],
              'itemImage': element['itemImage'],
            });
          });

          getItemsLoadMore.onResult(
            itemCategory,
            totalItemCount,
            itemsInThisPage,
            (info['itemsPerPage']),
            items,
          );
        } else {
          getItemsLoadMore.onEmpty();
        }

        getItemsLoadMore.onLoadfinished();
      } else {
        getItemsLoadMore.onError('HTTP ${response.statusCode}');
        getItemsLoadMore.onLoadfinished();
      }
    } catch (e) {
      getItemsLoadMore.onError(e.toString());
      getItemsLoadMore.onLoadfinished();
    }
  }

  Future<void> getItems(String itemCategory, GetItems getItems) async {
    getItems.onLoading();

    final url = Uri.parse(
        'https://api.plentrasphere.com/v2/client/?class=default&action=getItems&appKey=$appKey&page=1&categoryId=$itemCategory');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        final code = jsonData['response']['code'];
        final status = jsonData['response']['status'];

        if (code == 401) {
          getItems.onError(status);
          getItems.onLoadfinished();
          return;
        } else if (code == 404) {
          getItems.onNotFound();
          getItems.onLoadfinished();
          return;
        } else if (code == 400) {
          if (status == "app-expired") {
            getItems.onAppNotActive(jsonData['info']['appName']);
            getItems.onLoadfinished();
            return;
          }

          getItems.onError(status);
          getItems.onLoadfinished();
          return;
        } else if (code == 406) {
          getItems.onError(status);
          return;
        }

        if (status == "under-construction") {
          getItems.onUnderConstruction();
          getItems.onLoadfinished();
          return;
        }

        final info = jsonData['info'];
        final itemsInThisPage = (info['itemsInThisPage']);
        final totalItemCount = (info['totalItemCount']);

        if (info['appLocation']['status']) {
          final location = info['appLocation'];
          getItems.onAppLocation(
            location['location'],
            (location['lat']),
            (location['lon']),
          );
        }

        if (jsonData['announcement']['status']) {
          getItems.onAnnouncement(jsonData['announcement']['announcementBody']);
        }

        if (info['homeCover']['status']) {
          getItems.onHomeCover(info['homeCover']['image']);
        }

        if (info['nextPage']['status']) {
          getItems.onNextPage(info['nextPage']['page']);
        } else {
          getItems.onNoNextPage();
        }

        if (itemsInThisPage != 0) {
          final List<dynamic> items = [];
          final _items = jsonData['items'];

          _items.forEach((element) {
            items.add({
              'itemName': element['itemName'],
              'itemId': element['itemId'],
              'extras': element['extras'],
              'itemImage': element['itemImage'],
            });
          });

          getItems.onResult(
            itemCategory,
            info['appName'],
            info['appIcon'],
            info['categoryName'],
            info['categoryThumbnail'],
            totalItemCount,
            itemsInThisPage,
            (info['itemsPerPage']),
            items,
          );
        } else {
          getItems.onEmpty(
            info['appName'],
            info['appIcon'],
            info['categoryName'],
            info['categoryThumbnail'],
          );
        }

        getItems.onLoadfinished();
      } else {
        getItems.onError('HTTP ${response.statusCode}');
        getItems.onLoadfinished();
      }
    } catch (e) {
      getItems.onError(e.toString());
      getItems.onLoadfinished();
    }
  }

  Future<void> getItemsSearch(String itemName, GetItemsSearch getItems) async {
    getItems.onLoading();

    final url = Uri.parse(
        'https://api.plentrasphere.com/v2/client/?class=default&action=getItemsSearch&appKey=$appKey&page=1&itemName=$itemName');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        final code = jsonData['response']['code'];
        final status = jsonData['response']['status'];

        if (code == 401) {
          getItems.onError(status);
          getItems.onLoadfinished();
          return;
        } else if (code == 404) {
          getItems.onNotFound();
          getItems.onLoadfinished();
          return;
        } else if (code == 400) {
          if (status == "app-expired") {
            getItems.onAppNotActive(jsonData['info']['appName']);
            getItems.onLoadfinished();
            return;
          }

          getItems.onError(status);
          getItems.onLoadfinished();
          return;
        } else if (code == 406) {
          getItems.onError(status);
          return;
        }

        if (status == "under-construction") {
          getItems.onUnderConstruction();
          getItems.onLoadfinished();
          return;
        }

        final info = jsonData['info'];
        final itemsInThisPage = (info['itemsInThisPage']);
        final totalItemCount = (info['totalItemCount']);

        if (info['homeCover']['status']) {
          getItems.onHomeCover(info['homeCover']['image']);
        }

        if (info['nextPage']['status']) {
          getItems.onNextPage(info['nextPage']['page']);
        } else {
          getItems.onNoNextPage();
        }

        if (itemsInThisPage != 0) {
          final List<dynamic> items = [];
          final _items = jsonData['items'];

          _items.forEach((element) {
            items.add({
              'itemName': element['itemName'],
              'itemId': element['itemId'],
              'extras': element['extras'],
              'itemImage': element['itemImage'],
            });
          });

          getItems.onResult(
            info['appName'],
            info['appIcon'],
            totalItemCount,
            itemsInThisPage,
            (info['itemsPerPage']),
            items,
          );
        } else {
          getItems.onEmpty(info['appName'], info['appIcon']);
        }

        getItems.onLoadfinished();
      } else {
        getItems.onError('HTTP ${response.statusCode}');
        getItems.onLoadfinished();
      }
    } catch (e) {
      getItems.onError(e.toString());
      getItems.onLoadfinished();
    }
  }

  Future<void> getItemsSearchLoadMore(String itemName, int itemsPageNumber,
      GetItemsSearchLoadMore getItemsLoadMore) async {
    getItemsLoadMore.onLoading();

    final url = Uri.parse(
        'https://api.plentrasphere.com/v2/client/?class=default&action=getItemsSearch&appKey=$appKey&page=$itemsPageNumber&itemName=$itemName');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        final code = jsonData['response']['code'];
        final status = jsonData['response']['status'];

        if (code == 401) {
          getItemsLoadMore.onError(status);
          getItemsLoadMore.onLoadfinished();
          return;
        } else if (code == 404) {
          getItemsLoadMore.onNotFound();
          getItemsLoadMore.onLoadfinished();
          return;
        } else if (code == 400) {
          if (status == "app-expired") {
            getItemsLoadMore.onAppNotActive(jsonData['info']['appName']);
            getItemsLoadMore.onLoadfinished();
            return;
          }

          getItemsLoadMore.onError(status);
          getItemsLoadMore.onLoadfinished();
          return;
        } else if (code == 406) {
          getItemsLoadMore.onError(status);
          return;
        }

        if (status == "under-construction") {
          getItemsLoadMore.onUnderConstruction();
          getItemsLoadMore.onLoadfinished();
          return;
        }

        final info = jsonData['info'];
        final itemsInThisPage = (info['itemsInThisPage']);
        final totalItemCount = (info['totalItemCount']);

        if (info['nextPage']['status']) {
          getItemsLoadMore.onNextPage(info['nextPage']['page']);
        } else {
          getItemsLoadMore.onNoNextPage();
        }

        if (itemsInThisPage != 0) {
          final List<dynamic> items = [];
          final _items = jsonData['items'];

          _items.forEach((element) {
            items.add({
              'itemName': element['itemName'],
              'itemId': element['itemId'],
              'extras': element['extras'],
              'itemImage': element['itemImage'],
            });
          });

          getItemsLoadMore.onResult(
            totalItemCount,
            itemsInThisPage,
            (info['itemsPerPage']),
            items,
          );
        } else {
          getItemsLoadMore.onEmpty();
        }

        getItemsLoadMore.onLoadfinished();
      } else {
        getItemsLoadMore.onError('HTTP ${response.statusCode}');
        getItemsLoadMore.onLoadfinished();
      }
    } catch (e) {
      getItemsLoadMore.onError(e.toString());
      getItemsLoadMore.onLoadfinished();
    }
  }

  Future<void> getLauncherLoadMore(String launcherId, int launcherPageNumber,
      GetLauncherLoadMore getLauncherLoadMore) async {
    getLauncherLoadMore.onLoading();

    final url = Uri.parse(
        'https://api.plentrasphere.com/v2/client/?class=default&action=getLauncher&appKey=$appKey&page=$launcherPageNumber&launcherId=$launcherId');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        final code = jsonData['response']['code'];
        final status = jsonData['response']['status'];

        if (code == 401) {
          getLauncherLoadMore.onError(status);
          getLauncherLoadMore.onLoadfinished();
          return;
        } else if (code == 404) {
          getLauncherLoadMore.onNotFound();
          getLauncherLoadMore.onLoadfinished();
          return;
        } else if (code == 400) {
          if (status == "app-expired") {
            getLauncherLoadMore.onAppNotActive(jsonData['info']['appName']);
            getLauncherLoadMore.onLoadfinished();
            return;
          }

          getLauncherLoadMore.onError(status);
          getLauncherLoadMore.onLoadfinished();
          return;
        } else if (code == 406) {
          getLauncherLoadMore.onError(status);
          return;
        }

        if (status == "under-construction") {
          getLauncherLoadMore.onUnderConstruction();
          getLauncherLoadMore.onLoadfinished();
          return;
        }

        final info = jsonData['info'];
        final itemsInThisPage = (info['itemsInThisPage']);
        final totalItemCount = (info['totalItemCount']);

        if (info['nextPage']['status']) {
          getLauncherLoadMore.onNextPage(info['nextPage']['page']);
        } else {
          getLauncherLoadMore.onNoNextPage();
        }

        if (itemsInThisPage != 0) {
          final List<dynamic> items = [];
          final _items = jsonData['items'];

          _items.forEach((element) {
            items.add({
              'itemName': element['itemName'],
              'actionType': element['actionType'],
              'action': element['action'],
              'itemImage': element['thumbnail'],
            });
          });

          getLauncherLoadMore.onResult(
            totalItemCount,
            itemsInThisPage,
            (info['itemsPerPage']),
            items,
          );
        } else {
          getLauncherLoadMore.onEmpty();
        }

        getLauncherLoadMore.onLoadfinished();
      } else {
        getLauncherLoadMore.onError('HTTP ${response.statusCode}');
        getLauncherLoadMore.onLoadfinished();
      }
    } catch (e) {
      getLauncherLoadMore.onError(e.toString());
      getLauncherLoadMore.onLoadfinished();
    }
  }

  Future<void> getLauncher(String launcherId, GetLauncher getLauncher) async {
    getLauncher.onLoading();

    final url = Uri.parse(
        'https://api.plentrasphere.com/v2/client/?class=default&action=getLauncher&appKey=$appKey&page=1&launcherId=$launcherId');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        final code = jsonData['response']['code'];
        final status = jsonData['response']['status'];

        if (code == 401) {
          getLauncher.onError(status);
          getLauncher.onLoadfinished();
          return;
        } else if (code == 404) {
          getLauncher.onNotFound();
          getLauncher.onLoadfinished();
          return;
        } else if (code == 400) {
          if (status == "app-expired") {
            getLauncher.onAppNotActive(jsonData['info']['appName']);
            getLauncher.onLoadfinished();
            return;
          }

          getLauncher.onError(status);
          getLauncher.onLoadfinished();
          return;
        } else if (code == 406) {
          getLauncher.onError(status);
          return;
        }

        if (status == "under-construction") {
          getLauncher.onUnderConstruction();
          getLauncher.onLoadfinished();
          return;
        }

        final info = jsonData['info'];

        if (info['appLocation']['status']) {
          final location = info['appLocation'];
          getLauncher.onAppLocation(
            location['location'],
            (location['lat']),
            (location['lon']),
          );
        }

        final itemsInThisPage = (info['itemsInThisPage']);
        final totalItemCount = (info['totalItemCount']);

        if (jsonData['announcement']['status']) {
          final announcement = jsonData['announcement'];
          getLauncher.onAnnouncement(announcement['announcementBody']);
        }

        if (info['launcherCover']['status']) {
          getLauncher.onLauncherCover(info['launcherCover']['image']);
        }

        if (info['nextPage']['status']) {
          getLauncher.onNextPage(info['nextPage']['page']);
        } else {
          getLauncher.onNoNextPage();
        }

        if (itemsInThisPage != 0) {
          final List<dynamic> items = [];
          final _items = jsonData['items'];

          _items.forEach((element) {
            items.add({
              'itemName': element['itemName'],
              'actionType': element['actionType'],
              'action': element['action'],
              'itemImage': element['thumbnail'],
            });
          });

          getLauncher.onResult(
            info['appName'],
            info['appIcon'],
            info['launcherName'],
            info['launcherThumbnail'],
            totalItemCount,
            itemsInThisPage,
            (info['itemsPerPage']),
            items,
          );
        } else {
          getLauncher.onEmpty(
            info['appName'],
            info['appIcon'],
            info['launcherName'],
            info['launcherThumbnail'],
          );
        }
        getLauncher.onLoadfinished();
      } else {
        getLauncher.onError('HTTP ${response.statusCode}');
        getLauncher.onLoadfinished();
      }
    } catch (e) {
      getLauncher.onError(e.toString());
      getLauncher.onLoadfinished();
    }
  }

  Future<void> getPage(String pageTitle, GetPage getPage) async {
    getPage.onLoading();

    final url = Uri.parse(
        'https://api.plentrasphere.com/v2/client/?class=default&action=getPage&appKey=$appKey&pageTitle=$pageTitle');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        final code = jsonData['response']['code'];
        final status = jsonData['response']['status'];

        if (code == 401) {
          getPage.onError(status);
          getPage.onLoadfinished();
          return;
        } else if (code == 404) {
          getPage.onNotFound();
          getPage.onLoadfinished();
          return;
        } else if (code == 400) {
          if (status == "app-expired") {
            getPage.onAppNotActive(jsonData['info']['appName']);
            getPage.onLoadfinished();
            return;
          }

          getPage.onError(status);
          getPage.onLoadfinished();
          return;
        } else if (code == 406) {
          getPage.onError(status);
          return;
        }

        if (status == "under-construction") {
          getPage.onUnderConstruction();
          getPage.onLoadfinished();
          return;
        }

        final info = jsonData['info'];

        if (info['appLocation']['status']) {
          final location = info['appLocation'];
          getPage.onAppLocation(
            location['location'],
            (location['lat']),
            (location['lon']),
          );
        }

        if (jsonData['announcement']['status']) {
          final announcement = jsonData['announcement'];
          getPage.onAnnouncement(announcement['announcementBody']);
        }

        if (info['homeCover']['status']) {
          getPage.onHomeCover(info['homeCover']['image']);
        }

        getPage.onResult(
          info['appName'],
          info['appIcon'],
          jsonData['pageTitle'],
          utf8.decode(base64.decode(jsonData['pageBody'])),
        );
        getPage.onLoadfinished();
      } else {
        getPage.onError('HTTP ${response.statusCode}');
        getPage.onLoadfinished();
      }
    } catch (e) {
      getPage.onError(e.toString());
      getPage.onLoadfinished();
    }
  }

  Future<void> getHomeLoadMore(
      int homePageNumber, GetHomeLoadMore getHomeLoadMore) async {
    getHomeLoadMore.onLoading();

    final url = Uri.parse(
        'https://api.plentrasphere.com/v2/client/?class=default&action=getHome&appKey=$appKey&page=$homePageNumber');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        final code = jsonData['response']['code'];
        final status = jsonData['response']['status'];

        if (code == 401) {
          getHomeLoadMore.onError(status);
          getHomeLoadMore.onLoadfinished();
          return;
        } else if (code == 404) {
          getHomeLoadMore.onNotFound();
          getHomeLoadMore.onLoadfinished();
          return;
        } else if (code == 400) {
          if (status == "app-expired") {
            getHomeLoadMore.onAppNotActive(jsonData['info']['appName']);
            getHomeLoadMore.onLoadfinished();
            return;
          }

          getHomeLoadMore.onError(status);
          getHomeLoadMore.onLoadfinished();
          return;
        } else if (code == 406) {
          getHomeLoadMore.onError(status);
          return;
        }

        if (status == "under-construction") {
          getHomeLoadMore.onUnderConstruction();
          getHomeLoadMore.onLoadfinished();
          return;
        }

        final info = jsonData['info'];

        final itemsInThisPage = (info['itemsInThisPage']);
        final totalItemCount = (info['totalItemCount']);

        if (info['nextPage']['status']) {
          getHomeLoadMore.onNextPage(info['nextPage']['page']);
        } else {
          getHomeLoadMore.onNoNextPage();
        }

        if (itemsInThisPage != 0) {
          final List<dynamic> _items = jsonData['items'];
          final List<dynamic> items = [];

          _items.forEach((element) {
            items.add({
              'itemName': element['itemName'],
              'actionType': element['actionType'],
              'action': element['action'],
              'itemImage': element['thumbnail'],
            });
          });

          getHomeLoadMore.onResult(
            totalItemCount,
            itemsInThisPage,
            info['itemsPerPage'],
            items,
          );
        } else {
          getHomeLoadMore.onEmpty(info['appName'], info['appIcon']);
        }
        getHomeLoadMore.onLoadfinished();
      } else {
        getHomeLoadMore.onError('HTTP ${response.statusCode}');
        getHomeLoadMore.onLoadfinished();
      }
    } catch (e) {
      getHomeLoadMore.onError(e.toString());
      getHomeLoadMore.onLoadfinished();
    }
  }

  Future<void> getHome(GetHome getHome) async {
    getHome.onLoading();

    final url = Uri.parse(
        'https://api.plentrasphere.com/v2/client/?class=default&action=getHome&appKey=$appKey&page=1');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        final code = jsonData['response']['code'];
        final status = jsonData['response']['status'];

        if (code == 401) {
          getHome.onError(status);
          getHome.onLoadfinished();
          return;
        } else if (code == 404) {
          getHome.onNotFound();
          getHome.onLoadfinished();
          return;
        } else if (code == 400) {
          if (status == "app-expired") {
            getHome.onAppNotActive(jsonData['info']['appName']);
            getHome.onLoadfinished();
            return;
          }

          getHome.onError(status);
          getHome.onLoadfinished();
          return;
        } else if (code == 406) {
          getHome.onError(status);
          return;
        }

        if (status == "under-construction") {
          getHome.onUnderConstruction();
          getHome.onLoadfinished();
          return;
        }

        final info = jsonData['info'];

        if (info['appLocation']['status']) {
          final location = info['appLocation'];
          getHome.onAppLocation(
            location['location'],
            (location['lat']),
            (location['lon']),
          );
        }

        if (info['footer']['status']) {
          getHome.onFooter(info['footer']['text'], info['footer']['pageLinks']);
        }

        final itemsInThisPage = (info['itemsInThisPage']);
        final totalItemCount = (info['totalItemCount']);

        if (jsonData['popup']['status']) {
          final popup = jsonData['popup'];
          getHome.onPopup(popup['popupTitle'], popup['popupMessage']);
        }

        if (jsonData['message']['status']) {
          final message = jsonData['message'];
          getHome.onMessage(message['messageTitle'], message['messageBody']);
        }

        if (jsonData['announcement']['status']) {
          final announcement = jsonData['announcement'];
          getHome.onAnnouncement(announcement['announcementBody']);
        }

        if (info['homeCover']['status']) {
          getHome.onHomeCover(info['homeCover']['image']);
        }

        if (info['homeScreen']['itemRail']['status']) {
          getHome.onItemRail(info['homeScreen']['itemRail']['categories']);
        }

        if (info['nextPage']['status']) {
          getHome.onNextPage(info['nextPage']['page']);
        } else {
          getHome.onNoNextPage();
        }

        if (itemsInThisPage != 0) {
          final List<dynamic> _items = jsonData['items'];
          final List<dynamic> items = [];

          _items.forEach((element) {
            items.add({
              'itemName': element['itemName'],
              'actionType': element['actionType'],
              'action': element['action'],
              'itemImage': element['thumbnail'],
            });
          });

          getHome.onResult(
            info['appName'],
            info['appIcon'],
            totalItemCount,
            itemsInThisPage,
            info['itemsPerPage'],
            items,
          );
        } else {
          getHome.onEmpty(info['appName'], info['appIcon']);
        }

        getHome.onLoadfinished();
      } else {
        getHome.onError('HTTP ${response.statusCode}');
        getHome.onLoadfinished();
      }
    } catch (e) {
      getHome.onError(e.toString());
      getHome.onLoadfinished();
    }
  }
}
