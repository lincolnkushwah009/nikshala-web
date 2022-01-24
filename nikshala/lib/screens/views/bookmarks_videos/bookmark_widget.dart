import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nikshala/config/config.dart';
import 'package:nikshala/models/priceModel.dart';
import 'package:nikshala/providers/video_provider/video_provider.dart';
import 'package:nikshala/screens/components/dialogs.dart';
import 'package:nikshala/screens/views/bookmarks_videos/bookmarks_videos.dart';
import 'package:nikshala/services/bookmark_services.dart';
import 'package:nikshala/services/cart_services.dart';
import 'package:nikshala/services/dynamiclink_service.dart';
import 'package:provider/provider.dart';

BookmarkServices bookmarkServices = BookmarkServices();
Widget bookmarkVideos(
    BuildContext context,
    MediaQueryData mq,
    String id,
    String folderName,
    String fileName,
    String city,
    String duration,
    bool isAddedCart,
    String image) {
  return Flexible(
    child: Container(
      width: mq.size.width * 0.6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(folderName,
                    maxLines: 1,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                        fontSize: 12, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          SizedBox(height: 5),
          Text(
            fileName,
            maxLines: 1,
            style: GoogleFonts.poppins(
              fontSize: 10,
            ),
            overflow: TextOverflow.ellipsis,
            softWrap: true,
          ),
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Text(
                city,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                softWrap: true,
                style: GoogleFonts.poppins(
                  fontSize: 10,
                ),
              ),
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
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: GoogleFonts.poppins(fontSize: 8),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  width: mq.size.width * 0.04,
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () async {
                        var link =
                            await DynamicLinkService.createDynamicLink(id);
                        Dialogs.shareImage(fileName, image, '$link');
                      },
                      child: Image.asset(
                        'assets/share.png',
                        height: 17,
                        width: 14,
                      ),
                    ),
                    SizedBox(
                      width: mq.size.width * 0.03,
                    ),
                    InkWell(
                      onTap: () async {
                        await bookmarkServices.addRemoveBookmark(
                            '', context, id, false, false);
                        await Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => BookMarkVideos()));
                      },
                      child: Image.asset(
                        'assets/bookmark.png',
                        height: 20,
                        width: 15,
                      ),
                    ),
                    SizedBox(
                      width: mq.size.width * 0.03,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (isAddedCart) {
                          return Dialogs.alert(context, Colors.red,
                              'You already added this item in cart');
                        }
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (_) => MyDialog()));
                        confirmation(id, context);
                      },
                      child: Stack(
                        children: [
                          Image.asset(
                            'assets/cart_add.png',
                            height: 22,
                            width: 30,
                          ),
                          new Positioned(
                              left: 17,
                              child: Image.asset(
                                isAddedCart
                                    ? 'assets/cart_success.png'
                                    : 'assets/add_cart.png',
                                width: 13,
                                height: 13,
                              )),
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
Widget buildImageBookmark(String data, bool isPurchase) {
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

CartServices cartServices = CartServices();
String radioItem = '';
String _selectedprice = '';
String defaultPrice = '';
var priceFuture;
List<dynamic> price = [];
void confirmation(String folderId, BuildContext context) async {
  await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        priceFuture = Provider.of<Video>(context, listen: false)
            .getPriceDetailsByFileId(folderId);
        return AlertDialog(
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                height: 400,
                width: 5000,
                child: FutureBuilder(
                    future: priceFuture,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<PriceModel>> snap) {
                      if (snap.connectionState == ConnectionState.done &&
                          !snap.hasError) {
                        if (snap.data.isNotEmpty) {
                          defaultPrice = snap.data[0].id;
                          price = snap.data;
                        }

                        return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Center(
                                  child: Text(
                                'Valid upto',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600, fontSize: 18),
                              )),
                              SizedBox(
                                height: 20,
                              ),
                              snap.data.isNotEmpty
                                  ? Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 10),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15))),
                                        height: 60.0 * price.length,
                                        child: Column(
                                          children: <Widget>[
                                            ...price.map((e) {
                                              // radioItem = snap.data[0].id;
                                              return Column(
                                                children: <Widget>[
                                                  Row(
                                                    children: <Widget>[
                                                      Radio(
                                                          activeColor:
                                                              Colors.black,
                                                          value: e.id,
                                                          groupValue: radioItem
                                                                  .isEmpty
                                                              ? snap.data[0].id
                                                              : radioItem,
                                                          onChanged: (val) {
                                                            setState(() {
                                                              radioItem = val;
                                                              _selectedprice =
                                                                  val;
                                                            });
                                                          }),
                                                      GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            _selectedprice =
                                                                e.id;
                                                          });
                                                        },
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.25,
                                                              child: Text(
                                                                e.months.toString() +
                                                                    " - Months",
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  fontSize:
                                                                      14.0,
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.12,
                                                            ),
                                                            Text(
                                                              'Rs.' +
                                                                  e.price
                                                                      .toString(),
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                fontSize: 14.0,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Container(
                                                    width: double.infinity,
                                                    height: 1.0,
                                                    color: Colors.grey,
                                                  ),
                                                  SizedBox(width: 5),
                                                ],
                                              );
                                            }).toList(),
                                          ],
                                        ),
                                      ),
                                    )
                                  : Text(''),
                              Row(
                                children: [
                                  SizedBox(
                                    height: 50.0,
                                    width: MediaQuery.of(context).size.width *
                                        0.35,
                                    child: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      color: AppConfig.dashboardBottomColor,
                                      onPressed: () async {
                                        await cartServices.addItemsToCart(
                                            context,
                                            folderId,
                                            _selectedprice.isEmpty
                                                ? defaultPrice
                                                : _selectedprice,
                                            true,
                                            false);
                                        // await Navigator.pushReplacement(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (_) =>
                                        //             BookMarkVideos()));
                                      },
                                      child: Row(
                                        children: [
                                          Image.asset('assets/cart_add.png',
                                              width: 17,
                                              height: 21,
                                              color: Colors.white),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            'Add to Cart',
                                            style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.02,
                                  ),
                                  SizedBox(
                                    height: 50.0,
                                    width: MediaQuery.of(context).size.width *
                                        0.25,
                                    child: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          side: BorderSide(color: Colors.grey)),
                                      color: Colors.white,
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            'assets/close.png',
                                            width: 19,
                                            height: 14,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            'Close',
                                            style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ]);
                      }
                      if (snap.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: Image.asset(AppConfig.loader),
                        );
                      }
                      return Center(
                        child: Text('Try Again'),
                      );
                    }),
              );
            },
          ),
        );
      });
}
