import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:nikshala/config/config.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nikshala/models/folderModel.dart';

class Folder with ChangeNotifier {
  // Create storage
  final storage = new FlutterSecureStorage();

  final Map<String, String> _headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  //get all folders by category id
  Future<List<FolderModel>> getFoldersByCategoryId(String categoryId) async {
    try {
      final isAuth = await storage.read(key: 'token');
      _headers['Authorization'] = 'Bearer $isAuth';
      final response = await http.get(
          '${AppConfig.apiUrl}/folders/by-category/$categoryId?status=true',
          headers: _headers);

      final resData = convert.jsonDecode(response.body);
      print(resData);
      if (response.statusCode >= 400) {
        throw (resData['message']);
      }
      var result = resData['data'];
      return result
          .cast<Map<String, dynamic>>()
          .map<FolderModel>((e) => FolderModel.fromJson(e))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  //get all subfolder by folder id
  Future<dynamic> getSubFoldersByFolderId(String folderId) async {
    try {
      final isAuth = await storage.read(key: 'token');
      _headers['Authorization'] = 'Bearer $isAuth';
      final response = await http.get(
          '${AppConfig.apiUrl}/folders/$folderId?status=true',
          headers: _headers);

      final resData = convert.jsonDecode(response.body);
      print(response.body);

      if (response.statusCode >= 400) {
        throw (resData['message']);
      }
      return resData['data'] as dynamic;
    } catch (e) {
      rethrow;
    }
  }
}
