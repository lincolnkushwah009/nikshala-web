import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nikshala/config/config.dart';
import 'package:nikshala/screens/components/dialogs.dart';
import 'package:nikshala/services/dynamiclink_service.dart';

//course information widget
Widget buildCourseInformation(
    BuildContext context,
    MediaQueryData mq,
    String videoName,
    String degree,
    String city,
    String duration,
    String image,
    String id) {
  return Flexible(
    child: Container(
      width: mq.size.width * 0.6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: mq.size.width * 0.40,
                child: Text(videoName,
                    style: GoogleFonts.poppins(
                        fontSize: 12, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          SizedBox(height: 5),
          Container(
            width: mq.size.width * 0.40,
            child: Text(
              degree,
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
                      Container(
                        width: 200,
                        child: Text(
                          city,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
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
          Container(
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      width: mq.size.width * 0.12,
                      child: Text(
                        duration,
                        style: GoogleFonts.poppins(fontSize: 8),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  width: mq.size.width * 0.06,
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () async {
                        var link =
                            await DynamicLinkService.createDynamicLink(id);
                        Dialogs.shareImage(videoName, image, '$link');
                      },
                      child: Image.asset(
                        'assets/share.png',
                        height: 17,
                        width: 14,
                      ),
                    ),
                    SizedBox(
                      width: mq.size.width * 0.06,
                    ),
                    Image.asset(
                      'assets/saved_videos.png',
                      height: 17,
                      width: 13,
                    ),
                    SizedBox(
                      width: mq.size.width * 0.06,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Stack(
                        children: [
                          new Positioned(
                              left: 10,
                              child: Icon(
                                Icons.add_circle,
                                size: 14,
                                color: AppConfig.dashboardBottomColor,
                              )),
                          Image.asset(
                            'assets/cart_add.png',
                            height: 17,
                            width: 25,
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}

//image widget
Widget buildImageVideo(String data, bool isPurchase) {
  return Stack(
    children: <Widget>[
      ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.network(
          data,
          height: 105,
          width: 160,
          fit: BoxFit.cover,
        ),
      ),
      if (isPurchase == false)
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
    ],
  );
}
