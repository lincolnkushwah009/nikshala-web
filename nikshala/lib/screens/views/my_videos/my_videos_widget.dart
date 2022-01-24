import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nikshala/screens/components/dialogs.dart';
import 'package:nikshala/services/dynamiclink_service.dart';

//course information widget
Widget buildVideoWidget(MediaQueryData mq, String videoName, String degree,
    String city, String duration, String totalVideo, String image, String id) {
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
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
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
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              style: GoogleFonts.poppins(
                fontSize: 10,
              ),
            ),
          ),
          Container(
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: <Widget>[
                      Container(
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
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Container(
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: mq.size.width * 0.2,
                    child: Row(
                      children: [
                        duration.isNotEmpty
                            ? Image.asset(
                                'assets/clock.png',
                                height: 10,
                                width: 10,
                              )
                            : Text(''),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          duration.isEmpty ? totalVideo : duration,
                          style: GoogleFonts.poppins(fontSize: 8),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: mq.size.width * 0.06,
                  ),
                  InkWell(
                    onTap: () async {
                      var link = await DynamicLinkService.createDynamicLink(id);
                      Dialogs.shareImage(videoName, image, '$link');
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/share.png',
                          height: 17,
                          width: 14,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}

//image widget
Widget buildVideoImage(String data, int totalVideo) {
  return Stack(
    children: <Widget>[
      // Center(child: Image.asset('assets/play_icon.png')),

      ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.network(
          data,
          height: 105,
          width: 160,
          fit: BoxFit.cover,
        ),
      ),
      if (totalVideo == null)
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
