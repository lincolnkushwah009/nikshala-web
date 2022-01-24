import 'package:flutter/material.dart';
import 'items.dart';
import 'package:nikshala/screens/views/user_login/user_login.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  List<Widget> slides = items
      .map((item) => Container(
              // padding: EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
            children: <Widget>[
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Image.asset(
                  item['image'],
                  fit: BoxFit.fitWidth,
                  width: 220.0,
                  alignment: Alignment.bottomCenter,
                ),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 70.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        item['description'],
                        style: TextStyle(
                            color: Colors.black,
                            letterSpacing: 1.2,
                            fontSize: 16.0,
                            height: 1.3),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              )
            ],
          )))
      .toList();

  List<Widget> indicator() => List<Widget>.generate(
      slides.length,
      (index) => Container(
            margin: EdgeInsets.symmetric(horizontal: 3.0),
            height: 10.0,
            width: 70.0,
            decoration: BoxDecoration(
                color: currentPage.round() == index
                    ? Color.fromRGBO(45, 95, 233, 1)
                    : Color(0XFF256075).withOpacity(0.2),
                borderRadius: BorderRadius.circular(10.0)),
          ));

  double currentPage = 0.0;
  final _pageViewController = new PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Stack(
          children: <Widget>[
            PageView.builder(
              controller: _pageViewController,
              itemCount: slides.length,
              itemBuilder: (BuildContext context, int index) {
                _pageViewController.addListener(() {
                  if (_pageViewController.page == slides.length - 1) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) => UserLogin(),
                        ),
                        (_) => false);
                  }
                  setState(() {
                    currentPage = _pageViewController.page;
                    print("aa");
                    print(currentPage);
                  });
                });
                return slides[index];
              },
            ),
            Positioned(
                top: 700,
                left: 0,
                right: 0,
                child: Container(
                  // margin: EdgeInsets.only(top: 0.0),
                  // padding: EdgeInsets.symmetric(vertical: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: indicator(),
                  ),
                )
                //  ),
                )
            // )
          ],
        ),
      ),
    );
  }
}
