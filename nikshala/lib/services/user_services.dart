import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nikshala/config/config.dart';
import 'package:nikshala/screens/components/dialogs.dart';
import 'package:nikshala/screens/components/forgot_password/forgot_password_dialog.dart';
import 'package:nikshala/screens/components/navigation_bar/navigation_bar.dart';
import 'package:provider/provider.dart';
import 'package:nikshala/providers/user_authentication_provider/user_authentication_provider.dart';

class UserServices {
  //email regex
  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(p);
    return regExp.hasMatch(em);
  }

  //password regex
  bool passwordValidation(String value) {
    String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  //user login function
  Future<void> userLogin(final GlobalKey<ScaffoldState> _scaffoldKey,
      BuildContext context, String userEmail, String password) async {
    try {
      if (userEmail.isEmpty) {
        Dialogs.alert(
            context, AppConfig.errorColor, 'Email-id should not be blank');
        return;
      }
      if (!isEmail(userEmail.trim())) {
        Dialogs.alert(
            context, AppConfig.errorColor, 'Please enter valid Email-id');
        return;
      }
      if (password.isEmpty) {
        Dialogs.alert(
            context, AppConfig.errorColor, 'Password can not be blank');
        return;
      }

      await Provider.of<AuthData>(context, listen: false)
          .login(userEmail, password);
      await Navigator.pushNamedAndRemoveUntil(
          context, NavigationBar.routeName, (_) => false);
    } catch (e) {
      Dialogs.alert(context, AppConfig.errorColor, e.toString());
    }
  }

  //user signup function
  Future<void> userSignup(
      final GlobalKey<ScaffoldState> _scaffoldKey,
      BuildContext context,
      String firstName,
      String lastName,
      String mobileNumber,
      String email,
      String password) async {
    try {
      if (firstName.isEmpty) {
        Dialogs.alert(
            context, AppConfig.errorColor, 'First name can not be blank');
        return;
      }
      if (lastName.isEmpty) {
        Dialogs.alert(
            context, AppConfig.errorColor, 'Last name can not be blank');
        return;
      }
      if (mobileNumber.trim().length > 0) {
        if (mobileNumber.trim().length < 10 ||
            mobileNumber.trim().length > 10) {
          Dialogs.alert(context, AppConfig.errorColor,
              'Mobile number should be 10 digits');
          return;
        }
      }
      if (!isEmail(email.trim())) {
        Dialogs.alert(
            context, AppConfig.errorColor, 'Please enter valid Email-id');
        return;
      }
      if (!passwordValidation(password.trim())) {
        Dialogs.alert(context, AppConfig.errorColor,
            'Password must be at least 8 digits and it should have 1 uppercase,1 lowercase,1 number and 1 special character.');
        return;
      }
      await Provider.of<AuthData>(context, listen: false)
          .signup(context, firstName, lastName, email, mobileNumber, password);
    } catch (e) {
      Dialogs.alert(context, AppConfig.errorColor, e.toString());
    }
  }

  //change password function
  Future<void> changePassword(
    final GlobalKey<ScaffoldState> _scaffoldKey,
    BuildContext context,
    String oldPassword,
    String newPassword,
    String confirmPassword,
  ) async {
    try {
      if (newPassword.trim().isEmpty) {
        Dialogs.alert(
            context, AppConfig.errorColor, 'New password should not be blank');
        return;
      }
      if (!passwordValidation(newPassword.trim())) {
        Dialogs.alert(context, AppConfig.errorColor,
            'Password must be at least 8 digits and it should have 1 uppercase,1 lowercase,1 number and 1 special character.');
        return;
      }
      if (confirmPassword.trim().isEmpty) {
        Dialogs.alert(context, AppConfig.errorColor,
            'Confirm password should not be blank');
        return;
      }
      if (confirmPassword.trim() != newPassword.trim()) {
        Dialogs.alert(context, AppConfig.errorColor,
            'Confirm password should be same as New password');
        return;
      }
      await Provider.of<AuthData>(context, listen: false)
          .changePassword(context, oldPassword, newPassword, confirmPassword);
    } catch (e) {
      Dialogs.alert(context, AppConfig.errorColor, e.toString());
    }
  }

  //reset password function
  Future<void> resetPassword(
    BuildContext context,
    String newPassword,
    String confirmPassword,
  ) async {
    try {
      if (newPassword.trim().isEmpty) {
        Dialogs.alert(
            context, AppConfig.errorColor, 'New password should not be blank');
        return;
      }
      if (!passwordValidation(newPassword.trim())) {
        Dialogs.alert(context, AppConfig.errorColor,
            'Password must be at least 8 digits and it should have 1 uppercase,1 lowercase,1 number and 1 special character.');
        return;
      }
      if (confirmPassword.trim().isEmpty) {
        Dialogs.alert(context, AppConfig.errorColor,
            'Confirm password should not be blank');
        return;
      }
      if (confirmPassword.trim() != newPassword.trim()) {
        Dialogs.alert(context, AppConfig.errorColor,
            'Confirm password should be same as New password');
        return;
      }
      await Provider.of<AuthData>(context, listen: false)
          .resetPassword(context, newPassword, confirmPassword);
    } catch (e) {
      Dialogs.alert(context, AppConfig.errorColor, e.toString());
    }
  }

  //forgot password function
  Future<void> forgotPassword(final GlobalKey<ScaffoldState> _scaffoldKey,
      BuildContext context, String email) async {
    try {
      if (email.trim().isEmpty) {
        Dialogs.alert(
            context, AppConfig.errorColor, 'E-mail should not be blank');
        return;
      }
      if (!isEmail(email.trim())) {
        Dialogs.alert(
            context, AppConfig.errorColor, 'Please enter valid Email-id');
        return;
      }
      await Provider.of<AuthData>(context, listen: false)
          .forgotPassword(context, email);
    } catch (e) {
      Dialogs.alert(context, AppConfig.errorColor, e.toString());
    }
  }

  //verify otp function
  Future<void> verifyOtp(BuildContext context, String otp) async {
    try {
      await Provider.of<AuthData>(context, listen: false)
          .verifyOtp(context, otp);
    } catch (e) {
      await Dialogs.alert(context, AppConfig.errorColor, e.toString());
      Navigator.pop(context);
      ForgotPasswordDialog.showForgotPasswordOtpDialog(context);
    }
  }

  //update user profile function
  Future<void> updateUserProfile(
      final GlobalKey<ScaffoldState> _scaffoldKey,
      BuildContext context,
      String firstname,
      String lastname,
      String mobile,
      String country) async {
    try {
      if (firstname.trim().isEmpty) {
        Dialogs.alert(
            context, AppConfig.errorColor, 'First name should not be blank');
        return;
      }
      if (lastname.trim().isEmpty) {
        Dialogs.alert(
            context, AppConfig.errorColor, 'Last name can not be blank');
        return;
      }
      if (mobile.trim().length > 0) {
        if (mobile.trim().length < 10 || mobile.trim().length > 10) {
          Dialogs.alert(context, AppConfig.errorColor,
              'Mobile number should be 10 digits');
          return;
        }
      }
      await Provider.of<AuthData>(context, listen: false)
          .updateProfile(context, firstname, lastname, mobile, country);
    } catch (e) {
      Dialogs.alert(context, AppConfig.errorColor, e.toString());
    }
  }
}
