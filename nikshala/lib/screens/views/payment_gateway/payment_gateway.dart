import 'package:flutter/material.dart';
import 'package:nikshala/config/config.dart';
import 'package:nikshala/screens/components/navigation_bar/navigation_bar.dart';
import 'package:nikshala/screens/views/my_cart/my_cart_checkout.dart';
import 'package:nikshala/screens/views/payment_gateway/payment_successful.dart';
import 'package:nikshala/services/cart_services.dart';

import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentGateway extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<PaymentGateway> {
  // static const platform = const MethodChannel("razorpay_flutter");
  Razorpay _razorpay;
  CartServices cartServices = CartServices();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text(''),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    openCheckout();
  }

  //confirmation dialog for exiting the payment gateway
  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (_) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
            ),
            child: AlertDialog(
              backgroundColor: Colors.transparent,
              actions: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Container(
                    color: Colors.white,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                            color: Color.fromRGBO(56, 103, 180, 1),
                            child: Text(
                              'Are You Sure!',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            height: 60,
                            width: 400,
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Center(
                            child: Text(
                              'Click YES to Cancel the payment or\nNO to Continue',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.blue[800]),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ButtonTheme(
                                minWidth: 80.0,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                  color: Theme.of(context).primaryColor,
                                  onPressed: () {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => NavigationBar(0, ''),
                                        ),
                                        (_) => false);
                                    // Navigator.of(context).pop();
                                    // Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'YES',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              ButtonTheme(
                                minWidth: 80.0,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                  color: Colors.red,
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                  child: Text(
                                    'NO',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ) ??
        false;
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    var options = {
      // 'key': 'rzp_tests_1wqMF3meQXSRskR',
      'key': 'rzp_live_Q4KlirPVmblQZE',
      // 'rzp_test_eD2zCKLYr7vBh5',
      'amount': AppConfig.amount * 100,
      'name': 'Nikshala',
      'order_id': AppConfig.orderId,
      // 'description': '',
      'prefill': {'contact': AppConfig.phone, 'email': AppConfig.userEmail},
      'external': {
        'wallets': ['paytm', 'phonepe']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    await cartServices.sendOrderDetails(
        context,
        AppConfig.orderId,
        response.orderId,
        response.paymentId,
        response.signature,
        'SUCCESS',
        '');
    AppConfig.amount = null;
    AppConfig.orderId = null;
    AppConfig.newOrderId = null;
    await Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => PaymentSuccessFul(),
        ),
        (_) => false);
  }

  void _handlePaymentError(PaymentFailureResponse response) async {
    print("faillllllllllll");
    print(response.message.toString());

    await cartServices.sendOrderDetails(context, AppConfig.orderId, '', '', '',
        'CANCELLED', 'Payment processing cancelled by user');
    AppConfig.amount = null;
    AppConfig.orderId = null;
    AppConfig.newOrderId = null;
    // await Dialogs.alert(context, Colors.red, response.message);
    await Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => MyCartCheckout(),
        ),
        (_) => false);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("wallet");
    print(response);
  }
}
