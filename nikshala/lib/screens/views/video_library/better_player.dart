import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nikshala/config/config.dart';
import 'package:nikshala/providers/cart_provider/cart_provider.dart';

import 'package:nikshala/providers/video_provider/video_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:nikshala/screens/views/video_details/overview_course.dart';

class VideoLibrary extends StatefulWidget {
  //video url
  final String videoUrl;
  //video url
  final String videoId;
  VideoLibrary(this.videoUrl, this.videoId, {Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<VideoLibrary> {
  var videoFuture;
  var streamFuture;
  @override
  void initState() {
    videoFuture = Provider.of<AddCart>(context, listen: false)
        .getPurchasedVideoDetailById(widget.videoId);
    streamFuture = Provider.of<Video>(context, listen: false)
        .generateVideoUrl(widget.videoId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var isPortrait =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      appBar: !isPortrait
          ? AppBar(
              automaticallyImplyLeading: false,
              title: Row(
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
              backgroundColor: AppConfig.dashboardBottomColor,
              centerTitle: true,
            )
          : null,
      body: FutureBuilder(
          future: videoFuture,
          builder: (_, snap) {
            if (snap.connectionState == ConnectionState.done &&
                !snap.hasError) {
              return Container(
                  color: AppConfig.dashboardTopColor,
                  width: double.infinity,
                  child: Column(
                    children: <Widget>[
                      //video player
                      FutureBuilder(
                          future: streamFuture,
                          builder: (_, snap) {
                            if (snap.connectionState == ConnectionState.done &&
                                !snap.hasError) {
                              AppConfig.videoToken =
                                  snap.data['data']['authToken'];
                              print("done");
                              print(snap.data['data']);
                              return AspectRatio(
                                aspectRatio: 16 / 9,
                                child: BetterPlayerPlaylist(
                                    betterPlayerConfiguration:
                                        BetterPlayerConfiguration(
                                            controlsConfiguration:
                                                BetterPlayerControlsConfiguration(
                                              playerTheme:
                                                  BetterPlayerTheme.material,
                                              skipForwardIcon:
                                                  Icons.fast_forward,
                                              skipBackIcon: Icons.fast_rewind,
                                              enableProgressText: false,
                                              enableOverflowMenu: false,
                                            ),
                                            // looping: false,
                                            // allowedScreenSleep: true,
                                            deviceOrientationsAfterFullScreen: [
                                              DeviceOrientation.portraitUp,
                                              DeviceOrientation.portraitDown,
                                            ],
                                            autoPlay: true),
                                    betterPlayerPlaylistConfiguration:
                                        BetterPlayerPlaylistConfiguration(
                                            loopVideos: false),
                                    betterPlayerDataSourceList: createDataSet(
                                        snap.data['data']['url'],
                                        snap.data['data']['authToken'])),
                              );
                            }
                            if (snap.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                  child: Image.asset(AppConfig.loader));
                            }
                            return Center(
                              child: Text('Try Again'),
                            );
                          }),
                      //video details
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text('${snap.data['fileName']},',
                                  maxLines: 3,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600)),
                            ),
                            Text(snap.data['degree'],
                                style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black)),
                            Text(
                                'Package expires on: ${DateFormat.yMMMd().format(DateTime.parse(snap.data['expireDate']))}',
                                style: GoogleFonts.poppins(
                                    fontSize: 11, fontWeight: FontWeight.w500)),
                          ],
                        ),
                        // child: ListTile(
                        //   title: Text('${snap.data['fileName']},',
                        //       // maxLines: 2,
                        //       // softWrap: true,
                        //       // overflow: TextOverflow.ellipsis,
                        //       style: GoogleFonts.poppins(
                        //           fontSize: 17, fontWeight: FontWeight.w600)),
                        //   subtitle: Text(snap.data['degree'],
                        //       style: GoogleFonts.poppins(
                        //           fontSize: 13,
                        //           fontWeight: FontWeight.w500,
                        //           color: Colors.black)),
                        //   trailing: Text(
                        //       'Package expires on: ${DateFormat.yMMMd().format(DateTime.parse(snap.data['expireDate']))}',
                        //       style: GoogleFonts.poppins(
                        //           fontSize: 11, fontWeight: FontWeight.w500)),
                        // ),
                      ),
                      SizedBox(
                        height: 30,
                      ),

                      //tab controllers for description of video
                      Expanded(
                        child: DefaultTabController(
                          initialIndex: 0,
                          length: 3,
                          child: Scaffold(
                            appBar: AppBar(
                              automaticallyImplyLeading: false,
                              flexibleSpace: Column(
                                children: [
                                  TabBar(
                                    labelStyle: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12),
                                    indicatorWeight: 10,
                                    indicatorColor:
                                        AppConfig.dashboardBottomColor,
                                    tabs: [
                                      Tab(
                                        text: 'OVERVIEW',
                                      ),
                                      Tab(
                                        text: 'REQUIREMENTS',
                                      ),
                                      Tab(
                                        text: 'CONTACT',
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              centerTitle: false,
                            ),
                            body: TabBarView(
                              children: [
                                OverViewCourse(
                                    snap.data['overviewInfo'], snap.data),
                                Requirements(
                                    snap.data['requirmentInfo'], snap.data),
                                Contact(snap.data['contactInfo'], snap.data),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ));
            }
            if (snap.connectionState == ConnectionState.waiting) {
              return Center(child: Image.asset(AppConfig.loader));
            }
            return Center(
              child: Text('Try Again'),
            );
          }),
    );
  }

//video url set
  List<BetterPlayerDataSource> createDataSet(String url, String token) {
    List dataSourceList = List<BetterPlayerDataSource>();
    dataSourceList.add(
      BetterPlayerDataSource(BetterPlayerDataSourceType.network, url,
          headers: {"authorization": token}),
    );

    return dataSourceList;
  }
}
