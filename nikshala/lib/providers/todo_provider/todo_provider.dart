import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:nikshala/config/config.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nikshala/screens/components/dialogs.dart';

class TodoProvider with ChangeNotifier {
  // Create storage
  final storage = new FlutterSecureStorage();

  final Map<String, String> _headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  //get todo list
  Future<dynamic> getTodoList() async {
    try {
      final isAuth = await storage.read(key: 'token');
      _headers['Authorization'] = 'Bearer $isAuth';
      final response =
          await http.get('${AppConfig.apiUrl}/todos/my', headers: _headers);

      final resData = convert.jsonDecode(response.body);

      if (response.statusCode >= 400) {
        throw (resData['message']);
      }
      return resData['data'] as dynamic;
    } catch (e) {
      rethrow;
    }
  }

  //add todo notes api
  Future<dynamic> addTodoNotes(
      BuildContext context, String noteId, String notes) async {
    try {
      final isAuth = await storage.read(key: 'token');
      _headers['Authorization'] = 'Bearer $isAuth';
      final data = {
        'notes': notes,
      };

      var response = await http.put('${AppConfig.apiUrl}/todos/status/$noteId',
          headers: _headers, body: convert.jsonEncode(data));
      final resData = convert.jsonDecode(response.body);

      if (response.statusCode == 200) {
        await Dialogs.alert(
            context, AppConfig.successColor, resData['message']);
        Navigator.pop(context);
        // await Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: (_) => CourseTodoList()));
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

  //get todo detail by id
  Future<dynamic> getTodoDetails(String todoId) async {
    try {
      final isAuth = await storage.read(key: 'token');
      _headers['Authorization'] = 'Bearer $isAuth';
      final response = await http.get(
          '${AppConfig.apiUrl}/todos/users/user-todos/$todoId',
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
}
