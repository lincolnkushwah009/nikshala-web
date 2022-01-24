import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:nikshala/config/config.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nikshala/models/priceModel.dart';
import 'package:nikshala/screens/components/dialogs.dart';

class Video with ChangeNotifier {
  // Create storage
  final storage = new FlutterSecureStorage();

  final Map<String, String> _headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };
  var pricelist = [];
  //get video details by video id
  Future<dynamic> getVideoDetailById(String videoId) async {
    try {
      final isAuth = await storage.read(key: 'token');
      _headers['Authorization'] = 'Bearer $isAuth';
      final response = await http.get('${AppConfig.apiUrl}/videos/$videoId',
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

//get price details by folder/video id
  Future<List<PriceModel>> getPriceDetailsByFileId(String fileId) async {
    try {
      final isAuth = await storage.read(key: 'token');
      _headers['Authorization'] = 'Bearer $isAuth';
      final response = await http.get(
          '${AppConfig.apiUrl}/prices/monthly-prices/$fileId',
          headers: _headers);

      final resData = convert.jsonDecode(response.body);
      pricelist = resData['data'];
      if (response.statusCode >= 400) {
        throw (resData['message']);
      }
      var result = resData['data'];
      return result
          .cast<Map<String, dynamic>>()
          .map<PriceModel>((e) => PriceModel.fromJson(e))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  //get all videos on search with filters
  Future<List<dynamic>> getAllVideosOnSearch(
      String text, List filterData) async {
    try {
      final isAuth = await storage.read(key: 'token');
      _headers['Authorization'] = 'Bearer $isAuth';
      final data = {'text': text, "values": filterData};

      var response = await http.post('${AppConfig.apiUrl}/videos/search',
          headers: _headers, body: convert.jsonEncode(data));
      final resData = convert.jsonDecode(response.body);
      print("apiiiiiiii");
      print(data);
      print(resData);
      if (response.statusCode >= 400) {
        throw (resData['message']);
      }
      return resData['data']['videos'] as List<dynamic>;
    } catch (e) {
      rethrow;
    }
  }

  //add or remove video in bookmark
  Future<dynamic> addRemoveBookmarkVideo(
      BuildContext context, String fileId) async {
    try {
      final isAuth = await storage.read(key: 'token');
      _headers['Authorization'] = 'Bearer $isAuth';
      final data = {'bookMarkItem': fileId};

      var response = await http.post('${AppConfig.apiUrl}/bookmarks',
          headers: _headers, body: convert.jsonEncode(data));
      final resData = convert.jsonDecode(response.body);

      if (response.statusCode == 200) {
        await Dialogs.alert(
            context, AppConfig.successColor, resData['message']);

        // await Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: (_) => MyCartCheckout()));
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

  //get all bookmark videos
  Future<List<dynamic>> getAllBookmarkVideos() async {
    try {
      final isAuth = await storage.read(key: 'token');
      _headers['Authorization'] = 'Bearer $isAuth';
      final response =
          await http.get('${AppConfig.apiUrl}/bookmarks', headers: _headers);

      final resData = convert.jsonDecode(response.body);
      if (response.statusCode >= 400) {
        throw (resData['message']);
      }
      return resData['data'] as List<dynamic>;
    } catch (e) {
      rethrow;
    }
  }

  //generate video url
  Future<dynamic> generateVideoUrl(String videoId) async {
    try {
      final isAuth = await storage.read(key: 'token');
      _headers['Authorization'] = 'Bearer $isAuth';
      final response = await http.get(
          '${AppConfig.apiUrl}/streams/generate-url/$videoId',
          headers: _headers);

      final resData = convert.jsonDecode(response.body);
      print(resData);
      if (response.statusCode >= 400) {
        print(resData);
        throw (resData['message']);
      }
      return resData as dynamic;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
