import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nikshala/screens/components/dialogs.dart';

bool internetWorking = true;
checkInternetWorking(BuildContext context) async {
  var res = '';
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      res = 'connected';
      internetWorking = true;
    }
  } on SocketException catch (_) {
    res = 'not connected';
    internetWorking = false;
    Dialogs.alert(context, Colors.red,
        'Internet is not working, please check your connectivity.');
    return;
  }
  return res;
}
