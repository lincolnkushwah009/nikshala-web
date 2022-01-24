import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nikshala/config/config.dart';
import 'package:nikshala/models/categoryModel.dart';
import 'package:nikshala/models/userModel.dart';
import 'package:nikshala/providers/category_provider/category_provider.dart';
import 'package:nikshala/providers/folder_provider/folder_provider.dart';
import 'package:nikshala/providers/user_authentication_provider/user_authentication_provider.dart';
import 'package:nikshala/screens/components/navigation_bar/navigation_bar.dart';
import 'package:nikshala/screens/views/all_categories/all_categories.dart';
import 'package:nikshala/screens/views/bookmarks_videos/bookmarks_videos.dart';
import 'package:nikshala/screens/views/course_todo_list/course_todo_list.dart';
import 'package:nikshala/screens/views/course_packages/course_packages.dart';
import 'package:nikshala/screens/views/courses_collection/courses_collection.dart';
import 'package:nikshala/screens/views/my_cart/my_cart_checkout.dart';
import 'package:nikshala/services/dynamiclink_service.dart';
import 'package:nikshala/services/network_service.dart';
import 'package:provider/provider.dart';
import 'dashboard_widgets.dart';
import 'package:nikshala/models/folderModel.dart';

class DashBoard extends StatefulWidget {
  // rotue name
  static const routeName = 'dashboard';
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int _selectedIndex = 0;

