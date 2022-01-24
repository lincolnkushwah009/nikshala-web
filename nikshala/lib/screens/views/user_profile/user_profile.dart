import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nikshala/config/config.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:nikshala/screens/components/navigation_bar/navigation_bar.dart';
import 'package:nikshala/services/user_services.dart';
import 'package:flutter/services.dart';

class UserProfile extends StatefulWidget {
  // rotue name
  static const routeName = 'user-profile';
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final storage = new FlutterSecureStorage();
  UserServices userServices = UserServices();

  final Map<String, String> _headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };
  TextEditingController userfirstnameController = new TextEditingController();
  TextEditingController userlastnameController = new TextEditingController();
  TextEditingController userpasswordController = new TextEditingController();
  TextEditingController useremailController = new TextEditingController();
  TextEditingController usermobileController = new TextEditingController();
  TextEditingController usercountryController = new TextEditingController();

  @override
  void initState() {
    getUserProfile();
    super.initState();
  }

  //get user profile function
  Future<dynamic> getUserProfile() async {
    try {
      final isAuth = await storage.read(key: 'token');
      _headers['Authorization'] = 'Bearer $isAuth';
      final uri = '${AppConfig.apiUrl}/users/me';
      final response = await http.get(uri, headers: _headers);
      final resData = convert.jsonDecode(response.body);
      userfirstnameController.text = resData['data']['firstName'];
      userlastnameController.text = resData['data']['lastName'];
      useremailController.text = resData['data']['email'];
      usermobileController.text = resData['data']['mobileNumber'];
      usercountryController.text = resData['data']['country'];

      return resData['data'];
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> _willPopCallback() async {
    return Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => NavigationBar(0, null),
        ),
        (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: AppConfig.dashboardTopColor,
          body: SingleChildScrollView(
            child: Container(
                color: AppConfig.dashboardTopColor,
                height: mq.size.height,
                width: double.infinity,
                child: Column(children: <Widget>[
                  //custom app bar
                  Container(
                    height: mq.size.height * 0.2,
                    decoration: BoxDecoration(
                      color: AppConfig.dashboardBottomColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(
                          20,
                        ),
                        bottomRight: Radius.circular(
                          20,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(30, 40, 0, 20),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => NavigationBar(0, null),
                                      ),
                                      (_) => false);
                                },
                                child: Icon(Icons.keyboard_backspace_sharp,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                width: mq.size.width / 3.7,
                              ),
                              Center(
                                child: Text(
                                  'Settings',
                                  style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                    child: Row(
                      children: [
                        Text('Account',
                            style: GoogleFonts.poppins(
                                fontSize: 18, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),

                  //user first name textfield
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: TextFormField(
                      controller: userfirstnameController,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                              child: Image.asset(
                            'assets/edit_icon.png',
                          )),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(0)),
                              borderSide: BorderSide(color: Colors.grey[200])),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'First Name',
                          hintStyle: GoogleFonts.poppins(fontSize: 14)),
                    ),
                  ),

                  //user last name textfield
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: TextFormField(
                      controller: userlastnameController,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                              child: Image.asset(
                            'assets/edit_icon.png',
                          )),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(0)),
                              borderSide: BorderSide(color: Colors.grey[200])),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Last Name',
                          hintStyle: GoogleFonts.poppins(fontSize: 14)),
                    ),
                  ),

                  //e-mail textfield
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: TextFormField(
                      enabled: false,
                      controller: useremailController,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(0)),
                              borderSide: BorderSide(color: Colors.grey[200])),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'E-mail',
                          hintStyle: GoogleFonts.poppins(fontSize: 14)),
                    ),
                  ),

                  //mobile number textfield
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: TextFormField(
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      controller: usermobileController,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          counterText: '',
                          suffixIcon: GestureDetector(
                              child: Image.asset(
                            'assets/edit_icon.png',
                          )),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(0)),
                              borderSide: BorderSide(color: Colors.grey[200])),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Mobile No',
                          hintStyle: GoogleFonts.poppins(fontSize: 14)),
                    ),
                  ),

                  //country textfield
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: TextFormField(
                      controller: usercountryController,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                              child: Image.asset(
                            'assets/edit_icon.png',
                          )),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(0)),
                              borderSide: BorderSide(color: Colors.grey[200])),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Country',
                          hintStyle: GoogleFonts.poppins(fontSize: 14)),
                    ),
                  ),

                  //save button to update profile
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: 200,
                          child: FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              )),
                              child: Text(
                                'Save Changes',
                                style: GoogleFonts.poppins(fontSize: 14),
                              ),
                              textColor: Colors.white,
                              padding: EdgeInsets.all(16),
                              onPressed: () async {
                                //calling update user profile function
                                await userServices.updateUserProfile(
                                    _scaffoldKey,
                                    context,
                                    userfirstnameController.text,
                                    userlastnameController.text,
                                    usermobileController.text,
                                    usercountryController.text);
                              },
                              color: AppConfig.dashboardBottomColor),
                        ),
                      ),
                    ),
                  ),
                ])),
          )),
    );
  }
}
