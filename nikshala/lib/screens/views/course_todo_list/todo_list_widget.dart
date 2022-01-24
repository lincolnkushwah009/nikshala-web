import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'custome_circle.dart';

//todo list widget
Widget todoListWidget(MediaQueryData mq, String title, String description,
    int number, int index, String preStatus, int lastIndex, String status) {
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: Container(
          decoration: BoxDecoration(
            color: status == 'Pending' ? Colors.white : Colors.lightBlue,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
          height: 110,
          width: mq.size.width * 0.80,
          child: Align(
            alignment: Alignment.bottomLeft,
            child: ListTile(
              title: Text(title,
                  style: GoogleFonts.poppins(
                      fontSize: 14, fontWeight: FontWeight.w600)),
              subtitle: Text(description ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 10,
                  )),
            ),
          ),
        ),
      ),
      Column(
        children: [
          // Container(
          //   height: mq.size.height / 17,
          //   width: 2.0,
          //   color: index == 0
          //       ? Colors.transparent
          //       : index == 3
          //           ? Colors.lightBlue
          //           : status == 'Pending'
          //               ? Colors.grey
          //               : Colors.lightBlue,
          // ),

          Center(
            child: Column(
              children: <Widget>[
                Container(
                  height: mq.size.height / 9,
                  width: 2.0,
                  color: index == 0
                      ? Colors.transparent
                      : index == lastIndex + 1
                          ? Colors.transparent
                          : preStatus == 'Complete'
                              ? Colors.lightBlue
                              : status == 'Pending'
                                  ? Colors.grey
                                  : Colors.lightBlue,
                ),
                status == 'Pending' && preStatus == 'Complete'
                    ? Container(
                        width: 25,
                        height: 21,
                        child: CustomPaint(
                          painter: CustomWave(
                              diameter: 22,
                              colorDown: Colors.grey,
                              colorUp: Colors.lightBlue,
                              width: 2),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 5, 5, 0),
                            child: Text(
                              number < 10
                                  ? '0' + number.toString()
                                  : number.toString(),
                              style: new TextStyle(
                                color: Colors.black,
                                fontSize: 8,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      )
                    : Container(
                        padding: EdgeInsets.all(4),
                        decoration: new BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: status == 'Pending'
                                ? Colors.grey
                                : Colors.lightBlue,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 25,
                          minHeight: 25,
                        ),
                        child: new Text(
                          number < 10
                              ? '0' + number.toString()
                              : number.toString(),
                          style: new TextStyle(
                            color: Colors.black,
                            fontSize: 8,
                          ),
                          textAlign: TextAlign.center,
                        )),
                Container(
                  height: mq.size.height / 18,
                  width: 2.0,
                  color: index == lastIndex
                      ? Colors.transparent
                      : status == 'Pending'
                          ? Colors.grey
                          : Colors.lightBlue,
                ),
              ],
            ),
          ),
          // Container(
          //   height: mq.size.height / 200,
          //   width: 2.0,
          //   color: index == 4
          //       ? Colors.transparent
          //       : status == 'Pending'
          //           ? Colors.grey
          //           : Colors.lightBlue,
          // ),
          // Container(
          //   height: mq.size.height / 100,
          //   width: 2.0,
          //   color: index == 4
          //       ? Colors.transparent
          //       : status == 'Pending'
          //           ? Colors.grey
          //           : Colors.lightBlue,
          // ),
        ],
      ),
    ],
  );
}
