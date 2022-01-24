import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:nikshala/config/config.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FilterProvider with ChangeNotifier {
  // Create storage
  final storage = new FlutterSecureStorage();

  final Map<String, String> _headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  //get all filter list
  Future<dynamic> getFilters() async {
    try {
      final isAuth = await storage.read(key: 'token');
      _headers['Authorization'] = 'Bearer $isAuth';
      final response =
          await http.get('${AppConfig.apiUrl}/filters', headers: _headers);

      final resData = convert.jsonDecode(response.body);

      if (response.statusCode >= 400) {
        throw (resData['message']);
      }
      return resData['data'] as dynamic;
    } catch (e) {
      rethrow;
    }
  }
}
