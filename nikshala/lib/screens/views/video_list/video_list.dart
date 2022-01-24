import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nikshala/config/config.dart';
import 'package:nikshala/models/userModel.dart';
import 'package:nikshala/providers/folder_provider/folder_provider.dart';
import 'package:nikshala/providers/user_authentication_provider/user_authentication_provider.dart';
import 'package:nikshala/providers/video_provider/video_provider.dart';
import 'package:nikshala/screens/views/my_cart/my_cart_checkout.dart';
import 'package:nikshala/screens/views/video_details/video_details.dart';
import 'package:nikshala/screens/views/video_library/better_player.dart';
import 'package:nikshala/services/cart_services.dart';
import 'package:provider/provider.dart';
import 'video_list_widgets.dart';
import 'package:nikshala/models/priceModel.dart';
import 'package:intl/intl.dart';

class VideosList extends StatefulWidget {
  final String folderId;
  final String isOrder;
  VideosList(this.folderId, this.isOrder, {Key key}) : super(key: key);

  @override
  _AddToCartCourseState createState() => _AddToCartCourseState();
}

class _AddToCartCourseState extends State<VideosList> {
  CartServices cartServices = CartServices();
  String _selectedPrice = '';
  String defaultPrice = '';

  var folderDetails;
  var priceFuture;

