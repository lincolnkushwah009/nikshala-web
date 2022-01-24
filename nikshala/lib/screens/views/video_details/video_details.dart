import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nikshala/config/config.dart';
import 'package:nikshala/models/userModel.dart';
import 'package:nikshala/providers/user_authentication_provider/user_authentication_provider.dart';

import 'package:nikshala/providers/video_provider/video_provider.dart';
import 'package:nikshala/screens/views/my_cart/my_cart_checkout.dart';
import 'package:nikshala/screens/views/video_details/overview_course.dart';
import 'package:nikshala/services/cart_services.dart';
import 'package:provider/provider.dart';
import 'package:nikshala/models/priceModel.dart';

class VideoDetails extends StatefulWidget {
  final String videoId;
  VideoDetails(this.videoId, {Key key}) : super(key: key);
  @override
  _VideoDetailsState createState() => _VideoDetailsState();
}

class _VideoDetailsState extends State<VideoDetails> {
  CartServices cartServices = CartServices();
  String _selectedPrice = '';
  String defaultPrice = '';

  var videoDetails;
  var priceDetails;

  @override
  void initState() {
    videoDetails = Provider.of<Video>(context, listen: false)
        .getVideoDetailById(widget.videoId);
    priceDetails = Provider.of<Video>(context, listen: false)
        .getPriceDetailsByFileId(widget.videoId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return Scaffold(
        backgroundColor: AppConfig.dashboardTopColor,
        body: FutureBuilder(
            future: videoDetails,
            builder: (_, snap) {
              if (snap.connectionState == ConnectionState.done &&
                  !snap.hasError) {
                print(widget.videoId);
                return SingleChildScrollView(
                  child: Container(
                      color: AppConfig.dashboardTopColor,
                      height: mq.size.height * 1.2,
                      width: double.infinity,
                      child: Stack(
                        children: <Widget>[
                          //custom app bar
                          Container(
                            height: mq.size.height * 0.42,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  height: mq.size.height * 0.25,
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
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 10, 0, 0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Icon(
                                                  Icons
                                                      .keyboard_backspace_sharp,
                                                  color: Colors.white),
                                            ),
                                            FutureBuilder(
                                                future: Provider.of<AuthData>(
                                                        context,
                                                        listen: false)
                                                    .getUserProfile(),
                                                builder: (BuildContext context,
                                                    AsyncSnapshot<UserModel>
                                                        snap) {
                                                  if (snap.connectionState ==
                                                          ConnectionState
                                                              .done &&
                                                      !snap.hasError) {
                                                    AppConfig.userName =
                                                        snap.data.fullName;
                                                    return Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          20, 50, 20, 0),
                                                      child: InkWell(
                                                        onTap: () async {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (_) =>
                                                                      MyCartCheckout()));
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  0, 0, 0, 50),
                                                          child: Stack(
                                                            children: [
                                                              Image.asset(
                                                                'assets/my_cart.png',
                                                                width: 40,
                                                                color: Colors
                                                                    .white,
                                                                height: 37,
                                                              ),
                                                              new Positioned(
                                                                  right: 0,
                                                                  child: new Container(
                                                                      padding: EdgeInsets.all(4),
                                                                      decoration: new BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        borderRadius:
                                                                            BorderRadius.circular(25),
                                                                      ),
                                                                      constraints: BoxConstraints(
                                                                        minWidth:
                                                                            23,
                                                                        minHeight:
                                                                            23,
                                                                      ),
                                                                      child: new Text(
                                                                        snap.data
                                                                            .cartItem
                                                                            .toString(),
                                                                        style:
                                                                            new TextStyle(
                                                                          color:
                                                                              AppConfig.dashboardBottomColor,
                                                                          fontSize:
                                                                              12,
                                                                        ),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                      ))),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                  if (snap.connectionState ==
                                                      ConnectionState.waiting) {
                                                    return Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    );
                                                  }
                                                  return Center(
                                                    child: Text('Try Again'),
                                                  );
                                                }),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //big image of course

                          Positioned(
                            top: mq.size.height * 0.18,
                            left: 0,
                            right: 0,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: Stack(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: mq.size.height * 0.25,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              '${AppConfig.imageUrl}/media/' +
                                                  snap.data['thumbnailImage']),
                                          fit: BoxFit.fill,
                                        )),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 20, 20),
                                      child: Align(
                                          alignment: Alignment.bottomRight,
                                          child: Image.asset(
                                              snap.data['isPurchased'] == false
                                                  ? 'assets/lock.png'
                                                  : '',
                                              width: 24,
                                              height: 31.5,
                                              color: Colors.white)),
                                    ),
                                  ),
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
                              ),
                            ),
                          ),

                          Positioned(
                            top: mq.size.height * 0.45,
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 10, 20, 0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              child: Text(
                                                  '${snap.data['fileName']},',
                                                  // maxLines: 1,
                                                  // overflow:
                                                  //     TextOverflow.ellipsis,
                                                  // softWrap: true,
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ),
                                          ),
                                        ],
                                      ),

                                      Row(
                                        children: [
                                          Text(snap.data['degree'],
                                              style: GoogleFonts.poppins(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500)),
                                        ],
                                      ),

