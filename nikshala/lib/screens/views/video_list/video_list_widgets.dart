import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nikshala/screens/components/dialogs.dart';
import 'package:nikshala/services/bookmark_services.dart';
import 'package:nikshala/services/dynamiclink_service.dart';

//course information widget
BookmarkServices bookmarkServices = BookmarkServices();

Widget buildCartVideoList(
  BuildContext context,
  MediaQueryData mq,
  bool isBookmark,
  String id,
  String name,
  String image,
  String course,
  String flag,
  String city,
  String duration,
  bool isAddedCart,
  String isPurchased,
  String folderId,
  bool isPurchasedVideo,
) {
  return Flexible(
    child: Container(
      width: mq.size.width * 0.6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: mq.size.width * 0.40,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(name,
                      maxLines: 1,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                          fontSize: 12, fontWeight: FontWeight.w500)),
                ),
              ],
            ),
          ),
          // SizedBox(height: 5),
          Container(
            padding: EdgeInsets.symmetric(vertical: 0),
            child: Text(
              course,
              style: GoogleFonts.poppins(
                fontSize: 10,
              ),
            ),
          ),
          Container(
            height: 30,
            width: mq.size.width * 0.7,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: <Widget>[
                      Image.network(
                        flag,
                        height: 10,
                        width: 17,
                      ),
                      SizedBox(width: 5),
                      Container(
                        width: mq.size.width * 0.30,
                        child: Text(
                          city,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: [
                    Image.asset(
                      'assets/clock.png',
                      height: 10,
                      width: 10,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      width: mq.size.width * 0.1,
                      child: Text(
                        duration,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: GoogleFonts.poppins(fontSize: 8),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () async {
                          print('object');
                          var link =
                              await DynamicLinkService.createDynamicLink(id);
                          Dialogs.shareImage(name, image, '$link');
                        },
                        child: Image.asset(
                          'assets/share.png',
                          height: 14.13,
                          width: 13.88,
                        ),
                      ),
                      SizedBox(
                        width: mq.size.width * 0.03,
                      ),
                      InkWell(
                        onTap: () async {
                          await bookmarkServices.addRemoveBookmark(
                              folderId, context, id, false, true);

                          // await Navigator.pushReplacement(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (_) =>
                          //             VideosList(folderId, 'false')));
                        },
                        child: Image.asset(
                          isBookmark
                              ? 'assets/bookmark.png'
                              : 'assets/saved_videos.png',
                          height: 20,
                          width: 15,
                        ),
                      ),
                      SizedBox(
                        width: mq.size.width * 0.03,
                      ),
                      if (isPurchased == 'false')
                        if (!isPurchasedVideo)
                          isAddedCart
                              ? Stack(
                                  children: [
                                    Image.asset(
                                      'assets/cart_add.png',
                                      height: 20,
                                      width: 28,
                                    ),
                                    new Positioned(
                                        left: 15,
                                        child: Image.asset(
                                          'assets/cart_success.png',
                                          width: 13,
                                          height: 13,
                                        )),
                                  ],
                                )
                              : Stack(
                                  children: [
                                    Image.asset(
                                      'assets/cart_add.png',
                                      height: 20,
                                      width: 28,
                                    ),
                                    new Positioned(
                                        left: 15,
                                        child: Image.asset(
                                          'assets/add_cart.png',
                                          width: 13,
                                          height: 13,
                                        )),
                                  ],
                                ),
                      SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}

//college image widget
Widget buildImage(String data, bool isPurchased, int totalVideos) {
  return Stack(
    children: <Widget>[
      ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.network(
          data,
          height: 105.67,
          width: 160.23,
          fit: BoxFit.fill,
        ),
      ),
      if (isPurchased == false)
        Positioned(
            // top: 60,
            left: 120,
            right: 0,
            bottom: 5,
            child: Image.asset(
              'assets/lock.png',
              width: 20,
              height: 20,
            )),
      if (totalVideos != null)
        Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Image.asset(
              'assets/play_icon.png',
              width: 20,
              height: 20,
            )),
    ],
  );
}
