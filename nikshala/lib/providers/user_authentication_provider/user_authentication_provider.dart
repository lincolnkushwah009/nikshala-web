import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:nikshala/config/config.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nikshala/models/userModel.dart';
import 'package:nikshala/screens/components/dialogs.dart';
import 'package:nikshala/screens/components/forgot_password/forgot_password_dialog.dart';
import 'package:nikshala/screens/components/navigation_bar/navigation_bar.dart';
import 'package:nikshala/screens/views/user_login/user_login.dart';

class AuthData with ChangeNotifier {
  // Create storage
  final storage = new FlutterSecureStorage();
  String userEmail;
  String phone;
  final Map<String, String> _headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  //login api
  Future<dynamic> login(String email, String password) async {
    try {
      final data = {
        'email': email,
        'password': password,
      };
      var response = await http.post('${AppConfig.apiUrl}/auth/login',
          headers: _headers, body: convert.jsonEncode(data));
      final resData = convert.jsonDecode(response.body);

      if (response.statusCode >= 400) {
        throw (resData['message']);
      }
      //saving the token in secure storage
      await storage.write(key: 'token', value: resData['data']['token']);

      notifyListeners();
      return resData;
    } catch (e) {
      rethrow;
    }
  }

  //signup api
  Future<dynamic> signup(
      BuildContext context,
      String firstName,
      String lastName,
      String email,
      String mobileNumber,
      String password) async {
    try {
      final data = {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'mobileNumber': mobileNumber,
        'password': password,
      };

      var response = await http.post('${AppConfig.apiUrl}/auth/signup',
          headers: _headers, body: convert.jsonEncode(data));
      final resData = convert.jsonDecode(response.body);

      if (response.statusCode == 200) {
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (_) => UserLogin(),
              ),
              (_) => false);
        });
        await Dialogs.alert(
            context, AppConfig.successColor, resData['message']);
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

  //reset password api
  Future<dynamic> resetPassword(
      BuildContext context, String newPassword, String confirmPassword) async {
    try {
      final isAuth = await storage.read(key: 'token');

      _headers['Authorization'] = 'Bearer $isAuth';
      final data = {
        'newPassword': newPassword,
        'confirmPassword': confirmPassword,
      };
      var response = await http.post('${AppConfig.apiUrl}/auth/reset-password',
          headers: _headers, body: convert.jsonEncode(data));

      final resData = convert.jsonDecode(response.body);

      if (response.statusCode == 200) {
        await storage.delete(key: 'token');
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (_) => UserLogin(),
              ),
              (_) => false);
        });
        await Dialogs.alert(
            context, AppConfig.successColor, resData['message']);
      }
      if (response.statusCode >= 400) {
        throw (resData['message']);
      }

      notifyListeners();
      return resData;
    } catch (e) {
      rethrow;
    }
  }

  //change password api
  Future<dynamic> changePassword(
    BuildContext context,
    String oldPassword,
    String newPassword,
    String confirmPassword,
  ) async {
    try {
      final isAuth = await storage.read(key: 'token');

      _headers['Authorization'] = 'Bearer $isAuth';
      final data = {
        'oldPassword': oldPassword,
        'newPassword': newPassword,
        'confirmPassword': confirmPassword,
      };
      var response = await http.post('${AppConfig.apiUrl}/auth/change-password',
          headers: _headers, body: convert.jsonEncode(data));

      final resData = convert.jsonDecode(response.body);

      if (response.statusCode == 200) {
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (_) => NavigationBar(0, null),
              ),
              (_) => false);
        });
        await Dialogs.alert(
            context, AppConfig.successColor, resData['message']);
      }
      if (response.statusCode >= 400) {
        throw (resData['message']);
      }

      notifyListeners();
      return resData;
    } catch (e) {
      rethrow;
    }
  }

  //forgot password api
  Future<dynamic> forgotPassword(BuildContext context, String email) async {
    try {
      final data = {'email': email};
      var response = await http.post(
          '${AppConfig.apiUrl}/auth/send-forgot-password-otp',
          headers: _headers,
          body: convert.jsonEncode(data));

      final resData = convert.jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 400) {
        ForgotPasswordDialog.showForgotPasswordOtpDialog(context);

        await Dialogs.alert(
            context, AppConfig.successColor, resData['message']);
      }
      if (response.statusCode > 400) {
        throw (resData['message']);
      }

      notifyListeners();
      return resData;
    } catch (e) {
      rethrow;
    }
  }

  //verify otp api
  Future<dynamic> verifyOtp(BuildContext context, String otp) async {
    try {
      final data = {'otp': otp};
      var response = await http.post(
          '${AppConfig.apiUrl}/auth/reset-password-by-otp',
          headers: _headers,
          body: convert.jsonEncode(data));

      final resData = convert.jsonDecode(response.body);

      if (response.statusCode == 200) {
        //saving the token in secure storage
        await storage.write(key: 'token', value: resData['data']['token']);
        ForgotPasswordDialog.showForgotPasswordResetDialog(context);

        await Dialogs.alert(
            context, AppConfig.successColor, resData['message']);
      }
      if (response.statusCode == 400) {
        throw (resData['message']);
      }
      if (response.statusCode > 400) {
        throw (resData['message']);
      }

      notifyListeners();
      return resData;
    } catch (e) {
      rethrow;
    }
  }

//user profile
  Future<UserModel> getUserProfile() async {
    try {
      final isAuth = await storage.read(key: 'token');
      _headers['Authorization'] = 'Bearer $isAuth';
      final uri = '${AppConfig.apiUrl}/users/me';
      final response = await http.get(uri, headers: _headers);
      final resData = convert.jsonDecode(response.body);
      AppConfig.userEmail = resData['data']['email'];
      AppConfig.phone = resData['data']['mobileNumber'];
      if (response.statusCode == 200) {}
      return UserModel.fromJson(resData['data']);
    } catch (e) {
      rethrow;
    }
  }

  //update user profile
  Future<void> updateProfile(
    BuildContext context,
    String firstname,
    String lastname,
    String mobile,
    String country,
  ) async {
    try {
      final isAuth = await storage.read(key: 'token');
      _headers['Authorization'] = 'Bearer $isAuth';
      final response =
          await http.put('${AppConfig.apiUrl}/users/update-profile',
              headers: _headers,
              body: convert.jsonEncode({
                'firstName': firstname,
                'lastName': lastname,
                'mobileNumber': mobile,
                'country': country
              }));

      final resData = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        await Dialogs.alert(
            context, AppConfig.successColor, resData['message']);
      }
      if (response.statusCode >= 400) {
        throw (resData['message']);
      }
    } catch (e) {
      rethrow;
    }
  }
}
