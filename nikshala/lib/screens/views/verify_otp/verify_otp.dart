import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nikshala/config/config.dart';
import 'package:nikshala/services/user_services.dart';
import 'package:flutter/services.dart';

class VerifyOtp extends StatefulWidget {
  // rotue name
  static const routeName = 'verify-otp';
  @override
  _VerifyOtpState createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  TextEditingController otpController = new TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  UserServices userServices = UserServices();
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
                  padding: const EdgeInsets.fromLTRB(32, 100, 32, 0),
                  child: Column(
                    children: [
                      Center(
                        child: Image.asset(
                          AppConfig.appLogo,
                          scale: 2,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(32, 100, 32, 0),
                        child: Center(
                            child: Text(
                          'Verify OTP',
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
                          maxLength: 6,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          keyboardType: TextInputType.number,
                          controller: otpController,
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
                              hintText: 'Enter OTP',
                              hintStyle: GoogleFonts.poppins(fontSize: 14)),
                        ),
                      ),

                      //Submit button
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
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                // await userServices.verifyOtp(
                                //     _scaffoldKey, context, otpController.text);
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
