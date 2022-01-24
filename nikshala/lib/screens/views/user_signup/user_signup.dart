import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nikshala/config/config.dart';
import 'package:nikshala/screens/components/dialogs.dart';
import 'package:nikshala/screens/views/user_login/user_login.dart';
import 'package:nikshala/services/network_service.dart';
import 'package:nikshala/services/user_services.dart';
import 'package:flutter/services.dart';
import 'package:nikshala/screens/views/terms_conditions/terms_conditions.dart';

class UserSignup extends StatefulWidget {
  // rotue name
  static const routeName = 'sign-up';
  @override
  _UserSignupState createState() => _UserSignupState();
}

class _UserSignupState extends State<UserSignup> {
  TextEditingController userfirstnameController = new TextEditingController();
  TextEditingController userlastnameController = new TextEditingController();
  TextEditingController usermobileController = new TextEditingController();
  TextEditingController useremailController = new TextEditingController();
  TextEditingController userpasswordController = new TextEditingController();
  UserServices userServices = UserServices();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isChecked = false;
  String currText = '';
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
                        padding: const EdgeInsets.fromLTRB(20, 25, 20, 0),
                        child: Center(
                            child: Text(
                          'Create an Account',
                          style: GoogleFonts.poppins(
                              fontSize: 28,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        )),
                      ),

                      //username textfield
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: TextFormField(
                          controller: userfirstnameController,
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
                              hintText: 'First name \*',
                              hintStyle: GoogleFonts.poppins(fontSize: 14)),
                        ),
                      ),

                      //user first name textfield
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: TextFormField(
                          controller: userlastnameController,
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
                              hintText: 'Last name \*',
                              hintStyle: GoogleFonts.poppins(fontSize: 14)),
                        ),
                      ),

                      //user mobile number textfield
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: TextFormField(
                          maxLength: 10,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          controller: usermobileController,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              counterText: '',
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
                              hintText: 'Mobile No (Optional)',
                              hintStyle: GoogleFonts.poppins(fontSize: 14)),
                        ),
                      ),

                      //user e-mail textfield
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
                              hintText: 'E-mail \*',
                              hintStyle: GoogleFonts.poppins(fontSize: 14)),
                        ),
                      ),

                      //user password textfield
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
                              hintText: 'Password \*',
                              hintStyle: GoogleFonts.poppins(fontSize: 14)),
                        ),
                      ),

                      //T&C checkbox
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _isChecked = !_isChecked;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white),
                                child: _isChecked
                                    ? Icon(
                                        Icons.check,
                                        size: 22.0,
                                        color: Colors.blue,
                                      )
                                    : Icon(
                                        Icons.check_box_outline_blank,
                                        size: 22.0,
                                        color: Colors.white,
                                      ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => TermsCondition()));
                              },
                              child: Row(
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Agree with',
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            color: Colors.white,
                                          ),
                                        ),
                                        TextSpan(
                                          text: ' Terms & Conditions \*',
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            decoration:
                                                TextDecoration.underline,
                                            color: Colors.white,
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
                      ),

                      //sign up button
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 30),
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
                                if (!_isChecked) {
                                  Dialogs.alert(context, AppConfig.errorColor,
                                      'Please accept Terms & Conditions');

                                  return;
                                }
                                var network =
                                    await checkInternetWorking(context);
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                if (network == 'connected') {
                                  await userServices.userSignup(
                                      _scaffoldKey,
                                      context,
                                      userfirstnameController.text,
                                      userlastnameController.text,
                                      usermobileController.text,
                                      useremailController.text,
                                      userpasswordController.text);
                                }
                              },
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              //login link
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 30, 32, 20),
                child: Container(
                  color: AppConfig.dashboardTopColor,
                  child: Center(
                      child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, UserLogin.routeName);
                    },
                    child: Text('LOGIN',
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