  @override
  void initState() {
    folderDetails = Provider.of<Folder>(context, listen: false)
        .getSubFoldersByFolderId(widget.folderId);
    priceFuture = Provider.of<Video>(context, listen: false)
        .getPriceDetailsByFileId(widget.folderId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("this");
    print(widget.folderId);
    final mq = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: AppConfig.dashboardTopColor,
      body: FutureBuilder(
          future: folderDetails,
          builder: (_, snap) {
            if (snap.connectionState == ConnectionState.done &&
                !snap.hasError) {
              return Container(
                  color: AppConfig.dashboardTopColor,
                  height: mq.size.height,
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
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 10, 0, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Icon(
                                              Icons.keyboard_backspace_sharp,
                                              color: Colors.white),
                                        ),
                                        if (widget.isOrder == 'false')
                                          FutureBuilder(
                                              future: Provider.of<AuthData>(
                                                      context,
                                                      listen: false)
                                                  .getUserProfile(),
                                              builder: (BuildContext context,
                                                  AsyncSnapshot<UserModel>
                                                      snap) {
                                                if (snap.connectionState ==
                                                        ConnectionState.done &&
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
                                                              color:
                                                                  Colors.white,
                                                              height: 37,
                                                            ),
                                                            new Positioned(
                                                                right: 0,
                                                                child:
                                                                    new Container(
                                                                        padding:
                                                                            EdgeInsets.all(
                                                                                4),
                                                                        decoration:
                                                                            new BoxDecoration(
                                                                          color:
                                                                              Colors.white,
                                                                          borderRadius:
                                                                              BorderRadius.circular(25),
                                                                        ),
                                                                        constraints:
                                                                            BoxConstraints(
                                                                          minWidth:
                                                                              23,
                                                                          minHeight:
                                                                              23,
                                                                        ),
                                                                        child:
                                                                            new Text(
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
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: mq.size.height * 0.25,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      snap.data['folderThumbnail']),
                                  fit: BoxFit.fill,
                                )),
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
                            widget.isOrder == 'true'
                                ? Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: ListTile(
                                      title: Text('${snap.data['folderName']}',
                                          maxLines: 2,
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600)),
                                      trailing: Text(
                                          'Package expires on: ${DateFormat.yMMMd().format(DateTime.parse(snap.data['expireDate']))}',
                                          style: GoogleFonts.poppins(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w500)),
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 10, 20, 0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                child: Text(
                                                    snap.data['folderName'],
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    softWrap: true,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(
                                          height: 10,
                                        ),
                                        //dropdown of months with price

                                        if (widget.isOrder == 'false')
                                          FutureBuilder(
                                              future: priceFuture,
                                              builder: (BuildContext context,
                                                  AsyncSnapshot<
                                                          List<PriceModel>>
                                                      snap) {
                                                if (snap.connectionState ==
                                                        ConnectionState.done &&
                                                    !snap.hasError) {
                                                  if (snap.data.isEmpty) {
                                                    return (Text(''));
                                                  }
                                                  defaultPrice =
                                                      snap.data[0].id;

                                                  return Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      Expanded(
                                                          child: Container(
                                                        height: 50,
                                                        child: Theme(
                                                          data:
                                                              Theme.of(context)
                                                                  .copyWith(
                                                            canvasColor:
                                                                Colors.white,
                                                          ),
                                                          child:
                                                              DropdownButtonFormField(
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 15,
                                                            ),
                                                            iconSize: 30,
                                                            decoration: InputDecoration(
                                                                contentPadding:
                                                                    EdgeInsets.symmetric(
                                                                        vertical:
                                                                            2,
                                                                        horizontal:
                                                                            10),
                                                                enabledBorder: OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.all(Radius.circular(
                                                                            8)),
                                                                    borderSide: BorderSide(
                                                                        color: Colors
                                                                            .grey)),
                                                                focusedBorder: OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.all(Radius.circular(
                                                                            8)),
                                                                    borderSide:
                                                                        BorderSide(color: Colors.grey)),
                                                                filled: true,
                                                                fillColor: Colors.white,
                                                                hintText: 'Price',
                                                                hintStyle: TextStyle(color: Colors.grey)),
                                                            value:
                                                                snap.data[0].id,
                                                            onChanged:
                                                                (newValue) {
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
                                                                        //   width:
                                                                        //       10,
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
                                                                          width:
                                                                              mq.size.width * 0.40,
                                                                        ),
                                                                        Text(
                                                                          'Rs.' +
                                                                              e.price.toString(),
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
                                        if (widget.isOrder == 'false')
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 20, 0, 10),
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
                                                            widget.folderId,
                                                            _selectedPrice
                                                                    .isEmpty
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
                            //list of added videos
                            Expanded(
                              child: Container(
                                height: mq.size.height * 0.80,
                                child: ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    itemCount: snap.data['attachFiles'].length,
                                    itemBuilder: (_, i) => GestureDetector(
                                          onTap: () {},
                                          child: GestureDetector(
                                            onTap: () {
                                              if (widget.isOrder == 'true') {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (_) => VideoLibrary(
                                                            snap.data[
                                                                    'attachFiles']
                                                                [i]['fileURL'],
                                                            snap.data[
                                                                    'attachFiles']
                                                                [i]['id'])));
                                              } else {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            VideoDetails(
                                                              snap.data[
                                                                      'attachFiles']
                                                                  [i]['id'],
                                                            )));
                                              }
                                            },
                                            child: Container(
                                              child: Card(
                                                elevation: 1,
                                                margin: EdgeInsets.fromLTRB(
                                                    20, 0, 20, 20),
                                                child: Container(
                                                  width: mq.size.width * 0.6,
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: Column(
                                                    children: <Widget>[
                                                      // SizedBox(height: 5),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          //college image widget
                                                          buildImage(
                                                              '${AppConfig.imageUrl}/media/' +
                                                                  snap.data['attachFiles']
                                                                          [i][
                                                                      'thumbnailImage'],
                                                              snap.data['attachFiles']
                                                                          [i][
                                                                      'isPurchased'] ??
                                                                  '',
                                                              1),
                                                          SizedBox(width: 10),
                                                          //course information widget
                                                          buildCartVideoList(
                                                              context,
                                                              mq,
                                                              snap.data['attachFiles']
                                                                      [i][
                                                                  'isBookedMark'],
                                                              snap.data['attachFiles']
                                                                  [i]['id'],
                                                              snap.data['attachFiles']
                                                                      [i]
                                                                  ['fileName'],
                                                              '${AppConfig.imageUrl}/media/' +
                                                                  snap.data['attachFiles']
                                                                          [i][
                                                                      'thumbnailImage'],
                                                              snap.data['attachFiles']
                                                                  [i]['degree'],
                                                              snap.data['attachFiles'][i]['flagImage'] ==
                                                                      null
                                                                  ? ''
                                                                  : '${AppConfig.imageUrl}/media/' +
                                                                      snap.data['attachFiles'][i]
                                                                          ['flagImage'],
                                                              snap.data['attachFiles'][i]['city'],
                                                              snap.data['attachFiles'][i]['duration'].toString() + ' min',
                                                              snap.data['attachFiles'][i]['isAddedFromCart'],
                                                              widget.isOrder,
                                                              widget.folderId,
                                                              snap.data['attachFiles'][i]['isPurchased'] ?? ''),
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
                            ),
                          ],
                        ),
                      ),
                    ],
                  ));
            }
            if (snap.connectionState == ConnectionState.waiting) {
              return Center(child: Image.asset(AppConfig.loader));
            }
            return Center(
              child: Text('Try Again'),
            );
          }),
    );
  }
}
