import 'package:flutter/material.dart';

class AppConfig {
  static const bool staging = true;
  //api host url
  // static final String apiUrl = 'http://65.1.255.116:3000/api/v1';

  static final String apiUrl = 'http://nikshala.in/api/v1';
  // static final String apiUrl = 'https://c0f4-59-97-107-206.ngrok.io/api/v1';

  static final imageUrl = 'http://nikshala.in';
  //global light blue color
  static final dashboardTopColor = Color.fromRGBO(246, 249, 255, 1);
  //global blue color
  static final dashboardBottomColor = Color.fromRGBO(45, 95, 233, 1);
  //error color in dialog
  static final errorColor = Color.fromRGBO(225, 45, 45, 1);
  //success color in dialog
  static final successColor = Colors.green;
  //global app logo
  static final appLogo = 'assets/logo.png';
  //loader
  static final loader = 'assets/loader.gif';

  static var userName;
  static bool isApplePay = false;
  static var appleDetail;
  static var text;
  static var orderId;
  static var newOrderId;
  static var amount;
  static var videoToken;
  static var userEmail;
  static var phone;
  // static List checkBoxValue = [];
  // static List advancedValue = [];
  // static List checkBoxValues = [];
  // static List advancedValues = [];
  // static var filtervalues;
}
