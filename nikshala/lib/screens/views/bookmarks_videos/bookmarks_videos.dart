import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nikshala/models/userModel.dart';
import 'package:nikshala/providers/user_authentication_provider/user_authentication_provider.dart';
import 'package:nikshala/providers/video_provider/video_provider.dart';
import 'package:nikshala/screens/views/bookmarks_videos/bookmark_widget.dart';
import 'package:nikshala/config/config.dart';
import 'package:nikshala/screens/views/my_cart/my_cart_checkout.dart';
import 'package:nikshala/screens/views/video_details/video_details.dart';
import 'package:provider/provider.dart';

class BookMarkVideos extends StatefulWidget {
  // rotue name
  static const routeName = 'bookmark-videos';

  @override
  _BookMarkVideosVideosState createState() => _BookMarkVideosVideosState();
}

class _BookMarkVideosVideosState extends State<BookMarkVideos> {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return Scaffold(
        backgroundColor: AppConfig.dashboardTopColor,
        body: Container(
            color: AppConfig.dashboardTopColor,
            height: mq.size.height,
            width: double.infinity,
            child: Stack(
              children: <Widget>[
                //custom app bar
                Container(
                  height: mq.size.height * 0.30,
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
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 10),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(Icons.keyboard_backspace_sharp,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              width: mq.size.width / 5,
                            ),
                            Center(
                              child: Text(
                                'Bookmarks',
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(
                              width: mq.size.width * 0.09,
                            ),
                            FutureBuilder(
                                future: Provider.of<AuthData>(context,
                                        listen: false)
                                    .getUserProfile(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<UserModel> snap) {
                                  if (snap.connectionState ==
                                          ConnectionState.done &&
                                      !snap.hasError) {
                                    AppConfig.userName = snap.data.fullName;
                                    return Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 0, 20, 0),
                                      child: InkWell(
                                        onTap: () async {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      MyCartCheckout()));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 0, 0),
                                          child: Stack(
                                            children: [
                                              Image.asset(
                                                'assets/my_cart.png',
                                                width: 40,
                                                color: Colors.white,
                                                height: 37,
                                              ),
                                              new Positioned(
                                                  right: 0,
                                                  child: new Container(
                                                      padding:
                                                          EdgeInsets.all(4),
                                                      decoration:
                                                          new BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25),
                                                      ),
                                                      constraints:
                                                          BoxConstraints(
                                                        minWidth: 23,
                                                        minHeight: 23,
                                                      ),
                                                      child: new Text(
                                                        snap.data.cartItem
                                                            .toString(),
                                                        style: new TextStyle(
                                                          color: AppConfig
                                                              .dashboardBottomColor,
                                                          fontSize: 12,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ))),
                                            ],
                                          ),
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
                                    child: Text('Try Again'),
                                  );
                                }),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
                        child: Text('Save now! Buy later',
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w600)),
                      )
                    ],
                  ),
                ),

                //List of courses
                FutureBuilder(
                    future: Provider.of<Video>(context, listen: false)
                        .getAllBookmarkVideos(),
                    builder: (_, snap) {
                      if (snap.connectionState == ConnectionState.done &&
                          !snap.hasError) {
                        if (snap.data.isEmpty) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: mq.size.height / 3.5,
                              ),
                              Center(child: Text('No item found')),
                            ],
                          );
                        }
                        return Positioned.fill(
                          top: mq.size.height * 0.20,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: mq.size.height * 0.80,
                            child: ListView.builder(
                                // physics: BouncingScrollPhysics(),
                                itemCount: snap.data.length,
                                itemBuilder: (_, i) => GestureDetector(
                                      onTap: () {},
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) => VideoDetails(
                                                        snap.data[i]['video']
                                                            ['id'],
                                                      )));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 10, 10, 0),
                                          child: Container(
                                            child: Card(
                                              child: Container(
                                                width: mq.size.width * 0.6,
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        5, 0, 0, 3),
                                                child: Column(
                                                  children: <Widget>[
                                                    SizedBox(height: 5),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        //college image widget
                                                        buildImageBookmark(
                                                            '${AppConfig.imageUrl}/media/' +
                                                                snap.data[i][
                                                                        'video']
                                                                    [
                                                                    'thumbnailImage'],
                                                            false),
                                                        SizedBox(width: 10),
                                                        // course information widget
                                                        bookmarkVideos(
                                                          context,
                                                          mq,
                                                          snap.data[i]['video']
                                                              ['id'],
                                                          snap.data[i]['video']
                                                                  ['folder']
                                                              ['folderName'],
                                                          snap.data[i]['video']
                                                              ['fileName'],
                                                          snap.data[i]['video']
                                                              ['city'],
                                                          snap.data[i]['video'][
                                                                      'duration']
                                                                  .toString() +
                                                              ' min',
                                                          snap.data[i][
                                                              'isAddedFromCart'],
                                                          '${AppConfig.imageUrl}/media/' +
                                                              snap.data[i]
                                                                      ['video'][
                                                                  'thumbnailImage'],
                                                        ),
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
                          ),
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
                    })
              ],
            )));
  }
}