  //category selection function
  _onSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  //category id
  String categoryId;
  var userFuture;
  var categoryFuture;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    userFuture = Provider.of<AuthData>(context, listen: false).getUserProfile();
    categoryFuture =
        Provider.of<Categories>(context, listen: false).getAllCategories();
    checkInternetWorking(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DynamicLinkService.initDynamicLinks(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 1,
        automaticallyImplyLeading: false,
        backgroundColor: AppConfig.dashboardTopColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    color: AppConfig.dashboardTopColor,
                    child: Column(
                      children: [
                        FutureBuilder(
                            future: userFuture,
                            builder: (BuildContext context,
                                AsyncSnapshot<UserModel> snap) {
                              if (snap.connectionState ==
                                      ConnectionState.done &&
                                  !snap.hasError) {
                                AppConfig.userName = snap.data.fullName;
                                return Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 15, 20, 0),
                                  child: ListTile(
                                    //cart icon
                                    trailing: InkWell(
                                      onTap: () async {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    MyCartCheckout()));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 20, 0, 0),
                                        child: Stack(
                                          children: [
                                            Image.asset(
                                              'assets/my_cart.png',
                                              width: 37,
                                              height: 30,
                                            ),
                                            new Positioned(
                                                right: 0,
                                                child: new Container(
                                                    padding: EdgeInsets.all(4),
                                                    decoration:
                                                        new BoxDecoration(
                                                      color: AppConfig
                                                          .dashboardBottomColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25),
                                                    ),
                                                    constraints: BoxConstraints(
                                                      minWidth: 20,
                                                      minHeight: 20,
                                                    ),
                                                    child: new Text(
                                                      snap.data.cartItem
                                                          .toString(),
                                                      style: new TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ))),
                                          ],
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      'Welcome',
                                      style: GoogleFonts.poppins(
                                          color: Colors.grey, fontSize: 14),
                                    ),
                                    //user name
                                    subtitle: Text(
                                      snap.data.fullName,
                                      style: GoogleFonts.poppins(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black),
                                    ),
                                  ),
                                );
                              }
                              if (snap.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return Center(
                                child: Text(''),
                              );
                            }),

                        //search bar
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 3,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            height: 50,
                            child: ListTile(
                              leading: Icon(Icons.search),
                              title: TextField(
                                controller: controller,
                                onChanged: (value) {
                                  AppConfig.text = value;

                                  Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  NavigationBar(2, '')))
                                      .then((value) {
                                    controller.clear();
                                  });
                                },
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Search',
                                    hintStyle:
                                        GoogleFonts.poppins(fontSize: 14)),
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                          child: ListTile(
                            trailing: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            AllCategoriesCourses()));
                              },
                              child: Image.asset(
                                'assets/menu.png',
                                width: 16,
                                height: 16,
                              ),
                            ),
                            title: Text(
                              'Categories',
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),

                        // category list widget
                        FutureBuilder(
                            future: categoryFuture,
                            builder: (BuildContext context,
                                AsyncSnapshot<List<CategoryModel>> snap) {
                              if (snap.connectionState ==
                                      ConnectionState.done &&
                                  !snap.hasError) {
                                return Container(
                                    height: 42.0,
                                    decoration: BoxDecoration(),
                                    child: ListView.builder(
                                      physics: BouncingScrollPhysics(),
                                      // shrinkWrap: true,
                                      itemCount: snap.data.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, i) {
                                        return Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 0, 0, 0),
                                          child: GestureDetector(
                                            onTap: () {
                                              _onSelected(i);
                                              setState(() {
                                                categoryId = snap.data[i].id;
                                                print(
                                                    'aa hallo ${snap.data[i].categoryName}');
                                              });
                                            },
                                            child: categories(
                                              snap.data[i].categoryName,
                                              _selectedIndex != null &&
                                                      _selectedIndex == i
                                                  ? AppConfig
                                                      .dashboardBottomColor
                                                  : Colors.white,
                                            ),
                                          ),
                                        );
                                      },
                                    ));
                              }
                              if (snap.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return Center(
                                child: Text(''),
                              );
                            }),

                        SizedBox(
                          height: 90,
                        )
                      ],
                    ),
                  ),

                  // my videos list widget
                  Container(
                    color: AppConfig.dashboardBottomColor,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 150, 10, 0),
                          child: ListTile(
                            title: Text(
                              'Explore',
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18),
                            ),
                            // subtitle: Text(
                            //   'Description for videos',
                            //   style: GoogleFonts.poppins(
                            //       color: Colors.white, fontSize: 14),
                            // ),
                            trailing: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 35),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              AllCategoriesCourses()));
                                },
                                child: Text(
                                  'View All',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                            height: 200,
                            child: ListView(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  CoursePackages('')));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 0, 0),
                                      child: myVideoListWithDescription(
                                        'Packages',
                                        'Click here to know more about the packages we are offering.',
                                        Color.fromRGBO(252, 0, 255, 59),
                                        Color.fromRGBO(33, 212, 253, 47),
                                      ),
                                    )),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => CourseTodoList()));
                                  },
                                  child: myVideoListWithDescription(
                                      'To do',
                                      'Got stuck? Know your priority.',
                                      Color.fromRGBO(249, 212, 35, 51),
                                      Color.fromRGBO(33, 212, 253, 47)),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                NavigationBar(4, null)));
                                  },
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  NavigationBar(1, null)));
                                    },
                                    child: myVideoListWithDescription(
                                        "My Video's",
                                        'Your purchased videos are in one place.',
                                        Color.fromRGBO(255, 181, 54, 100),
                                        Color.fromRGBO(33, 212, 253, 47)),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                NavigationBar(4, null)));
                                  },
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  BookMarkVideos()));
                                    },
                                    child: myVideoListWithDescription(
                                        "Bookmarks",
                                        'Save your videos today.',
                                        Color.fromRGBO(182, 76, 252, 100),
                                        Color.fromRGBO(33, 212, 253, 47)),
                                  ),
                                )
                              ],
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            //folders horizontal list widget
            Positioned(
              top: 270,
              left: 0,
              right: 0,
              child: FutureBuilder(
                  future: Provider.of<Folder>(context, listen: false)
                      .getFoldersByCategoryId(categoryId),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<FolderModel>> snap) {
                    if (snap.connectionState == ConnectionState.done &&
                        !snap.hasError) {
                      print(categoryId);
                      print(snap.data);
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: SizedBox(
                            height: 200,
                            child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: snap.data.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, i) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 0, 0, 0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => CoursesCollection(
                                                  snap.data[i].id)));
                                    },
                                    child: coursesListCategoryWise(
                                        snap.data[i].folderImage,
                                        snap.data[i].folderName,
                                        '${snap.data[i].videoCount}  ${snap.data[i].videoCount > 1 ? 'Videos' : 'Video'}'),
                                  ),
                                );
                              },
                            )),
                      );
                    }
                    if (snap.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: Image.asset(AppConfig.loader),
                      );
                    }
                    return Center(
                      child: Text('Try Again'),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
