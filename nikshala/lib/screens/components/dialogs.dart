import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:nikshala/services/cart_services.dart';
// import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:share/share.dart';

CartServices cartServices = CartServices();

class Dialogs extends StatelessWidget {
  static Future<void> shareImage(String name, String file, String link) async {
    try {
      print('object33');
      var request = await HttpClient().getUrl(Uri.parse(file));
      var response = await request.close();
      Uint8List bytes = await consolidateHttpClientResponseBytes(response);
      // await Share.shareFiles([file]);
      // await Share.file(name, 'file.jpg', bytes, 'image/jpg', text: data);
      if (Platform.isAndroid) {
        var response = await get(file);
        final documentDirectory = (await getExternalStorageDirectory()).path;
        File imgFile = new File('$documentDirectory/flutter.png');
        imgFile.writeAsBytesSync(response.bodyBytes);

        Share.shareFiles(
          ['$documentDirectory/flutter.png'],
          subject: 'Share nikshala videos',
          text: '$name\nBuy your video from this link👇. \n$link',
        );
      } else {
        Share.share(
          'Hey! Checkout the Share Files repo',
          subject: 'URL conversion + Share',
        );
      }
    } catch (e) {
      print('error: $e');
    }
  }

  // alert dialog for showing messages
  static Future<void> alert(BuildContext context, Color color, String msg,
      {String title}) {
    if (context == null) {
      return null;
    }
    return showDialog(
      context: context,
      builder: (_) => Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: Center(
                  child: Text(
                'Alert',
                style: GoogleFonts.poppins(
                    fontSize: 24, fontWeight: FontWeight.w600),
              )),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      color != Colors.green
                          //if error message than this pops up
                          ? Container(
                              width: 250,
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 2.0),
                                          child: Icon(
                                            Icons.info_outline,
                                            color: color,
                                            size: 18,
                                          )),
                                    ),
                                    TextSpan(
                                      text: msg,
                                      style: GoogleFonts.poppins(
                                          fontSize: 18, color: color),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          //if success message than this pops up
                          : Container(
                              width: 250,
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: msg,
                                      style: GoogleFonts.poppins(
                                          fontSize: 18, color: color),
                                    ),
                                  ],
                                ),
                              ),
                            )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 1.0,
                        color: Colors.grey,
                      ),
                      //dialog ok button
                      FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child: Text('OK',
                                style: GoogleFonts.poppins(
                                    fontSize: 20, color: Colors.blue)),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  //alert dialog of confirmation
  static Future<void> confirmation(BuildContext context, Color color,
      String msg, String priceId, String folderId,
      {String title}) {
    if (context == null) {
      return null;
    }

    return showDialog(
      context: context,
      builder: (_) => Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.close,
                      size: 30,
                      color: Colors.black,
                    ),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: Center(
                  child: Text(
                'Alert',
                style: GoogleFonts.poppins(
                    fontSize: 24, fontWeight: FontWeight.w600),
              )),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      color != Colors.green
                          //if error message than this pops up
                          ? Container(
                              width: 250,
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 2.0),
                                          child: Icon(
                                            Icons.info_outline,
                                            color: color,
                                            size: 18,
                                          )),
                                    ),
                                    TextSpan(
                                      text: msg,
                                      style: GoogleFonts.poppins(
                                          fontSize: 18, color: color),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          //if success message than this pops up
                          : Container(
                              width: 250,
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: msg,
                                      style: GoogleFonts.poppins(
                                          fontSize: 18, color: color),
                                    ),
                                  ],
                                ),
                              ),
                            )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 1.0,
                        color: Colors.grey,
                      ),
                      //Confirm button
                      FlatButton(
                          onPressed: () async {
                            await cartServices.deleteAndAddFolder(
                                context, folderId, priceId);
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child: Text('Confirm',
                                style: GoogleFonts.poppins(
                                    fontSize: 20, color: Colors.blue)),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return null;
  }
}
