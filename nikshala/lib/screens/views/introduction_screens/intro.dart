import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:nikshala/config/config.dart';
import 'package:nikshala/screens/views/user_login/user_login.dart';
// import 'package:swasthuDoc/components/bottomnavbar.dart';

class IntroScreens extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return IntroScreensState();
  }
}

class IntroScreensState extends State<IntroScreens> {
  //index of screen
  int currentPos = 0;
  //images
  List<Widget> widgetList = [
    MyImageView(
        "assets/intro_1.png",
        "With Nikshala, Now apply to international programs and schools that align with your skills and interests easily.",
        0),
    MyImageView(
        "assets/intro_2.png",
        "We are at Nikshala simplified your university application process with all the information you need.",
        1),
    MyImageView(
        "assets/intro_3.png",
        "Nikshala helps you to manage your time, Prioritize your tasks and many more.",
        2),
    MyImageView("assets/fb.png", "", 3)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConfig.dashboardTopColor,
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        CarouselSlider.builder(
          itemCount: widgetList.length,
          options: CarouselOptions(
              height: MediaQuery.of(context).size.height * 0.8,
              enlargeCenterPage: false,
              disableCenter: true,
              aspectRatio: 16 / 9,
              viewportFraction: 1.0,
              autoPlay: false,
              enableInfiniteScroll: false,
              onPageChanged: (index, reason) {
                setState(() {
                  currentPos = index;
                });
              }),
          itemBuilder: (context, index, realIndex) {
            return widgetList[index];
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widgetList.map((widget) {
            int index = widgetList.indexOf(widget);
            if (index == 3) {
              return Container();
            }
            //indicator
            return Container(
              width: 60.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: currentPos == index
                    ? AppConfig.dashboardBottomColor
                    : Colors.blueGrey[50],
              ),
            );
          }).toList(),
        ),
      ])),
    );
  }
}

class MyImageView extends StatelessWidget {
  final String imgPath;
  final String text;
  final int index;
  MyImageView(this.imgPath, this.text, this.index);

  @override
  Widget build(BuildContext context) {
    if (index == 3) {
      //redirecting to login when intro screen finished
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => UserLogin(),
          ),
          (_) => false);
    } else {
      //image with text widget
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: 297,
              height: 295,
              margin: EdgeInsets.symmetric(horizontal: 25),
              child: FittedBox(
                // fit: BoxFit.cover,
                child: Image.asset(imgPath),
              )),
          SizedBox(
            height: 50,
          ),
          Container(
            width: 297,
            child: Text(
              text,
              textAlign: TextAlign.center,
            ),
          )
        ],
      );
    }
  }
}
