import 'package:flutter/material.dart';
import 'package:nikshala/config/config.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nikshala/services/user_services.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

UserServices userServices = UserServices();
//new password controller
TextEditingController newPassword = TextEditingController();
//confirm password controller
TextEditingController confirmPassword = TextEditingController();
//otp controller
String otp;
bool _obscureTextLogin = true;
bool _obscureTextLogin2 = true;

class ForgotPasswordDialog {
  //dialog of forgot password
  static void showForgotPasswordDialog(
    context,
    TextEditingController email,
    final GlobalKey<ScaffoldState> _scaffoldKey,
  ) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    // height: 400,
                    decoration: BoxDecoration(
                        color: AppConfig.dashboardTopColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: Wrap(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                          child: Center(
                              child: Text('Forgot Password',
                                  style: GoogleFonts.poppins(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                  ))),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Center(
                              child: Text(
                                  'Enter your email for the verification process. Will send 6 digits to your email.',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                  ))),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: Column(
                            children: [
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 32, right: 32),
                                  child: TextFormField(
                                    controller: email,
                                    style: TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
                                            borderSide: BorderSide(
                                                color: Colors.grey[200])),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
                                            borderSide: BorderSide(
                                                color: Colors.blue[100])),
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: 'E-mail',
                                        hintStyle:
                                            GoogleFonts.poppins(fontSize: 14)),
                                  ),
                                ),
                              ),
                              //login button
                              Center(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 20, 0, 20),
                                  child: Container(
                                    width: 200,
                                    child: FlatButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                          Radius.circular(10.0),
                                        )),
                                        child: Text(
                                          'Continue',
                                          style:
                                              GoogleFonts.poppins(fontSize: 14),
                                        ),
                                        textColor: Colors.white,
                                        padding: EdgeInsets.all(16),
                                        onPressed: () async {
                                          FocusScope.of(context)
                                              .requestFocus(FocusNode());
                                          await userServices.forgotPassword(
                                              _scaffoldKey,
                                              context,
                                              email.text);
                                        },
                                        color: AppConfig.dashboardBottomColor),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          });
        });
  }

  //dialog of forgot password otp
  static void showForgotPasswordOtpDialog(context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    // height: 1000,
                    decoration: BoxDecoration(
                        color: AppConfig.dashboardTopColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: Wrap(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                          child: Center(
                              child: Text('Enter 6 Digits Code',
                                  style: GoogleFonts.poppins(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                  ))),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Center(
                              child: Text(
                                  'Enter the 6 digits code that you received on your email.',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                  ))),
                        ),
                        //otp textfield
                        Padding(
                            padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom,
                            ),
                            child: Center(
                              child: Theme(
                                data: ThemeData(
                                  primaryColor: AppConfig.dashboardBottomColor,
                                ),
                                child: OTPTextField(
                                  length: 6,
                                  width: MediaQuery.of(context).size.width,
                                  fieldWidth: 50,
                                  style: TextStyle(fontSize: 17),
                                  textFieldAlignment:
                                      MainAxisAlignment.spaceAround,
                                  fieldStyle: FieldStyle.box,
                                  onCompleted: (pin) {
                                    otp = pin;
                                  },
                                ),
                              ),
                            )),

                        //login button
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                            child: Container(
                              width: 200,
                              child: FlatButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  )),
                                  child: Text(
                                    'Continue',
                                    style: GoogleFonts.poppins(fontSize: 14),
                                  ),
                                  textColor: Colors.white,
                                  padding: EdgeInsets.all(16),
                                  onPressed: () async {
                                    await userServices.verifyOtp(context, otp);
                                  },
                                  color: AppConfig.dashboardBottomColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          });
        });
  }

  //dialog of reset password
  static void showForgotPasswordResetDialog(
    context,
  ) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    // height: 1000,
                    decoration: BoxDecoration(
                        color: AppConfig.dashboardTopColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: Wrap(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                          child: Center(
                              child: Text('Reset Password',
                                  style: GoogleFonts.poppins(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                  ))),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Center(
                              child: Text(
                                  'Set the new password for your account so you can login and access all the features',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                  ))),
                        ),

                        //password textfield
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(32, 20, 32, 0),
                                child: TextFormField(
                                  obscureText: _obscureTextLogin,
                                  controller: newPassword,
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                      suffixIcon: _obscureTextLogin
                                          ? GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _obscureTextLogin =
                                                      !_obscureTextLogin;
                                                });
                                              },
                                              child: Icon(
                                                Icons.visibility_off,
                                                size: 18.0,
                                                color: Colors.blue[800],
                                              ),
                                            )
                                          : GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _obscureTextLogin =
                                                      !_obscureTextLogin;
                                                });
                                              },
                                              child: Icon(
                                                Icons.visibility,
                                                size: 18.0,
                                                color: Colors.blue[800],
                                              ),
                                            ),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                                          borderSide: BorderSide(
                                              color: Colors.grey[200])),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                                          borderSide: BorderSide(
                                              color: Colors.blue[100])),
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: 'New Password',
                                      hintStyle:
                                          GoogleFonts.poppins(fontSize: 14)),
                                ),
                              ),

                              //confirm password textfield
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(32, 20, 32, 0),
                                child: TextFormField(
                                  obscureText: _obscureTextLogin2,
                                  controller: confirmPassword,
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                      suffixIcon: _obscureTextLogin2
                                          ? GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _obscureTextLogin2 =
                                                      !_obscureTextLogin2;
                                                });
                                              },
                                              child: Icon(
                                                Icons.visibility_off,
                                                size: 18.0,
                                                color: Colors.blue[800],
                                              ),
                                            )
                                          : GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _obscureTextLogin2 =
                                                      !_obscureTextLogin2;
                                                });
                                              },
                                              child: Icon(
                                                Icons.visibility,
                                                size: 18.0,
                                                color: Colors.blue[800],
                                              ),
                                            ),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                                          borderSide: BorderSide(
                                              color: Colors.grey[200])),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                                          borderSide: BorderSide(
                                              color: Colors.blue[100])),
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: 'Confirm Password',
                                      hintStyle:
                                          GoogleFonts.poppins(fontSize: 14)),
                                ),
                              ),
                              //login button
                              Center(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 20, 0, 20),
                                  child: Container(
                                    width: 200,
                                    child: FlatButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                          Radius.circular(10.0),
                                        )),
                                        child: Text(
                                          'Continue',
                                          style:
                                              GoogleFonts.poppins(fontSize: 14),
                                        ),
                                        textColor: Colors.white,
                                        padding: EdgeInsets.all(16),
                                        onPressed: () async {
                                          FocusScope.of(context)
                                              .requestFocus(FocusNode());
                                          await userServices.resetPassword(
                                              context,
                                              newPassword.text,
                                              confirmPassword.text);
                                        },
                                        color: AppConfig.dashboardBottomColor),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          });
        });
  }
}
