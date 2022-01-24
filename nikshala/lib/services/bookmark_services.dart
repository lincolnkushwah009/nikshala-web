import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nikshala/config/config.dart';
import 'package:nikshala/providers/video_provider/video_provider.dart';
import 'package:nikshala/screens/components/dialogs.dart';
import 'package:nikshala/screens/components/navigation_bar/navigation_bar.dart';
import 'package:nikshala/screens/views/video_list/video_list.dart';
import 'package:provider/provider.dart';

class BookmarkServices {
  //delete items from cart function
  Future<void> addRemoveBookmark(String folderId, BuildContext context,
      String fileId, bool isSearch, bool isvideolist) async {
    try {
      await Provider.of<Video>(context, listen: false)
          .addRemoveBookmarkVideo(context, fileId);
      if (isSearch) {
        await Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => NavigationBar(2, null)));
      }
      if (isvideolist) {
        await Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (_) => VideosList(folderId, 'false')));
      }
    } catch (e) {
      Dialogs.alert(context, AppConfig.errorColor, e.toString());
    }
  }
}
