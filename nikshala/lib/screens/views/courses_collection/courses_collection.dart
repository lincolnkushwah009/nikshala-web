import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nikshala/providers/folder_provider/folder_provider.dart';

import 'package:nikshala/config/config.dart';
import 'package:nikshala/screens/views/filters/filters.dart';
import 'package:nikshala/screens/views/video_details/video_details.dart';
import 'package:nikshala/screens/views/courses_collection/courses_collection_widget.dart';
import 'package:nikshala/screens/views/video_list/video_list.dart';
import 'package:provider/provider.dart';

class CoursesCollection extends StatefulWidget {
  //folder id
  final String folderId;
  CoursesCollection(this.folderId, {Key key}) : super(key: key);
  @override
  _CoursesCollectionState createState() => _CoursesCollectionState();
}

class _CoursesCollectionState extends State<CoursesCollection> {
  String _search = '';
  List folder = [];
  List resultList = [];
  var folderFuture;
  @override
  void initState() {
    folderFuture = Provider.of<Folder>(context, listen: false)
        .getSubFoldersByFolderId(widget.folderId);
    print(widget.folderId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return Scaffold(
        backgroundColor: AppConfig.dashboardTopColor,
        body: FutureBuilder(
            future: folderFuture,
            builder: (_, snap) {
              print(snap.data);
              if (snap.connectionState == ConnectionState.done &&
                  !snap.hasError) {
                folder = snap.data['attachFolders'].length == 0
                    ? snap.data['attachFiles']
                    : snap.data['attachFolders'];
                return Container(
                    color: AppConfig.dashboardTopColor,
                    height: mq.size.height,
                    width: double.infinity,
                    child: Stack(children: <Widget>[
                      //custom app bar
                      Container(
                        height: mq.size.height * 0.48,
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: mq.size.height * 0.35,
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
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 10, 0, 20),
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Icon(
                                              Icons.keyboard_backspace_sharp,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 0, 10, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        //search bar
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          height: 50,
                                          width: mq.size.width * 0.8,
                                          child: ListTile(
                                            trailing: Icon(Icons.search),
                                            title: TextField(
                                              onChanged: (value) {
                                                resultList = [];

                                                _search = value;

                                                bool cond = false;
                                                folder.forEach((element) {
                                                  if (snap.data['attachFolders']
                                                              .length ==
                                                          0
                                                      ? element['fileName']
                                                              .toLowerCase()
                                                              .contains(
                                                                  value) ||
                                                          element['fileName']
                                                              .toUpperCase()
                                                              .contains(
                                                                  value) ||
                                                          element['fileName']
                                                              .contains(value)
                                                      : element['folderName']
                                                              .toLowerCase()
                                                              .contains(
                                                                  value) ||
                                                          element['folderName']
                                                              .toUpperCase()
                                                              .contains(
                                                                  value) ||
                                                          element['folderName']
                                                              .contains(
                                                                  value)) {
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
                                                        builder: (_) =>
                                                            FilterScreen()));
                                              },
                                              icon: Icon(
                                                Icons.filter_list_outlined,
                                                color: Colors.white,
                                                size: 30,
                                              ),
                                            ),
                                            // if (AppConfig.filtervalues != null)
                                            //   if (AppConfig
                                            //       .filtervalues.isNotEmpty)
                                            //     new Positioned(
                                            //         top: 10,
                                            //         right: 8,
                                            //         child: new Container(
                                            //           padding:
                                            //               EdgeInsets.all(4),
                                            //           decoration:
                                            //               new BoxDecoration(
                                            //             color: Colors.red,
                                            //             borderRadius:
                                            //                 BorderRadius
                                            //                     .circular(25),
                                            //           ),
                                            //           constraints:
                                            //               BoxConstraints(
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
                          ],
                        ),
                      ),
                      // customAppBar(
                      //     context,
                      //     mq,
                      //     snap.data['folderThumbnail'],
                      //     snap.data['folderName'],
                      //     snap.data['totalVideosCount'].toString()),
                      //big image of course
                      Positioned(
                        top: mq.size.height * 0.28,
                        left: 0,
                        right: 0,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: mq.size.height * 0.25,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    snap.data['folderThumbnail'],
                                  ),
                                  fit: BoxFit.fill,
                                )),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 0, 20),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: RichText(
                                    // textAlign: TextAlign.center,
                                    text: TextSpan(children: [
                                  TextSpan(
                                      text: snap.data['folderName'],
                                      style: GoogleFonts.poppins(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500)),
                                  TextSpan(
                                      text:
                                          '\nTotal videos -${snap.data['totalVideosCount'].toString()}',
                                      style: GoogleFonts.lato(
                                        fontSize: 10,
                                        color: Colors.white,
                                      )),
                                ])),
                              ),
                            ),
                          ),
                        ),
                      ),
                      //courses colletion list in gridview
                      Positioned(
                        top: mq.size.height * 0.55,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: GridView.builder(
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 3.5 / 2,
                            mainAxisSpacing: 0,
                            crossAxisSpacing: 20,
                          ),
                          itemCount: _search.isNotEmpty
                              ? resultList.length
                              : snap.data['attachFolders'].length != 0
                                  ? snap.data['attachFolders'].length
                                  : snap.data['attachFiles'].length,
                          itemBuilder: (BuildContext context, int i) {
                            //courses colletion list widget
                            return GestureDetector(
                                onTap: () {
                                  print(snap.data['id']);
                                  _search.isNotEmpty
                                      ? snap.data['attachFolders'].length == 0
                                          ? Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) => VideoDetails(
                                                        resultList[i]['id'],
                                                      )))
                                          : Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) => VideosList(
                                                      resultList[i]['id'],
                                                      'false')))
                                      : snap.data['attachFolders'].length == 0
                                          ? Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) => VideoDetails(
                                                        snap.data['attachFiles']
                                                            [i]['id'],
                                                      )))
                                          : Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) => VideosList(
                                                      snap.data['attachFolders']
                                                                  .length ==
                                                              0
                                                          ? snap.data['id']
                                                          : snap.data[
                                                                  'attachFolders']
                                                              [i]['id'],
                                                      'false')));
                                },
                                child: coursesCollectionList(
                                    mq,
                                    _search.isNotEmpty
                                        ? snap.data['attachFolders'].length == 0
                                            ? '${AppConfig.imageUrl}/media/${resultList[i]['thumbnailImage']}'
                                            : resultList[i]['folderThumbnail']
                                        : snap.data['attachFolders'].length == 0
                                            ? '${AppConfig.imageUrl}/media/${snap.data['attachFiles'][i]['thumbnailImage']}'
                                            : snap.data['attachFolders'][i]
                                                ['folderThumbnail'],
                                    _search.isNotEmpty
                                        ? snap.data['attachFolders'].length == 0
                                            ? resultList[i]['fileName']
                                            : resultList[i]['folderName']
                                        : snap.data['attachFolders'].length == 0
                                            ? snap.data['attachFiles'][i]
                                                ['fileName']
                                            : snap.data['attachFolders'][i]
                                                ['folderName'],
                                    _search.isNotEmpty
                                        ? snap.data['attachFolders'].length == 0
                                            ? resultList.length.toString()
                                            : resultList[i]['videos']
                                                .length
                                                .toString()
                                        : snap.data['attachFolders'].length == 0
                                            ? snap.data['attachFiles'].length
                                                .toString()
                                            : (snap.data['attachFolders'][i]
                                                    ['videos'])
                                                .length
                                                .toString(),
                                    snap.data['attachFolders'].length == 0
                                        ? snap.data['attachFiles'][i]
                                                    ['duration']
                                                .toString() +
                                            ' min'
                                        : 'false'));
                          },
                        ),
                      ),
                    ]));
              }
              if (snap.connectionState == ConnectionState.waiting) {
                return Center(child: Image.asset(AppConfig.loader));
              }
              return Center(
                child: Text('Try Again'),
              );
            }));
  }
}
