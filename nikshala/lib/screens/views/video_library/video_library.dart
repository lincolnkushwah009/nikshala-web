// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:nikshala/config/config.dart';
// import 'package:nikshala/providers/cart_provider/cart_provider.dart';
// import 'package:nikshala/providers/video_provider/video_provider.dart';
// import 'package:nikshala/screens/views/video_details/overview_course.dart';
// import 'package:provider/provider.dart';
// import 'package:yoyo_player/yoyo_player.dart';
// import 'package:intl/intl.dart';

// class VideoLibrary extends StatefulWidget {
//   //video url
//   final String videoUrl;
//   //video url
//   final String videoId;
//   VideoLibrary(this.videoUrl, this.videoId, {Key key}) : super(key: key);
//   // rotue name
//   static const routeName = 'video-library';
//   @override
//   _VideoLibraryState createState() => _VideoLibraryState();
// }

// class _VideoLibraryState extends State<VideoLibrary> {
//   bool fullscreen = false;
//   var videoFuture;
//   var streamFuture;
//   @override
//   void initState() {
//     videoFuture = Provider.of<AddCart>(context, listen: false)
//         .getPurchasedVideoDetailById(widget.videoId);
//     streamFuture = Provider.of<Video>(context, listen: false)
//         .generateVideoUrl(widget.videoId);

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: fullscreen == false
//           ? AppBar(
//               automaticallyImplyLeading: false,
//               title: Row(
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                     child: Icon(Icons.keyboard_backspace_sharp,
//                         color: Colors.white),
//                   ),
//                 ],
//               ),
//               backgroundColor: AppConfig.dashboardBottomColor,
//               centerTitle: true,
//             )
//           : null,
//       backgroundColor: AppConfig.dashboardTopColor,
//       body: FutureBuilder(
//           future: videoFuture,
//           builder: (_, snap) {
//             if (snap.connectionState == ConnectionState.done &&
//                 !snap.hasError) {
//               return Container(
//                   color: AppConfig.dashboardTopColor,
//                   width: double.infinity,
//                   child: Column(
//                     children: <Widget>[
//                       FutureBuilder(
//                           future: streamFuture,
//                           builder: (_, snap) {
//                             if (snap.connectionState == ConnectionState.done &&
//                                 !snap.hasError) {
//                               AppConfig.videoToken =
//                                   snap.data['data']['authToken'];
//                               print("done");
//                               print(snap.data['data']);
//                               return YoYoPlayer(
//                                 aspectRatio: 16 / 9,
//                                 url:
//                                     // "http://65.1.255.116:4000/playVideo",
//                                     snap.data['data']['url'],

//                                 // "http://65.1.255.116:8000/mv/dq/index.m3u8?sign=1622182020-b43f2a1a492a211e74b5a6ccb039b026",
//                                 // "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
//                                 // "https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8",
//                                 // 'http://65.2.146.165:8000//live/test/index.m3u8',
//                                 // "https://player.vimeo.com/external/440218055.m3u8?s=7ec886b4db9c3a52e0e7f5f917ba7287685ef67f&oauth2_token_id=1360367101",
//                                 // "http://65.2.146.165:8000//live/test/index.m3u8",
//                                 // "https://sfux-ext.sfux.info/hls/chapter/105/1588724110/1588724110.m3u8",
//                                 videoStyle: VideoStyle(
//                                     play: Icon(Icons.perm_camera_mic),
//                                     pause: Icon(Icons.headset),
//                                     fullscreen: Icon(Icons.fullscreen),
//                                     // qualitystyle:
//                                     //     TextStyle(color: Colors.transparent),
//                                     // qashowstyle:
//                                     //     TextStyle(color: Colors.transparent),
//                                     forward: Icon(Icons.skip_next),
//                                     backward: Icon(Icons.skip_previous),
//                                     playedColor: Colors.red),
//                                 videoLoadingStyle: VideoLoadingStyle(
//                                   loading: Center(
//                                     child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       children: [Image.asset(AppConfig.loader)],
//                                     ),
//                                   ),
//                                 ),
//                                 onfullscreen: (t) {
//                                   setState(() {
//                                     fullscreen = t;
//                                   });
//                                 },
//                               );
//                             }
//                             if (snap.connectionState ==
//                                 ConnectionState.waiting) {
//                               return Center(
//                                   child: Image.asset(AppConfig.loader));
//                             }
//                             return Center(
//                               child: Text('Try Again'),
//                             );
//                           }),
//                       Padding(
//                         padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
//                         child: ListTile(
//                           title: Text('${snap.data['fileName']},',
//                               maxLines: 2,
//                               softWrap: true,
//                               overflow: TextOverflow.ellipsis,
//                               style: GoogleFonts.poppins(
//                                   fontSize: 17, fontWeight: FontWeight.w600)),
//                           subtitle: Text(snap.data['degree'],
//                               style: GoogleFonts.poppins(
//                                   fontSize: 13,
//                                   fontWeight: FontWeight.w500,
//                                   color: Colors.black)),
//                           trailing: Text(
//                               'Package expires on: ${DateFormat.yMMMd().format(DateTime.parse(snap.data['expireDate']))}',
//                               style: GoogleFonts.poppins(
//                                   fontSize: 11, fontWeight: FontWeight.w500)),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                       ),

//                       //tab controllers
//                       Expanded(
//                         child: DefaultTabController(
//                           initialIndex: 0,
//                           length: 3,
//                           child: Scaffold(
//                             appBar: AppBar(
//                               automaticallyImplyLeading: false,
//                               flexibleSpace: Column(
//                                 children: [
//                                   TabBar(
//                                     labelStyle: GoogleFonts.poppins(
//                                         color: Colors.black,
//                                         fontWeight: FontWeight.w500,
//                                         fontSize: 12),
//                                     indicatorColor:
//                                         AppConfig.dashboardBottomColor,
//                                     tabs: [
//                                       Tab(
//                                         text: 'OVERVIEW',
//                                       ),
//                                       Tab(
//                                         text: 'REQUIREMENTS',
//                                       ),
//                                       Tab(
//                                         text: 'CONTACT',
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                               centerTitle: false,
//                             ),
//                             body: TabBarView(
//                               children: [
//                                 OverViewCourse(snap.data['overviewInfo']),
//                                 OverViewCourse(snap.data['requirmentInfo']),
//                                 OverViewCourse(snap.data['contactInfo']),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ));
//             }
//             if (snap.connectionState == ConnectionState.waiting) {
//               return Center(child: Image.asset(AppConfig.loader));
//             }
//             return Center(
//               child: Text('Try Again'),
//             );
//           }),
//     );
//   }
// }
