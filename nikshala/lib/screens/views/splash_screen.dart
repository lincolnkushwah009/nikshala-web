import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nikshala/config/config.dart';
import 'package:nikshala/screens/components/navigation_bar/navigation_bar.dart';
import 'package:nikshala/screens/views/user_login/user_login.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:nikshala/screens/views/introduction_screens/intro.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final storage = new FlutterSecureStorage();
  @override
  void initState() {
    super.initState();

    //navigate to login screen
    Future.delayed(const Duration(seconds: 2), () {
      _getUser();
    });
  }

  Future<Map<String, dynamic>> _getUser() async {
    final isAuth = await storage.read(key: 'token');

    bool hasExpired = JwtDecoder.isExpired(isAuth);
    print(isAuth);
    if (isAuth != null) {
      if (!hasExpired) {
        Navigator.pushReplacementNamed(context, NavigationBar.routeName);
      } else {
        Navigator.pushReplacement(
            context, new MaterialPageRoute(builder: (context) => UserLogin()));
      }
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => UserLogin(),
          ),
          (_) => false);
      // Navigator.pushReplacement(
      //     context, new MaterialPageRoute(builder: (context) => IntroScreens()));
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppConfig.dashboardBottomColor,
        body: Container(
            child: Center(
                child: Image.asset(
          AppConfig.appLogo,
          height: 96.52,
          width: 218.26,
        ))));
  }
}
