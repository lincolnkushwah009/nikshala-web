import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nikshala/services/cart_services.dart';

//course information widget
CartServices cartServices = CartServices();
Widget buildCheckoutCourses(
    BuildContext context,
    String fileId,
    MediaQueryData mq,
    String courseName,
    String degree,
    int totalVideos,
    String folderPrice) {
  return Flexible(
    child: Container(
      width: mq.size.width * 0.6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Container(
                        width: mq.size.width * 0.35,
                        child: Text(courseName + ',',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            softWrap: true,
                            style: GoogleFonts.poppins(
                                fontSize: 12, fontWeight: FontWeight.w600)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 20, 0),
                      child: GestureDetector(
                        onTap: () async {
                          await cartServices.deleteItemsFromCart(
                              context, fileId);
                        },
                        child: Image.asset(
                          'assets/delete.png',
                          height: 21.17,
                          width: 17.2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: mq.size.width * 0.35,
                child: Text(
                  degree ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: GoogleFonts.poppins(fontSize: 10),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 20, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  totalVideos == null
                      ? ''
                      : totalVideos.toString() == '1'
                          ? '${totalVideos.toString()} video'
                          : '${totalVideos.toString()} videos',
                  style: GoogleFonts.poppins(fontSize: 10),
                ),
                Text(
                  'Rs. $folderPrice',
                  style: GoogleFonts.poppins(
                      fontSize: 12, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

//image widget
Widget buildImage(String data, int totalVideos) {
  return Stack(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Image.network(
            data,
            height: 85,
            width: 160,
            fit: BoxFit.fill,
          ),
        ),
      ),
      if (totalVideos == null)
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
