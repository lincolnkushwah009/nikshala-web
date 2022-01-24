import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:nikshala/config/config.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nikshala/models/categoryModel.dart';

class Categories with ChangeNotifier {
  // Create storage
  final storage = new FlutterSecureStorage();

  final Map<String, String> _headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  //get all categories api
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final isAuth = await storage.read(key: 'token');
      _headers['Authorization'] = 'Bearer $isAuth';
      final response = await http.get(
          '${AppConfig.apiUrl}/categories?isActive=true',
          headers: _headers);

      final resData = convert.jsonDecode(response.body);

      if (response.statusCode >= 400) {
        throw (resData['message']);
      }
      var result = resData['data'];
      return result
          .cast<Map<String, dynamic>>()
          .map<CategoryModel>((e) => CategoryModel.fromJson(e))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  //get all categories and folders
  Future<List<dynamic>> getAllCategoriesWithFolders(String text) async {
    try {
      final isAuth = await storage.read(key: 'token');
      _headers['Authorization'] = 'Bearer $isAuth';
      final response = await http.get(
          '${AppConfig.apiUrl}/folders/all/categories?textSearch=$text',
          headers: _headers);

      final resData = convert.jsonDecode(response.body);

      if (response.statusCode >= 400) {
        throw (resData['message']);
      }
      return resData['data'] as List<dynamic>;
    } catch (e) {
      rethrow;
    }
  }
}
