import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nikshala/config/config.dart';
import 'package:nikshala/screens/components/forgot_password/forgot_password_dialog.dart';
import 'package:nikshala/screens/views/user_signup/user_signup.dart';
import 'package:nikshala/services/network_service.dart';
import 'package:nikshala/services/user_services.dart';

class UserLogin extends StatefulWidget {
  // rotue name
  static const routeName = 'user-login';
  @override
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  TextEditingController useremailController = new TextEditingController();
  TextEditingController userpasswordController = new TextEditingController();
  String otp = '';
  UserServices userServices = UserServices();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _obscureTextLogin = true;
  void _toggleLogin() {
    setState(() {
      _obscureTextLogin = !_obscureTextLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppConfig.dashboardTopColor,
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppConfig.dashboardBottomColor,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(32, 50, 32, 0),
                  child: Column(
                    children: [
                      Center(
                        child: Image.asset(
                          AppConfig.appLogo,
                          scale: 2,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(32, 50, 32, 0),
                        child: Center(
                            child: Text(
                          'Login',
                          style: GoogleFonts.poppins(
                              fontSize: 28,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        )),
                      ),

                      //email textfield
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: TextFormField(
                          controller: useremailController,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  borderSide:
                                      BorderSide(color: Colors.grey[200])),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  borderSide:
                                      BorderSide(color: Colors.blue[100])),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'E-mail',
                              hintStyle: GoogleFonts.poppins(fontSize: 14)),
                        ),
                      ),

                      //password textfield
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: TextFormField(
                          obscureText: _obscureTextLogin,
                          controller: userpasswordController,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              suffixIcon: _obscureTextLogin
                                  ? GestureDetector(
                                      onTap: _toggleLogin,
                                      child: Icon(
                                        Icons.visibility_off,
                                        size: 18.0,
                                        color: Colors.blue[800],
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: _toggleLogin,
                                      child: Icon(
                                        Icons.visibility,
                                        size: 18.0,
                                        color: Colors.blue[800],
                                      ),
                                    ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  borderSide:
                                      BorderSide(color: Colors.grey[200])),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  borderSide:
                                      BorderSide(color: Colors.blue[100])),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Password',
                              hintStyle: GoogleFonts.poppins(fontSize: 14)),
                        ),
                      ),

                      //forgot password link
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                ForgotPasswordDialog.showForgotPasswordDialog(
                                    context, useremailController, _scaffoldKey);
                              },
                              child: Text('Forgot Password',
                                  style: GoogleFonts.poppins(
                                      decoration: TextDecoration.underline,
                                      fontSize: 10,
                                      color: Color.fromRGBO(248, 248, 248, 1))),
                            ),
                          ],
                        ),
                      ),

                      //login button
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 40),
                        child: Container(
                          width: 200,
                          child: FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              )),
                              child: Text(
                                'CONTINUE',
                                style: GoogleFonts.poppins(fontSize: 14),
                              ),
                              textColor: Colors.black,
                              padding: EdgeInsets.all(16),
                              onPressed: () async {
                                var network =
                                    // await checkInternetWorking(context);

                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                // if (network == 'connected') {
                                await userServices.userLogin(
                                    _scaffoldKey,
                                    context,
                                    useremailController.text,
                                    userpasswordController.text);
                                // }
                              },
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              //signup link
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 50, 32, 0),
                child: Container(
                  color: AppConfig.dashboardTopColor,
                  child: Center(
                      child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, UserSignup.routeName);
                    },
                    child: Text('CREATE ACCOUNT',
                        style: GoogleFonts.poppins(
                            decoration: TextDecoration.underline,
                            fontSize: 16,
                            color: Colors.black)),
                  )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
