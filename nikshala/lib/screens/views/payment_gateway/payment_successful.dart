import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nikshala/config/config.dart';
import 'package:nikshala/screens/components/navigation_bar/navigation_bar.dart';

class PaymentSuccessFul extends StatefulWidget {
  @override
  _PaymentSuccessFulState createState() => _PaymentSuccessFulState();
}

class _PaymentSuccessFulState extends State<PaymentSuccessFul> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          backgroundColor: AppConfig.dashboardTopColor,
          body: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(26, 214, 38, 1)),
                    child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Icon(
                          Icons.check,
                          size: 50.0,
                          color: Colors.white,
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Payment Successful',
                      style: GoogleFonts.poppins(
                          fontSize: 24,
                          color: AppConfig.dashboardBottomColor,
                          fontWeight: FontWeight.w600)),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Your payment was successful! You can go to my videos',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                      )),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 60, 20, 0),
                    child: Container(
                      width: 242,
                      child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          )),
                          child: Text(
                            'Go To My Videos',
                            style: GoogleFonts.poppins(fontSize: 14),
                          ),
                          textColor: Colors.white,
                          padding: EdgeInsets.all(16),
                          onPressed: () async {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => NavigationBar(1, null),
                                ),
                                (_) => false);
                          },
                          color: AppConfig.dashboardBottomColor),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
