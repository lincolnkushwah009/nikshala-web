import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:nikshala/config/config.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nikshala/screens/components/dialogs.dart';
import 'package:nikshala/screens/components/navigation_bar/navigation_bar.dart';
import 'package:nikshala/screens/views/my_cart/my_cart_checkout.dart';
import 'package:nikshala/screens/views/payment_gateway/payment_successful.dart';

class AddCart with ChangeNotifier {
  // Create storage
  final storage = new FlutterSecureStorage();

  final Map<String, String> _headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  //add items in cart api
  Future<dynamic> addItemsCart(BuildContext context, String fileId,
      String priceId, bool isBookMark, bool isSearch) async {
    try {
      final isAuth = await storage.read(key: 'token');
      _headers['Authorization'] = 'Bearer $isAuth';
      final data = {'videoOrfolderId': fileId, 'monthlyPriceId': priceId};

      var response = await http.post('${AppConfig.apiUrl}/carts/add-item',
          headers: _headers, body: convert.jsonEncode(data));
      final resData = convert.jsonDecode(response.body);
      print(resData);
      if (response.statusCode == 422) {
        await Dialogs.confirmation(
            context, AppConfig.errorColor, resData['message'], priceId, fileId);
        return;
      }
      if (response.statusCode == 200) {
        await Dialogs.alert(
            context, AppConfig.successColor, resData['message']);
        // if (isBookMark) {
        //   return;
        // }
        if (!isSearch) {
          await Navigator.push(
              context, MaterialPageRoute(builder: (_) => MyCartCheckout()));
        } else {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (_) => NavigationBar(2, null)));
        }
      }
      if (response.statusCode > 200) {
        throw (resData['message']);
      }
      notifyListeners();
      return resData;
    } catch (e) {
      rethrow;
    }
  }

  //get all items in cart
  Future<dynamic> getItemsInCart() async {
    try {
      final isAuth = await storage.read(key: 'token');
      _headers['Authorization'] = 'Bearer $isAuth';
      final response =
          await http.get('${AppConfig.apiUrl}/carts/items', headers: _headers);

      final resData = convert.jsonDecode(response.body);

      if (response.statusCode >= 400) {
        throw (resData['message']);
      }
      return resData['data'] as dynamic;
    } catch (e) {
      rethrow;
    }
  }

  //delete items from cart api
  Future<dynamic> deleteItemsCart(BuildContext context, String fileId) async {
    try {
      final isAuth = await storage.read(key: 'token');
      _headers['Authorization'] = 'Bearer $isAuth';
      final data = {'videoOrfolderId': fileId};

      var response = await http.post('${AppConfig.apiUrl}/carts/remove-item',
          headers: _headers, body: convert.jsonEncode(data));
      final resData = convert.jsonDecode(response.body);

      if (response.statusCode == 200) {
        await Dialogs.alert(
            context, AppConfig.successColor, resData['message']);
        await Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => MyCartCheckout()));
      }
      if (response.statusCode > 200) {
        throw (resData['message']);
      }
      notifyListeners();
      return resData;
    } catch (e) {
      rethrow;
    }
  }

  //place order api
  Future<dynamic> placeOrder(
    BuildContext context,
  ) async {
    try {
      final isAuth = await storage.read(key: 'token');
      _headers['Authorization'] = 'Bearer $isAuth';
      final data = AppConfig.isApplePay
          ? {
              "orderId": AppConfig.orderId,
              'rpay_orderId': 'appleOrderId',
              "rpay_paymentId": false,
              "rpay_signature": false,
              "paymentStatus": 'SUCCESS',
              "reasonMessage": AppConfig.appleDetail,
            }
          : {
              "orderId": AppConfig.orderId,
              'rpay_orderId': 'zeroOrderId',
              "rpay_paymentId": false,
              "rpay_signature": false,
              "paymentStatus": 'SUCCESS',
              "reasonMessage": 'Free Video'
            };

      var response = await http.post('${AppConfig.apiUrl}/orders/place-order',
          headers: _headers, body: convert.jsonEncode(data));
      final resData = convert.jsonDecode(response.body);
      print(":::lolo:::$resData");
      if (response.statusCode == 200) {
        await Dialogs.alert(
            context, AppConfig.successColor, resData['message']);
        await Navigator.push(
            context, MaterialPageRoute(builder: (_) => PaymentSuccessFul()));
      }
      if (response.statusCode > 200) {
        throw (resData['message']);
      }
      notifyListeners();
      return resData;
    } catch (e) {
      rethrow;
    }
  }

  //get all place orders
  Future<List<dynamic>> getAllPlaceOrders() async {
    try {
      final isAuth = await storage.read(key: 'token');
      _headers['Authorization'] = 'Bearer $isAuth';
      final response =
          await http.get('${AppConfig.apiUrl}/orders/items', headers: _headers);

      final resData = convert.jsonDecode(response.body);

      if (response.statusCode >= 400) {
        throw (resData['message']);
      }
      return resData['data'] as List<dynamic>;
    } catch (e) {
      rethrow;
    }
  }

  //get purchased video details by video id
  Future<dynamic> getPurchasedVideoDetailById(String videoId) async {
    try {
      final isAuth = await storage.read(key: 'token');
      _headers['Authorization'] = 'Bearer $isAuth';
      final response = await http.get(
          '${AppConfig.apiUrl}/videos/purchase-info/$videoId',
          headers: _headers);

      final resData = convert.jsonDecode(response.body);

      if (response.statusCode >= 400) {
        throw (resData['message']);
      }
      return resData['data'] as dynamic;
    } catch (e) {
      rethrow;
    }
  }

  //delete and add folder in cart api
  Future<dynamic> deleteAndAddFolder(
      BuildContext context, String fileId, String priceId) async {
    try {
      final isAuth = await storage.read(key: 'token');
      _headers['Authorization'] = 'Bearer $isAuth';
      final data = {'videoOrfolderId': fileId, 'monthlyPriceId': priceId};

      var response = await http.post(
          '${AppConfig.apiUrl}/carts/remove-conflict-items-and-add-new',
          headers: _headers,
          body: convert.jsonEncode(data));
      final resData = convert.jsonDecode(response.body);

      if (response.statusCode == 200) {
        await Dialogs.alert(
            context, AppConfig.successColor, resData['message']);

        await Navigator.push(
            context, MaterialPageRoute(builder: (_) => MyCartCheckout()));
      }
      if (response.statusCode > 200) {
        throw (resData['message']);
      }
      notifyListeners();
      return resData;
    } catch (e) {
      rethrow;
    }
  }

  //generate order id place order
  Future<dynamic> generateOrderId(BuildContext context, int amount) async {
    try {
      final isAuth = await storage.read(key: 'token');
      _headers['Authorization'] = 'Bearer $isAuth';
      final data = {
        'amount': amount,
      };

      var response = await http.post(
          '${AppConfig.apiUrl}/orders/create-rpay-order',
          headers: _headers,
          body: convert.jsonEncode(data));
      final resData = convert.jsonDecode(response.body);
      print('hello$resData');

      if (response.statusCode > 200) {
        throw (resData['message']);
      }

      AppConfig.orderId = resData['data']['id'];
      AppConfig.newOrderId = resData['data']['newOrderId'];
      print(AppConfig.orderId);
      notifyListeners();
      return resData;
    } catch (e) {
      rethrow;
    }
  }

  //send order details
  Future<dynamic> sendOrderDetails(
      BuildContext context,
      String orderId,
      String rpayorderId,
      String paymentId,
      String signature,
      String paymentStatus,
      String reason) async {
    try {
      final isAuth = await storage.read(key: 'token');
      _headers['Authorization'] = 'Bearer $isAuth';
      final data = {
        "orderId": orderId,
        'rpay_orderId': rpayorderId,
        "rpay_paymentId": paymentId,
        "rpay_signature": signature,
        "paymentStatus": paymentStatus,
        "reasonMessage": reason
      };

      var response = await http.post('${AppConfig.apiUrl}/orders/place-order',
          headers: _headers, body: convert.jsonEncode(data));
      final resData = convert.jsonDecode(response.body);
      print("orderrrrrrrrrrr");
      print(resData);
      notifyListeners();
      return resData;
    } catch (e) {
      rethrow;
    }
  }
}
