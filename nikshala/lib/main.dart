import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nikshala/providers/cart_provider/cart_provider.dart';
import 'package:nikshala/providers/category_provider/category_provider.dart';
import 'package:nikshala/providers/filters/filter_provider.dart';
import 'package:nikshala/providers/folder_provider/folder_provider.dart';
import 'package:nikshala/providers/todo_provider/todo_provider.dart';
import 'package:nikshala/providers/video_provider/video_provider.dart';
import 'package:nikshala/screens/views/bookmarks_videos/bookmarks_videos.dart';
import 'package:nikshala/screens/views/change_password/change_password.dart';
import 'package:nikshala/screens/views/dashboard/dashboard.dart';
import 'package:nikshala/screens/views/forgot_password/forgot_password.dart';
import 'package:nikshala/screens/views/splash_screen.dart';
import 'package:nikshala/screens/views/user_login/user_login.dart';
import 'package:nikshala/screens/views/user_profile/user_profile.dart';
import 'package:nikshala/screens/views/user_signup/user_signup.dart';
import 'package:nikshala/screens/views/verify_otp/verify_otp.dart';
import 'package:nikshala/config/config.dart';
import 'package:nikshala/screens/components/navigation_bar/navigation_bar.dart';
import 'package:nikshala/providers/user_authentication_provider/user_authentication_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: AuthData(),
          ),
          ChangeNotifierProxyProvider<AuthData, Categories>(
            create: (_) => Categories(),
            update: (_, auth, hw) => Categories(),
          ),
          ChangeNotifierProxyProvider<AuthData, Folder>(
            create: (_) => Folder(),
            update: (_, auth, hw) => Folder(),
          ),
          ChangeNotifierProxyProvider<AuthData, Video>(
            create: (_) => Video(),
            update: (_, auth, hw) => Video(),
          ),
          ChangeNotifierProxyProvider<AuthData, AddCart>(
            create: (_) => AddCart(),
            update: (_, auth, hw) => AddCart(),
          ),
          ChangeNotifierProxyProvider<AuthData, TodoProvider>(
            create: (_) => TodoProvider(),
            update: (_, auth, hw) => TodoProvider(),
          ),
          ChangeNotifierProxyProvider<AuthData, FilterProvider>(
            create: (_) => FilterProvider(),
            update: (_, auth, hw) => FilterProvider(),
          ),
        ],
        child: MyApp(),
      ),
    );
  });
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

final storage = new FlutterSecureStorage();
final isAuth = storage.read(key: 'token');

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthData>(
      builder: (_, data, w) {
        return MaterialApp(
          title: 'NickShala',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            canvasColor: Colors.transparent,
            primaryColor: AppConfig.dashboardTopColor,
          ),
          home: getHomeScreen(),
          //routes are defined here
          routes: {
            DashBoard.routeName: (_) => DashBoard(),
            NavigationBar.routeName: (_) => NavigationBar(0, null),
            UserProfile.routeName: (_) => UserProfile(),
            UserSignup.routeName: (_) => UserSignup(),
            UserLogin.routeName: (_) => UserLogin(),
            ForgotPassword.routeName: (_) => ForgotPassword(),
            ChangePassword.routeName: (_) => ChangePassword(),
            VerifyOtp.routeName: (_) => VerifyOtp(),
            BookMarkVideos.routeName: (_) => BookMarkVideos(),
          },
        );
      },
    );
  }

  Widget getHomeScreen() {
    Widget w;
    w = SplashScreen();
    return w;
  }
}
