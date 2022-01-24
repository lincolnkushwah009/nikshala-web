import 'package:flutter/material.dart';
import 'package:nikshala/config/config.dart';
import 'package:google_fonts/google_fonts.dart';

class Helper {
  //dialog of filter
  static void showFilterDilalog(context) {
    showModalBottomSheet(
        isDismissible: true,
        isScrollControlled: true,
        context: context,
        builder: (BuildContext bc) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 600,
                  decoration: BoxDecoration(
                      color: AppConfig.dashboardTopColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: Wrap(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ListTile(
                          leading: Icon(
                            Icons.filter_list,
                            color: Colors.black,
                            size: 30,
                          ),
                          title: Text('Filter',
                              style: GoogleFonts.poppins(
                                  fontSize: 20, fontWeight: FontWeight.w500)),
                          trailing: InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Image.asset(
                              'assets/close.png',
                              width: 29.25,
                              height: 29.25,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 1.0,
                        color: Colors.grey,
                      ),
                      //search bar
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 3,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          height: 50,
                          child: ListTile(
                            title: TextField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Keyword search'),
                            ),
                          ),
                        ),
                      ),
                      //buttons of genral and advance filter
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            ButtonTheme(
                              minWidth: 161,
                              height: 50,
                              child: RaisedButton(
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'General',
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.0))),
                                onPressed: () {},
                                color: AppConfig.dashboardBottomColor,
                                textColor: Colors.white,
                              ),
                            ),
                            ButtonTheme(
                              minWidth: 161,
                              height: 50,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.0))),
                                onPressed: () {},
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Advanced',
                                        style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                color: Colors.white,
                                textColor: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                        child: ListTile(
                          leading: Image.asset(
                            'assets/books.png',
                            width: 25.05,
                            height: 17.5,
                          ),
                          title: Text('Course Type',
                              style: GoogleFonts.poppins(
                                  fontSize: 18, fontWeight: FontWeight.w500)),
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                        child: ListTile(
                          leading: Image.asset(
                            'assets/language.png',
                            width: 18.13,
                            height: 21.15,
                          ),
                          title: Text('Course Language',
                              style: GoogleFonts.poppins(
                                  fontSize: 18, fontWeight: FontWeight.w500)),
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                        child: ListTile(
                          leading: Image.asset(
                            'assets/university.png',
                            width: 19.82,
                            height: 18.5,
                          ),
                          title: Text('Institution',
                              style: GoogleFonts.poppins(
                                  fontSize: 18, fontWeight: FontWeight.w500)),
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                        child: ListTile(
                          leading: Image.asset(
                            'assets/library.png',
                            width: 19.33,
                            height: 19.33,
                          ),
                          title: Text('Field of study',
                              style: GoogleFonts.poppins(
                                  fontSize: 18, fontWeight: FontWeight.w500)),
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
