import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nikshala/config/config.dart';
import 'package:nikshala/providers/category_provider/category_provider.dart';
import 'package:nikshala/screens/views/course_packages/course_packages.dart';
import 'package:nikshala/screens/views/courses_collection/courses_collection.dart';
import 'package:nikshala/screens/views/dashboard/dashboard_widgets.dart';
import 'package:nikshala/screens/views/filters/filters.dart';
import 'package:provider/provider.dart';

class AllCategoriesCourses extends StatefulWidget {
  // rotue name
  static const routeName = 'all-categories';
  @override
  _AllCategoriesCoursesState createState() => _AllCategoriesCoursesState();
}

class _AllCategoriesCoursesState extends State<AllCategoriesCourses> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return Scaffold(
        backgroundColor: AppConfig.dashboardTopColor,
        body: Container(
            color: AppConfig.dashboardTopColor,
            height: mq.size.height,
            width: double.infinity,
            child: Column(children: <Widget>[
              //custom app bar
              Container(
                height: mq.size.height * 0.3,
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
                      padding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
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
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          //search bar
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            height: 50,
                            width: mq.size.width * 0.8,
                            child: ListTile(
                              trailing: Icon(Icons.search),
                              title: TextField(
                                controller: searchController,
                                onChanged: (value) {
                                  setState(() {});
                                },
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Search'),
                              ),
                            ),
                          ),
                          Stack(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => FilterScreen()));
                                },
                                icon: Icon(
                                  Icons.filter_list_outlined,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                              // if (AppConfig.filtervalues != null)
                              //   if (AppConfig.filtervalues.isNotEmpty)
                              //     new Positioned(
                              //         top: 10,
                              //         right: 8,
                              //         child: new Container(
                              //           padding: EdgeInsets.all(4),
                              //           decoration: new BoxDecoration(
                              //             color: Colors.red,
                              //             borderRadius:
                              //                 BorderRadius.circular(25),
                              //           ),
                              //           constraints: BoxConstraints(
                              //             minWidth: 15,
                              //             minHeight: 15,
                              //           ),
                              //         )),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // category list widget with vertical listview
              FutureBuilder(
                  future: Provider.of<Categories>(context, listen: false)
                      .getAllCategoriesWithFolders(searchController.text),
                  builder: (_, snap) {
                    if (snap.connectionState == ConnectionState.done &&
                        !snap.hasError) {
                      if (snap.data.isEmpty) {
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: mq.size.height * 0.25,
                              ),
                              Text('No result found'),
                            ],
                          ),
                        );
                      }
                      print(snap.data);
                      return Expanded(
                        child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: snap.data.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, i) {
                              return Column(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 0, 20, 0),
                                    child: ListTile(
                                      trailing: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      CoursePackages(
                                                          snap.data[i]['id'])));
                                        },
                                        child: Text(
                                          'View all',
                                          style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      title: Text(
                                        snap.data[i]['categoryName'],
                                        style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                  //horizontal listview
                                  Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: SizedBox(
                                          height: 200,
                                          child: ListView.builder(
                                            physics: BouncingScrollPhysics(),
                                            itemCount:
                                                snap.data[i]['folders'].length,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        15, 0, 0, 0),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (_) =>
                                                                CoursesCollection(
                                                                  snap.data[i][
                                                                          'folders']
                                                                      [
                                                                      index]['id'],
                                                                )));
                                                  },
                                                  child: coursesListCategoryWise(
                                                      snap.data[i]['folders']
                                                              [index]
                                                          ['folderThumbnail'],
                                                      snap.data[i]['folders']
                                                          [index]['folderName'],
                                                      snap.data[i]['folders']
                                                                  [index][
                                                                  'totalVideosCount']
                                                              .toString() +
                                                          ' Videos'),
                                                ),
                                              );
                                            },
                                          ))),
                                ],
                              );
                            }),
                      );
                    }
                    if (snap.connectionState == ConnectionState.waiting) {
                      return Center(child: Image.asset(AppConfig.loader));
                    }
                    return Center(
                      child: Text('Try Again'),
                    );
                  })
            ]))
        // }

        // }
        );
  }
}
