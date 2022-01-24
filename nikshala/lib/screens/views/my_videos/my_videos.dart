import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nikshala/providers/cart_provider/cart_provider.dart';
import 'package:nikshala/config/config.dart';
import 'package:nikshala/screens/components/navigation_bar/navigation_bar.dart';
import 'package:nikshala/screens/views/my_videos/my_videos_widget.dart';
import 'package:nikshala/screens/views/video_library/better_player.dart';
import 'package:nikshala/screens/views/video_list/video_list.dart';
import 'package:nikshala/services/network_service.dart';
import 'package:provider/provider.dart';

class MyVideos extends StatefulWidget {
  // rotue name
  static const routeName = 'bookmark-videos';

  @override
  _MyVideosState createState() => _MyVideosState();
}

class _MyVideosState extends State<MyVideos> {
  //this function is handling back button
  Future<bool> _willPopCallback() async {
    return Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => NavigationBar(0, null),
        ),
        (_) => false);
  }

  @override
  void initState() {
    checkInternetWorking(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return WillPopScope(
        onWillPop: _willPopCallback,
        child: Scaffold(
            backgroundColor: AppConfig.dashboardTopColor,
            body: Container(
                color: AppConfig.dashboardTopColor,
                height: mq.size.height,
                width: double.infinity,
                child: Stack(
                  children: <Widget>[
                    //custom app bar
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
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Text(
                                    'My Videos',
                                    style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Text('Keep an eye on the expiry dates.',
                                style: GoogleFonts.poppins(
                                    fontSize: 14, color: Colors.white)),
                          )
                        ],
                      ),
                    ),

                    //List of courses
                    Positioned.fill(
                      top: mq.size.height * 0.25,
                      left: 0,
                      right: 0,
                      child: FutureBuilder(
                          future: Provider.of<AddCart>(context, listen: false)
                              .getAllPlaceOrders(),
                          builder: (_, snap) {
                            if (snap.connectionState == ConnectionState.done &&
                                !snap.hasError) {
                              if (snap.data.isEmpty) {
                                return Center(
                                    child: Text(
                                        'You have not purchased any item yet'));
                              }
                              return Container(
                                height: mq.size.height * 0.80,
                                child: ListView.builder(
                                    // physics: BouncingScrollPhysics(),
                                    itemCount: snap.data.length,
                                    itemBuilder: (_, i) => GestureDetector(
                                          onTap: () {},
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 10, 10, 0),
                                            child: Container(
                                              child: GestureDetector(
                                                onTap: () {
                                                  if (snap.data[i]
                                                          ['folderName'] ==
                                                      null) {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (_) =>
                                                                VideoLibrary(
                                                                    snap.data[i]
                                                                        [
                                                                        'fileURL'],
                                                                    snap.data[i]
                                                                        [
                                                                        'id'])));
                                                  } else {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (_) =>
                                                                VideosList(
                                                                    snap.data[i]
                                                                        ['id'],
                                                                    'true')));
                                                  }
                                                },
                                                child: Card(
                                                  child: Container(
                                                    width: mq.size.width * 0.6,
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    child: Column(
                                                      children: <Widget>[
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            //college image widget
                                                            buildVideoImage(
                                                                snap.data[i][
                                                                            'thumbnailImage'] ==
                                                                        null
                                                                    ? '${snap.data[i]['folderThumbnail']}'
                                                                    : '${AppConfig.imageUrl}/media/${snap.data[i]['thumbnailImage']}',
                                                                snap.data[i][
                                                                    'totalVideosCount']),
                                                            SizedBox(width: 10),
                                                            // course information widget
                                                            buildVideoWidget(
                                                                mq,
                                                                snap.data[i]['folderName'] != null
                                                                    ? snap.data[i][
                                                                        'folderName']
                                                                    : snap.data[i]['folder'][
                                                                        'folderName'],
                                                                snap.data[i]['fileName'] ??
                                                                    '',
                                                                snap.data[i]['city'] ??
                                                                    '',
                                                                snap.data[i]['duration'] ==
                                                                        null
                                                                    ? ''
                                                                    : snap.data[i]['duration'].toString() +
                                                                            ' min' ??
                                                                        '',
                                                                snap.data[i]['totalVideosCount'] !=
                                                                        null
                                                                    ? snap.data[i]['totalVideosCount'] >
                                                                            1
                                                                        ? snap.data[i]['totalVideosCount'].toString() +
                                                                            ' Videos'
                                                                        : snap.data[i]['totalVideosCount'].toString() +
                                                                            ' Video'
                                                                    : '',
                                                                snap.data[i]['thumbnailImage'] == null
                                                                    ? '${snap.data[i]['folderThumbnail']}'
                                                                    : '${AppConfig.imageUrl}/media/${snap.data[i]['thumbnailImage']}',
                                                                snap.data[i]
                                                                    ['id']),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )),
                              );
                            }
                            if (snap.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: Image.asset(AppConfig.loader),
                              );
                            }
                            return Center(
                              child: Text('No Videos'),
                            );
                          }),
                    ),
                  ],
                ))));
  }
}
