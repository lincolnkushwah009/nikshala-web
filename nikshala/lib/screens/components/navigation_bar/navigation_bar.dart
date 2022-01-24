import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:nikshala/config/config.dart';
import 'package:nikshala/screens/components/user_profile_dialog/user_profile_dialog.dart';
import 'package:nikshala/screens/views/video_details/video_details.dart';
import 'package:nikshala/screens/views/all_categories/all_categories.dart';
import 'package:nikshala/screens/views/bookmarks_videos/bookmarks_videos.dart';
import 'package:nikshala/screens/views/search_videos/search_videos.dart';
import 'package:nikshala/screens/views/course_packages/course_packages.dart';
import 'package:nikshala/screens/views/course_todo_list/course_todo_list.dart';
import 'package:nikshala/screens/views/course_todo_list/add_notes.dart';
import 'package:nikshala/screens/views/courses_collection/courses_collection.dart';
import 'package:nikshala/screens/views/dashboard/dashboard.dart';
import 'package:nikshala/screens/views/video_library/better_player.dart';
import 'package:nikshala/screens/views/video_list/video_list.dart';
import 'package:nikshala/screens/views/my_cart/my_cart_checkout.dart';
import 'package:nikshala/screens/views/my_cart/my_cart_videos.dart';
import 'package:nikshala/screens/views/my_videos/my_videos.dart';

// ignore: must_be_immutable
class NavigationBar extends StatefulWidget {
  int _selectedIndex = 0;
  String userName;
  NavigationBar(this._selectedIndex, this.userName, {Key key})
      : super(key: key);
  // rotue name
  static const routeName = 'navigation-bar';

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  // select item in navigation bar

  final _widgetOptions = <Widget>[
    //dashboard screen
    DashBoard(),

    //video library screen
    MyVideos(),

    SearchVideos(AppConfig.text, null),

    DashBoard(),
    AllCategoriesCourses(),

    //user profile screen
    CoursesCollection(null),

    //course description screen before adding in cart
    VideosList('', ''),
    VideoDetails(''),

    //add course to cart screen

    //my cart video list screen
    MyCartVideos(),

    //my cart checkout screen
    MyCartCheckout(),

    //todolist screen
    CourseTodoList(),

    BookMarkVideos(),

    MyVideos(),

    CoursePackages(''),

    Documentation('', '', ''),

    VideoLibrary('', '')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: _widgetOptions.elementAt(widget._selectedIndex),
      ),
      // bottom navigation bar
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
        ]),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
                rippleColor: Colors.grey[300],
                hoverColor: Colors.grey[100],
                gap: 8,
                activeColor: Colors.black,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: Duration(milliseconds: 400),
                tabBackgroundColor: Colors.grey[100],
                tabs: [
                  GButton(
                    icon: Icons.home_outlined,
                  ),
                  GButton(
                    icon: Icons.video_library_outlined,
                  ),
                  GButton(
                    icon: Icons.search,
                  ),
                  GButton(
                    icon: Icons.person_outline,
                  ),
                ],
                selectedIndex: widget._selectedIndex,
                // used for switching items in navigation bar
                onTabChange: (index) {
                  if (index == 3) {
                    Navigator.of(context);
                    UserProfileDialogs.showProfileDilalog(
                      context,
                      AppConfig.userName,
                    );
                  }
                  setState(() {
                    widget._selectedIndex = index;
                  });
                }),
          ),
        ),
      ),
    );
  }
}
