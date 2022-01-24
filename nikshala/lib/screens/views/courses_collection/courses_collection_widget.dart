import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget coursesCollectionList(MediaQueryData mq, String image, String folderName,
    String videos, String isFile) {
  //courses colletion list widget
  return Stack(children: <Widget>[
    GestureDetector(
      child: Stack(
        children: [
          Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ], color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      image,
                      fit: BoxFit.fill,
                      height: 80,
                      width: 80,
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text(folderName,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          style: GoogleFonts.poppins(
                              fontSize: 8, fontWeight: FontWeight.w500)),
                      subtitle: isFile != 'false'
                          ? Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/clock.png',
                                    height: 10,
                                    width: 9,
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Container(
                                    width: mq.size.width * 0.11,
                                    child: Text(
                                      isFile,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                      style: GoogleFonts.poppins(fontSize: 8),
                                    ),
                                  )
                                ],
                              ),
                            )
                          : Text(
                              '\n' +
                                  videos +
                                  ' ${int.parse(videos) > 1 ? 'Videos' : 'Video'}',
                              style: GoogleFonts.poppins(
                                fontSize: 8,
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
