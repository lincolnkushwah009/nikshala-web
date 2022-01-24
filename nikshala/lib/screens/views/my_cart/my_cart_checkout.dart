import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nikshala/config/config.dart';
import 'package:nikshala/providers/cart_provider/cart_provider.dart';
import 'package:nikshala/screens/components/navigation_bar/navigation_bar.dart';
import 'package:nikshala/screens/views/payment_gateway/payment_gateway.dart';
import 'package:nikshala/screens/views/payment_gateway/payment_successful.dart';
import 'dart:io' show Platform;
import 'package:nikshala/screens/views/video_details/video_details.dart';
import 'package:nikshala/screens/views/all_categories/all_categories.dart';
import 'package:nikshala/screens/views/video_list/video_list.dart';
import 'package:nikshala/screens/views/my_cart/my_cart_checkout_widgets.dart';
import 'package:provider/provider.dart';
// import 'package:stripe_payment/stripe_payment.dart';
import 'package:uuid/uuid.dart';
import 'package:pay/pay.dart';

class MyCartCheckout extends StatefulWidget {
  @override
  _MyCartCheckoutState createState() => _MyCartCheckoutState();
}

class _MyCartCheckoutState extends State<MyCartCheckout> {
  //this function is handling back button
  Future<bool> _willPopCallback() async {
    return Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => NavigationBar(0, null),
        ),
        (_) => false);
  }

  void onApplePayResult(paymentResult) async {
    // Send the resulting Apple Pay token to your server / PSP
    print("Apple Pay Payment Done $paymentResult");
    AppConfig.appleDetail = paymentResult.toString();
    AppConfig.orderId = 'apple_order_id_${Uuid().v1()}';
    await cartServices.placeOrder(context);
    await Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => PaymentSuccessFul(),
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
          body: FutureBuilder(
              future:
                  Provider.of<AddCart>(context, listen: false).getItemsInCart(),
              builder: (_, snap) {
                if (snap.connectionState == ConnectionState.done &&
                    !snap.hasError) {
                  return Container(
                      color: AppConfig.dashboardTopColor,
                      height: mq.size.height,
                      width: double.infinity,
                      child: Stack(children: <Widget>[
                        //custom app bar
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
                                    const EdgeInsets.fromLTRB(30, 10, 0, 0),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        _willPopCallback();
                                      },
                                      child: Icon(
                                          Icons.keyboard_backspace_sharp,
                                          color: Colors.white),
                                    ),
                                    SizedBox(
                                      width: mq.size.width / 3.8,
                                    ),
                                    Center(
                                      child: Text(
                                        'My Cart',
                                        style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                AllCategoriesCourses()));
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(
                                        Icons.add_circle_sharp,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                      SizedBox(width: 5),
                                      Text('Videos',
                                          style: GoogleFonts.poppins(
                                              color: Colors.white,
                                              fontSize: 14)),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        //courses colletion list in gridview
                        snap.data['cartItems'].length < 1
                            ? Positioned(
                                top: mq.size.height * 0.50,
                                left: 0,
                                right: 0,
                                child:
                                    Center(child: Text('Your Cart is Empty')))
                            : Positioned(
                                top: mq.size.height * 0.18,
                                left: 0,
                                right: 0,
                                child: Container(
                                  height: mq.size.height * 0.60,
                                  child: ListView.builder(
                                      physics: BouncingScrollPhysics(),
                                      itemCount: snap.data['cartItems'].length,
                                      itemBuilder: (_, i) => GestureDetector(
                                            onTap: () {
                                              snap.data['cartItems'][i]
                                                          ['folderThumbnail'] ==
                                                      null
                                                  ? Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (_) =>
                                                              VideoDetails(
                                                                snap.data[
                                                                        'cartItems']
                                                                    [i]['id'],
                                                              )))
                                                  : Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (_) =>
                                                              VideosList(
                                                                  snap.data[
                                                                          'cartItems']
                                                                      [i]['id'],
                                                                  'false')));
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 10, 10, 0),
                                              child: Container(
                                                child: Card(
                                                  child: Container(
                                                    width: mq.size.width * 0.6,
                                                    padding: const EdgeInsets
                                                        .fromLTRB(5, 0, 0, 0),
                                                    child: Column(
                                                      children: <Widget>[
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            //folder/file image widget
                                                            buildImage(
                                                              snap.data['cartItems']
                                                                              [i]
                                                                          [
                                                                          'folderThumbnail'] !=
                                                                      null
                                                                  ? snap.data['cartItems']
                                                                          [i][
                                                                      'folderThumbnail']
                                                                  : '${AppConfig.imageUrl}/media/' +
                                                                      snap.data['cartItems']
                                                                              [
                                                                              i]
                                                                          [
                                                                          'thumbnailImage'],
                                                              snap.data['cartItems']
                                                                      [i][
                                                                  'totalVideosCount'],
                                                            ),
                                                            SizedBox(width: 10),
                                                            //file information widget
                                                            buildCheckoutCourses(
                                                                context,
                                                                snap.data['cartItems']
                                                                    [i]['id'],
                                                                mq,
                                                                snap.data['cartItems'][i]['folderName'] !=
                                                                        null
                                                                    ? snap.data['cartItems']
                                                                            [i][
                                                                        'folderName']
                                                                    : snap.data['cartItems'][i]
                                                                            ['folder'][
                                                                        'folderName'],
                                                                snap.data['cartItems']
                                                                        [i][
                                                                    'fileName'],
                                                                snap.data['cartItems'][i]
                                                                    ['totalVideosCount'],
                                                                snap.data['cartItems'][i]['selectedMonthPrice'].toString()),
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
                        //Checkout button
                        Positioned(
                          top: mq.size.height * 0.80,
                          left: 0,
                          right: 0,
                          child: Column(
                            children: [
                              Container(
                                height: 1.0,
                                color: Colors.grey[400],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 10, 20, 20),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Total Price',
                                        style:
                                            GoogleFonts.poppins(fontSize: 14),
                                      ),
                                      Text(
                                        'Rs.${snap.data['totalAmount']}',
                                        style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ]),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 20, 20, 10),
                                child: Container(
                                  width: double.infinity,
                                  child: Row(
                                    children: [
                                      snap.data['totalAmount'] == 0
                                          ? Container(
                                              height: 0.0,
                                              width: 0.0,
                                            )
                                          : Platform.isIOS
                                              ? Expanded(
                                                  child: ApplePayButton(
                                                    paymentConfigurationAsset:
                                                        'default_payment_profile_apple_pay.json',
                                                    paymentItems: [
                                                      PaymentItem(
                                                        label: snap.data['cartItems']
                                                                        [0][
                                                                    'folderName'] !=
                                                                null
                                                            ? snap.data['cartItems']
                                                                    [0]
                                                                ['folderName']
                                                            : snap.data['cartItems']
                                                                        [0]
                                                                    ['folder']
                                                                ['folderName'],
                                                        amount: snap
                                                            .data['totalAmount']
                                                            .toString(),
                                                        status:
                                                            PaymentItemStatus
                                                                .final_price,
                                                      )
                                                    ],
                                                    style: ApplePayButtonStyle
                                                        .black,
                                                    type:
                                                        ApplePayButtonType.buy,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 15.0),
                                                    onPaymentResult:
                                                        onApplePayResult,
                                                    onPressed: () {
                                                      AppConfig.isApplePay =
                                                          true;
                                                    },
                                                    loadingIndicator:
                                                        const Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    ),
                                                  ),
                                                )
                                              : Container(
                                                  height: 0.0,
                                                  width: 0.0,
                                                ),
                                      Platform.isIOS
                                          ? SizedBox(
                                              width: 10.0,
                                            )
                                          : Container(height: 0.0, width: 0.0),
                                      Expanded(
                                        child: FlatButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                              Radius.circular(10.0),
                                            )),
                                            child: Text(
                                              'CHECK OUT',
                                              style: GoogleFonts.poppins(
                                                  fontSize: 14),
                                            ),
                                            textColor: Colors.white,
                                            padding: EdgeInsets.all(16),
                                            onPressed: () async {
                                              AppConfig.isApplePay = false;
                                              if (snap.data['totalAmount'] ==
                                                  0) {
                                                AppConfig.orderId =
                                                    new Uuid().v1();
                                                if (true) {
                                                  await cartServices
                                                      .placeOrder(context);
                                                  await Navigator
                                                      .pushAndRemoveUntil(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (_) =>
                                                                PaymentSuccessFul(),
                                                          ),
                                                          (_) => false);
                                                }
                                                return;
                                              }
                                              if (snap.data['cartItems']
                                                      .length >
                                                  0) {
                                                try {
                                                  AppConfig.amount =
                                                      snap.data['totalAmount'];
                                                  var status = await cartServices
                                                      .generateOrderId(
                                                          context,
                                                          snap.data[
                                                              'totalAmount']);
                                                  if (status) {
                                                    await Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (_) =>
                                                                PaymentGateway()));
                                                  }
                                                } catch (e) {}
                                              }
                                            },
                                            color:
                                                snap.data['cartItems'].length <
                                                        1
                                                    ? Colors.grey
                                                    : AppConfig
                                                        .dashboardBottomColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]));
                }
                if (snap.connectionState == ConnectionState.waiting) {
                  return Center(child: Image.asset(AppConfig.loader));
                }
                return Center(
                  child: Text('Try Again'),
                );
              })),
    );
  }
}
