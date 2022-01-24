import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nikshala/config/config.dart';
import 'package:nikshala/models/categoryModel.dart';
import 'package:nikshala/models/folderModel.dart';
import 'package:nikshala/providers/category_provider/category_provider.dart';
import 'package:nikshala/providers/folder_provider/folder_provider.dart';
import 'package:nikshala/screens/views/courses_collection/courses_collection.dart';
import 'package:nikshala/screens/views/my_cart/my_cart_videos_widgets.dart';
import 'package:provider/provider.dart';

class CoursePackages extends StatefulWidget {
  final String id;
  CoursePackages(this.id, {Key key}) : super(key: key);
  @override
  _CoursePackagesState createState() => _CoursePackagesState();
}

class _CoursePackagesState extends State<CoursePackages> {
  //selecetd category value stored here
  String _selectedCategory;

  var categoryFuture;
  @override
  void initState() {
    categoryFuture =
        Provider.of<Categories>(context, listen: false).getAllCategories();

    super.initState();
  }

  String _search = '';
  List folder = [];
  List resultList = [];
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
                      padding: const EdgeInsets.fromLTRB(30, 20, 0, 20),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.keyboard_backspace_sharp,
                                color: Colors.white),
                          ),
                          SizedBox(
                            width: mq.size.width / 4,
                          ),
                          Center(
                            child: Text(
                              'Packages',
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        //search bar
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          height: 50,
                          width: mq.size.width * 0.9,
                          child: ListTile(
                            trailing: Icon(Icons.search),
                            title: TextField(
                              controller: searchController,
                              onChanged: (value) {
                                resultList = [];
                                setState(() {
                                  _search = value;
                                });

                                bool cond = false;
                                folder.forEach((element) {
                                  if (element.folderName
                                          .toLowerCase()
                                          .contains(value) ||
                                      element.folderName
                                          .toUpperCase()
                                          .contains(value) ||
                                      element.folderName.contains(value)) {
                                    cond = true;
                                    setState(() {
                                      resultList.add(element);
                                    });

                                    print(element);
                                  } else if (value.isEmpty) {
                                    setState(() {
                                      resultList = [];
                                    });
                                  }
                                });
                                if (!cond) {
                                  setState(() {
                                    resultList = [];
                                  });
                                }
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none, hintText: 'Search'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              //dropdown for showing categories
              FutureBuilder(
                  future: categoryFuture,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<CategoryModel>> snap) {
                    if (snap.connectionState == ConnectionState.done &&
                        !snap.hasError) {
                      if (_search.isNotEmpty) {
                        if (resultList.isEmpty) {
                          return Column(
                            children: [
                              SizedBox(
                                height: mq.size.height * 0.30,
                              ),
                              Center(child: Text('No result found')),
                            ],
                          );
                        }
                      }
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                                child: Container(
                              height: 50,
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                  canvasColor: Colors.white,
                                ),
                                child: DropdownButtonFormField(
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                  iconSize: 30,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 2, horizontal: 10),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                                          borderSide:
                                              BorderSide(color: Colors.grey)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                                          borderSide:
                                              BorderSide(color: Colors.grey)),
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: 'Select Category',
                                      hintStyle: TextStyle(color: Colors.grey)),
                                  value: widget.id.isEmpty
                                      ? snap.data[0].id
                                      : widget.id,
                                  onChanged: (newValue) {
                                    searchController.text = '';
                                    setState(() {
                                      _search = '';

                                      _selectedCategory = newValue;
                                    });
                                  },
                                  items: snap.data
                                      .map(
                                        (e) => DropdownMenuItem(
                                          child: Text(
                                            e.categoryName,
                                          ),
                                          value: e.id,
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                            )),
                          ],
                        ),
                      );
                    }
                    if (snap.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Center(
                      child: Text('Try Again'),
                    );
                  }),
              //folder list fetched by category id

              FutureBuilder(
                  future: Provider.of<Folder>(context, listen: false)
                      .getFoldersByCategoryId(
                          widget.id.isEmpty || _selectedCategory != null
                              ? _selectedCategory
                              : widget.id),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<FolderModel>> snap) {
                    if (snap.connectionState == ConnectionState.done &&
                        !snap.hasError) {
                      print(snap.data);
                      folder = snap.data;
                      print(folder);
                      return Expanded(
                        child: GridView.builder(
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 5 / 6,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 20,
                          ),
                          itemCount: _search.isEmpty
                              ? snap.data.length
                              : resultList.length,
                          itemBuilder: (BuildContext context, int i) {
                            print(snap.data[i].id);
                            //courses colletion list widget
                            return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => CoursesCollection(
                                              _search.isEmpty
                                                  ? snap.data[i].id
                                                  : resultList[i].id)));
                                },
                                child: mycartVideosList(
                                    mq,
                                    _search.isEmpty
                                        ? snap.data[i].folderImage
                                        : resultList[i].folderImage,
                                    _search.isEmpty
                                        ? snap.data[i].folderName
                                        : resultList[i].folderName,
                                    _search.isEmpty
                                        ? '${snap.data[i].videoCount}  ${snap.data[i].videoCount > 1 ? 'Videos' : 'Video'}'
                                        : '${resultList[i].videoCount}  ${resultList[i].videoCount > 1 ? 'Videos' : 'Video'}'));
                          },
                        ),
                      );
                    }
                    if (snap.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Center(
                      child: Text('Try Again'),
                    );
                  })
            ])));
  }
}
