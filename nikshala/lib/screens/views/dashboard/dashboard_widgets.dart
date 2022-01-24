import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nikshala/config/config.dart';

//List of categories
Widget categories(String title, Color color) {
  return Container(
    // width: 100,
    // padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25),
      border: Border.all(color: Colors.grey),
      color: color,
    ),
    child: Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Text(
          title,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
              fontSize: 12,
              color: color == AppConfig.dashboardBottomColor
                  ? Colors.white
                  : Colors.black),
        ),
      ),
    ),
  );
}

//courses list according to categories
Widget coursesListCategoryWise(
    String image, String courseName, String totalVideos) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(10),
        bottomLeft: Radius.circular(10),
        topRight: Radius.circular(10),
        topLeft: Radius.circular(10),
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10),
            topLeft: Radius.circular(10),
          ),
          child: Image.network(
            image,
            height: 100,
            width: 135,
            fit: BoxFit.fill,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Container(
            width: 120,
            child: Column(
              children: [
                RichText(
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(children: [
                      TextSpan(
                          text: '\n$courseName',
                          style: GoogleFonts.lato(
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                    ])),
                Row(
                  children: [
                    Text(
                      '\n$totalVideos',
                      style: GoogleFonts.poppins(
                          color: Colors.black, fontSize: 10),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

//video list with description
Widget myVideoListWithDescription(
    String videoName, String description, Color color1, Color color2) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(colors: [color1, color2])),
    margin: EdgeInsets.all(12),
    height: 100,
    width: 300,
    child: Align(
      alignment: Alignment.centerLeft,
      child: ListTile(
        title: Text(videoName,
            style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w500)),
        subtitle: Text(description,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 12,
            )),
      ),
    ),
  );
}