                                      SizedBox(
                                        height: 10,
                                      ),
                                      //dropdown of months with price
                                      FutureBuilder(
                                          future: priceDetails,
                                          builder: (BuildContext context,
                                              AsyncSnapshot<List<PriceModel>>
                                                  snap) {
                                            if (snap.connectionState ==
                                                    ConnectionState.done &&
                                                !snap.hasError) {
                                              if (snap.data.isEmpty) {
                                                return (Text(''));
                                              }
                                              defaultPrice = snap.data[0].id;
                                              if (snap.data[0].price == 0) {
                                                return Row(
                                                  children: [
                                                    Text('Free',
                                                        style:
                                                            GoogleFonts.poppins(
                                                                color: Colors
                                                                    .green,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 18))
                                                  ],
                                                );
                                              }

                                              return Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Expanded(
                                                      child: Container(
                                                    height: 50,
                                                    child: Theme(
                                                      data: Theme.of(context)
                                                          .copyWith(
                                                        canvasColor:
                                                            Colors.white,
                                                      ),
                                                      child:
                                                          DropdownButtonFormField(
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 15,
                                                        ),
                                                        iconSize: 30,
                                                        decoration: InputDecoration(
                                                            contentPadding:
                                                                EdgeInsets.symmetric(
                                                                    vertical: 2,
                                                                    horizontal:
                                                                        10),
                                                            enabledBorder: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius.all(
                                                                        Radius.circular(
                                                                            8)),
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .grey)),
                                                            focusedBorder: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius.all(
                                                                        Radius.circular(
                                                                            8)),
                                                                borderSide: BorderSide(color: Colors.grey)),
                                                            filled: true,
                                                            fillColor: Colors.white,
                                                            hintText: 'Price',
                                                            hintStyle: TextStyle(color: Colors.grey)),
                                                        value: snap.data[0].id,
                                                        onChanged: (newValue) {
                                                          setState(() {
                                                            _selectedPrice =
                                                                newValue;
                                                          });
                                                        },
                                                        items: snap.data
                                                            .map(
                                                              (e) =>
                                                                  DropdownMenuItem(
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    // SizedBox(
                                                                    //   width: 10,
                                                                    // ),
                                                                    Text(
                                                                      e.months.toString() +
                                                                          " - Month",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            14.0,
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: mq
                                                                              .size
                                                                              .width *
                                                                          0.40,
                                                                    ),
                                                                    Text(
                                                                      'Rs.' +
                                                                          e.price
                                                                              .toString(),
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            14.0,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                value: e.id,
                                                              ),
                                                            )
                                                            .toList(),
                                                      ),
                                                    ),
                                                  )),
                                                ],
                                              );
                                            }
                                            if (snap.connectionState ==
                                                ConnectionState.waiting) {
                                              return Center(
                                                  child: Image.asset(
                                                      AppConfig.loader));
                                            }
                                            return Center(
                                              child: Text('Try Again'),
                                            );
                                          }),

                                      //add to cart button
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 15, 0, 0),
                                        child: Container(
                                          width: 200,
                                          child: FlatButton(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                Radius.circular(10.0),
                                              )),
                                              child: Text(
                                                'Add to Cart',
                                                style: GoogleFonts.poppins(
                                                    fontSize: 14),
                                              ),
                                              textColor: Colors.white,
                                              padding: EdgeInsets.all(16),
                                              onPressed: () async {
                                                await cartServices
                                                    .addItemsToCart(
                                                        context,
                                                        widget.videoId,
                                                        _selectedPrice.isEmpty
                                                            ? defaultPrice
                                                            : _selectedPrice,
                                                        false,
                                                        false);
                                              },
                                              color: AppConfig
                                                  .dashboardBottomColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                //tab controllers
                                Expanded(
                                  child: DefaultTabController(
                                    initialIndex: 0,
                                    length: 3,
                                    child: Scaffold(
                                      appBar: AppBar(
                                        automaticallyImplyLeading: false,
                                        flexibleSpace: Column(
                                          children: [
                                            TabBar(
                                              labelStyle: GoogleFonts.poppins(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12),
                                              indicatorWeight: 10,
                                              labelPadding: EdgeInsets.fromLTRB(
                                                  0,
                                                  mq.size.height * 0.037,
                                                  0,
                                                  0),
                                              indicatorColor: AppConfig
                                                  .dashboardBottomColor,
                                              tabs: [
                                                Tab(
                                                  text: 'OVERVIEW',
                                                ),
                                                Tab(
                                                  text: 'REQUIREMENTS',
                                                ),
                                                Tab(
                                                  text: 'CONTACT',
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        centerTitle: false,
                                      ),
                                      body: TabBarView(
                                        children: [
                                          OverViewCourse(
                                              snap.data['overviewInfo'],
                                              snap.data),
                                          Requirements(
                                              snap.data['requirmentInfo'],
                                              snap.data),
                                          Contact(snap.data['contactInfo'],
                                              snap.data),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                );
              }
              if (snap.connectionState == ConnectionState.waiting) {
                return Center(child: Image.asset(AppConfig.loader));
              }
              return Center(
                child: Text('Try Again'),
              );
            }));
  }
}
