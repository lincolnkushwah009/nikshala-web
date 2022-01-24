import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nikshala/models/priceModel.dart';
import 'package:nikshala/providers/video_provider/video_provider.dart';
import 'package:nikshala/screens/components/dialogs.dart';
import 'package:nikshala/screens/components/navigation_bar/navigation_bar.dart';
import 'package:nikshala/screens/views/video_details/video_details.dart';
import 'package:nikshala/screens/views/filters/filters.dart';
import 'package:nikshala/services/bookmark_services.dart';
import 'package:nikshala/services/cart_services.dart';
import 'package:nikshala/services/dynamiclink_service.dart';
import 'package:nikshala/services/network_service.dart';
import 'package:provider/provider.dart';
import 'search_videos_widgets.dart';

import 'package:nikshala/config/config.dart';

// ignore: must_be_immutable
class SearchVideos extends StatefulWidget {
  String text;
  List filtervalues;
  SearchVideos(this.text, this.filtervalues, {Key key}) : super(key: key);
  // rotue name
  static const routeName = 'category-wise-videos';

  @override
  _CategoryWiseVideosState createState() => _CategoryWiseVideosState();
}

class _CategoryWiseVideosState extends State<SearchVideos> {
  CartServices cartServices = CartServices();
  BookmarkServices bookmarkServices = BookmarkServices();
  //search controller
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    searchController.text = widget.text;
    checkInternetWorking(context);
    super.initState();
  }

  var priceFuture;
  List<dynamic> price = [];

  void onChangeUser(String c) {
    setState(() {
      price = price.map((e) {
        if (c == e.id) {
          e.price = true;
        } else {
          e.price = false;
        }
        return e;
      }).toList();
    });
  }

  String radioItem = '';
  String _selectedprice = '';
  String defaultPrice = '';
  void confirmation(String folderId) async {
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
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
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
                                                            groupValue:
                                                                radioItem
                                                                        .isEmpty
                                                                    ? snap
                                                                        .data[0]
                                                                        .id
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
                                                                  style: GoogleFonts
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
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  fontSize:
                                                                      14.0,
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
                                              false,
                                              true);
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
                                            side:
                                                BorderSide(color: Colors.grey)),
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

  Future<bool> _willPopCallback() async {
    return Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => NavigationBar(0, null),
        ),
        (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
          backgroundColor: AppConfig.dashboardTopColor,
          body: Container(
              color: AppConfig.dashboardTopColor,
              height: mq.size.height,
              width: double.infinity,
              child: Stack(
                children: <Widget>[
                  //custom app bar
                  Container(
                    height: mq.size.height * 0.3,
                    decoration: BoxDecoration(
                      color: AppConfig.dashboardBottomColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(
                          20,
                        ),
                        bottomRight: Radius.circular(
                          20,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 0, 20),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => NavigationBar(0, null),
                                      ),
                                      (_) => false);
                                },
                                child: Icon(Icons.keyboard_backspace_sharp,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              //search bar
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                height: 50,
                                width: mq.size.width * 0.8,
                                child: ListTile(
                                  trailing: Icon(Icons.search),
                                  title: TextField(
                                    autofocus: widget.text == null ||
                                            widget.filtervalues != null
                                        ? false
                                        : widget.text.isEmpty ||
                                                widget.filtervalues != null
                                            ? false
                                            : true,
                                    controller: searchController,
                                    onChanged: (value) {
                                      if (searchController.text.length == 0) {
                                        AppConfig.text = null;
                                        widget.text = null;
                                      }
                                      AppConfig.text = searchController.text;
                                      setState(() {
                                        widget.text = value;
                                      });
                                    },
                                    // onSubmitted: (value) {
                                    //   widget.text = value;
                                    // },
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Search'),
                                  ),
                                ),
                              ),
                              Stack(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => FilterScreen()));
                                    },
                                    icon: Icon(
                                      Icons.filter_list_outlined,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                  if (widget.filtervalues != null)
                                    if (widget.filtervalues.isNotEmpty)
                                      new Positioned(
                                          top: 10,
                                          right: 8,
                                          child: new Container(
                                            padding: EdgeInsets.all(4),
                                            decoration: new BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                            ),
                                            constraints: BoxConstraints(
                                              minWidth: 15,
                                              minHeight: 15,
                                            ),
                                          )),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  //List of videos
                  FutureBuilder(
                      future: Provider.of<Video>(context, listen: false)
                          .getAllVideosOnSearch(
                              widget.text ?? '', widget.filtervalues),
                      builder: (_, snap) {
                        if (snap.connectionState == ConnectionState.done &&
                            !snap.hasError) {
                          print(snap.data);
                          print("fill");
                          print(widget.filtervalues);
                          if (snap.data.isEmpty) {
                            return Positioned(
                                top: mq.size.height * 0.60,
                                left: 0,
                                right: 0,
                                child: Center(child: Text('No result found')));
                          }
                          return Positioned.fill(
                            top: mq.size.height * 0.20,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: mq.size.height * 0.80,
                              child: ListView.builder(
                                  // physics: BouncingScrollPhysics(),
                                  itemCount: snap.data.length,
                                  itemBuilder: (_, i) => GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) => VideoDetails(
                                                        snap.data[i]['id'],
                                                      )));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 10, 10, 0),
                                          child: Container(
                                            child: Card(
                                              child: Container(
                                                width: mq.size.width * 0.6,
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        5, 0, 0, 0),
                                                child: Column(
                                                  children: <Widget>[
                                                    SizedBox(height: 5),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        //college image widget
                                                        buildImageVideo(
                                                            '${AppConfig.imageUrl}/media/${snap.data[i]['thumbnailImage']}',
                                                            snap.data[i][
                                                                'isPurchased']),
                                                        SizedBox(width: 10),
                                                        //course information widget
                                                        // buildCourseInformation(
                                                        //     context,
                                                        //     mq,
                                                        //     snap.data[i]['folder']
                                                        //         ['folderName'],
                                                        //     snap.data[i]
                                                        //         ['fileName'],
                                                        //     snap.data[i]['city'],
                                                        //     snap.data[i]
                                                        //         ['duration']),
                                                        Flexible(
                                                          child: Container(
                                                            width:
                                                                mq.size.width *
                                                                    0.6,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: <
                                                                  Widget>[
                                                                Row(
                                                                  children: <
                                                                      Widget>[
                                                                    Expanded(
                                                                      child: Text(
                                                                          snap.data[i]['folder']
                                                                              [
                                                                              'folderName'],
                                                                          maxLines:
                                                                              1,
                                                                          softWrap:
                                                                              true,
                                                                          overflow: TextOverflow
                                                                              .ellipsis,
                                                                          style: GoogleFonts.poppins(
                                                                              fontSize: 12,
                                                                              fontWeight: FontWeight.w600)),
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                    height: 5),
                                                                Text(
                                                                  snap.data[i][
                                                                      'fileName'],
                                                                  maxLines: 1,
                                                                  style: GoogleFonts
                                                                      .poppins(
                                                                    fontSize:
                                                                        10,
                                                                  ),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  softWrap:
                                                                      true,
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {},
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.fromLTRB(
                                                                            0,
                                                                            10,
                                                                            0,
                                                                            0),
                                                                    child: Text(
                                                                      '${snap.data[i]['city']}',
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      maxLines:
                                                                          1,
                                                                      softWrap:
                                                                          true,
                                                                      style: GoogleFonts
                                                                          .poppins(
                                                                        fontSize:
                                                                            10,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              0,
                                                                          vertical:
                                                                              10),
                                                                  child: Row(
                                                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    children: <
                                                                        Widget>[
                                                                      Row(
                                                                        children: [
                                                                          Image
                                                                              .asset(
                                                                            'assets/clock.png',
                                                                            height:
                                                                                10,
                                                                            width:
                                                                                10,
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                5,
                                                                          ),
                                                                          Container(
                                                                            width:
                                                                                mq.size.width * 0.12,
                                                                            child:
                                                                                Text(
                                                                              snap.data[i]['duration'].toString() + 'min',
                                                                              maxLines: 1,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              softWrap: true,
                                                                              style: GoogleFonts.poppins(fontSize: 8),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        width: mq.size.width *
                                                                            0.04,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          InkWell(
                                                                            onTap:
                                                                                () async {
                                                                              var link = await DynamicLinkService.createDynamicLink(snap.data[i]['_id']);
                                                                              Dialogs.shareImage(
                                                                                snap.data[i]['fileName'],
                                                                                '${AppConfig.imageUrl}/media/${snap.data[i]['thumbnailImage']}',
                                                                                '$link',
                                                                              );
                                                                            },
                                                                            child:
                                                                                Image.asset(
                                                                              'assets/share.png',
                                                                              height: 17,
                                                                              width: 14,
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                mq.size.width * 0.03,
                                                                          ),
                                                                          InkWell(
                                                                            onTap:
                                                                                () async {
                                                                              await bookmarkServices.addRemoveBookmark('', context, snap.data[i]['id'], true, false);
                                                                            },
                                                                            child:
                                                                                Image.asset(
                                                                              snap.data[i]['isBookedMark'] ? 'assets/bookmark.png' : 'assets/saved_videos.png',
                                                                              height: 20,
                                                                              width: 15,
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                mq.size.width * 0.03,
                                                                          ),
                                                                          if (!snap.data[i]
                                                                              [
                                                                              'isPurchased'])
                                                                            GestureDetector(
                                                                              onTap: () async {
                                                                                if (snap.data[i]['isAddedFromCart'] == true) {
                                                                                  return Dialogs.alert(context, Colors.red, 'You already added this item in cart');
                                                                                }
                                                                                if (snap.data[i]['totalPrice'] == 0) {
                                                                                  await cartServices.addItemsToCart(context, snap.data[i]['id'], snap.data[i]['monthlyPrices'][0]['id'], false, true);
                                                                                  return;
                                                                                }

                                                                                // Navigator.push(context,
                                                                                //     MaterialPageRoute(builder: (_) => MyDialog()));
                                                                                confirmation(snap.data[i]['id']);
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
                                                                                        snap.data[i]['isAddedFromCart'] == true ? 'assets/cart_success.png' : 'assets/add_cart.png',
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
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )),
                            ),
                          );
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
                ],
              ))),
    );
  }
}
