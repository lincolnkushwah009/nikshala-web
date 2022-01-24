import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget mycartVideosList(
    MediaQueryData mq, String image, String folderName, String totalVideos) {
  //courses list widget
  return Stack(children: <Widget>[
    GestureDetector(
      child: Stack(
        children: [
          Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      image,
                      fit: BoxFit.cover,
                      height: mq.size.height * 0.15,
                      // width: 182,
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text(folderName,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          style: GoogleFonts.poppins(
                              fontSize: 14, fontWeight: FontWeight.w500)),
                      subtitle: Text(totalVideos,
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                          )),
                    ),
                  ),
                ],
              )),
        ],
      ),
    ),
  ]);
}
