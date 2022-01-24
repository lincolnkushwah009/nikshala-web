import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nikshala/config/config.dart';
import 'package:nikshala/providers/cart_provider/cart_provider.dart';
import 'package:nikshala/screens/components/dialogs.dart';
import 'package:provider/provider.dart';

class CartServices {
  //add to cart function
  Future<void> addItemsToCart(BuildContext context, String fileId,
      String priceId, bool isBookMark, bool isSearch) async {
    try {
      await Provider.of<AddCart>(context, listen: false)
          .addItemsCart(context, fileId, priceId, isBookMark, isSearch);
      // Navigator.pop(context);
    } catch (e) {
      print(e);
      await Dialogs.alert(context, AppConfig.errorColor, e.toString());
      if (isSearch) {
        Navigator.pop(context);
      }
    }
  }

  //send order details
  Future<void> sendOrderDetails(
      BuildContext context,
      String orderId,
      String rpayorderId,
      String paymentId,
      String signature,
      String paymentStatus,
      String reason) async {
    try {
      await Provider.of<AddCart>(context, listen: false).sendOrderDetails(
          context,
          orderId,
          rpayorderId,
          paymentId,
          signature,
          paymentStatus,
          reason);

      // Navigator.pop(context);
    } catch (e) {
      await Dialogs.alert(context, AppConfig.errorColor, e.toString());
    }
  }

  //generate order id
  Future<bool> generateOrderId(BuildContext context, int amount) async {
    try {
      await Provider.of<AddCart>(context, listen: false)
          .generateOrderId(context, amount);

      return true;
    } catch (e) {
      print('object:::yo::$e ');
      await Dialogs.alert(context, AppConfig.errorColor, e.toString());
      return false;
    }
  }

  //delete items from cart function
  Future<void> deleteItemsFromCart(
    BuildContext context,
    String fileId,
  ) async {
    try {
      await Provider.of<AddCart>(context, listen: false)
          .deleteItemsCart(context, fileId);
    } catch (e) {
      Dialogs.alert(context, AppConfig.errorColor, e.toString());
    }
  }

  //place order function
  Future<void> placeOrder(
    BuildContext context,
  ) async {
    try {
      await Provider.of<AddCart>(context, listen: false).placeOrder(context);
    } catch (e) {
      print('object:::::: $e');
      Dialogs.alert(context, AppConfig.errorColor, e.toString());
    }
  }

  //delete videos and add folder to cart function
  Future<void> deleteAndAddFolder(
      BuildContext context, String fileId, String priceId) async {
    try {
      await Provider.of<AddCart>(context, listen: false)
          .deleteAndAddFolder(context, fileId, priceId);
      // Navigator.pop(context);
    } catch (e) {
      await Dialogs.alert(context, AppConfig.errorColor, e.toString());
    }
  }
}
