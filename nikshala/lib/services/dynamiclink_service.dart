import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:nikshala/screens/views/video_details/video_details.dart';

class DynamicLinkService {
  static void initDynamicLinks(context) async {
    // FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
    // dynamicLinks.onLink.listen((dynamicLinkData) async {
    //   final Uri deeeplink = dynamicLinkData.link;
    //   if (deeeplink != null) {
    //     await Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //             builder: (_) => VideoDetails(
    //                   deeeplink.queryParameters['id'],
    //                 )));
    //   }
    // }).onError((error) {
    //   print('onLink error');
    //   print(error.message);
    // });
    FirebaseDynamicLinks.instance.onLink(
        onError: (e) {},
        onSuccess: (PendingDynamicLinkData dynamicLinkData) async {
          final Uri deeeplink = dynamicLinkData.link;
          if (deeeplink != null) {
            await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => VideoDetails(
                          deeeplink.queryParameters['id'],
                        )));
          }
        });
    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    if (data != null) {
      _handleDeepLink(data, context);
    }
  }

  static _handleDeepLink(
      PendingDynamicLinkData data, BuildContext context) async {
    final Uri deeplink = data.link;
    if (deeplink != null) {
      await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => VideoDetails(
                    data.link.queryParameters['id'],
                  )));
    }
  }

  static Future<String> createDynamicLink(String id) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
        uriPrefix: 'http://nikshalalearning.page.link/',
        link: Uri.parse('https://www.nikshala.in/video?id=$id'),
        androidParameters:
            AndroidParameters(packageName: 'com.nikshala.learning'));

    final Uri dynamicLink = await parameters.buildUrl();

    return dynamicLink.toString();
  }
}
