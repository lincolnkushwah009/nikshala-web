import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nikshala/config/config.dart';
import 'package:nikshala/services/user_services.dart';

class ChangePassword extends StatefulWidget {
  // rotue name
  static const routeName = 'change-password';
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  //user password controller
  TextEditingController userpasswordController = new TextEditingController();
  //user confirm password controller
  TextEditingController userconfirmpasswordController =
      new TextEditingController();
  //user old password controller
  TextEditingController useroldpasswordController = new TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _obscureTextLogin = true;
  bool _obscureTextLogin2 = true;
  bool _obscureTextLogin3 = true;
  UserServices userServices = UserServices();
  void _toggleLogin() {
    setState(() {
      _obscureTextLogin = !_obscureTextLogin;
    });
  }

  void _toggleLogin2() {
    setState(() {
      _obscureTextLogin2 = !_obscureTextLogin2;
    });
  }

  void _toggleLogin3() {
    setState(() {
      _obscureTextLogin3 = !_obscureTextLogin3;
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
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 40),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(Icons.keyboard_backspace_sharp,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: Image.asset(
                          AppConfig.appLogo,
                          scale: 2,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(32, 80, 32, 0),
                        child: Center(
                            child: Text(
                          'Change Password',
                          style: GoogleFonts.poppins(
                              fontSize: 28,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        )),
                      ),

                      //old password textfield
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: TextFormField(
                          obscureText: _obscureTextLogin,
                          controller: useroldpasswordController,
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
                              hintText: 'Old Password',
                              hintStyle: GoogleFonts.poppins(fontSize: 14)),
                        ),
                      ),

                      //password textfield
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: TextFormField(
                          obscureText: _obscureTextLogin2,
                          controller: userpasswordController,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              suffixIcon: _obscureTextLogin2
                                  ? GestureDetector(
                                      onTap: _toggleLogin2,
                                      child: Icon(
                                        Icons.visibility_off,
                                        size: 18.0,
                                        color: Colors.blue[800],
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: _toggleLogin2,
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
                              hintText: 'New Password',
                              hintStyle: GoogleFonts.poppins(fontSize: 14)),
                        ),
                      ),

                      //confirm password textfield
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: TextFormField(
                          obscureText: _obscureTextLogin3,
                          controller: userconfirmpasswordController,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              suffixIcon: _obscureTextLogin3
                                  ? GestureDetector(
                                      onTap: _toggleLogin3,
                                      child: Icon(
                                        Icons.visibility_off,
                                        size: 18.0,
                                        color: Colors.blue[800],
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: _toggleLogin3,
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
                              hintText: 'Confirm Password',
                              hintStyle: GoogleFonts.poppins(fontSize: 14)),
                        ),
                      ),

                      //submit button
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 40, 0, 40),
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
                              textColor: Colors.black,
                              padding: EdgeInsets.all(16),
                              onPressed: () async {
                                await userServices.changePassword(
                                    _scaffoldKey,
                                    context,
                                    useroldpasswordController.text,
                                    userpasswordController.text,
                                    userconfirmpasswordController.text);
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                              },
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
