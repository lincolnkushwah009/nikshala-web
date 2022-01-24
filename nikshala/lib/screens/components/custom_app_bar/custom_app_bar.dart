import 'package:flutter/material.dart';
import 'package:nikshala/config/config.dart';
import 'package:nikshala/screens/components/filter_dialog/filter_dialog.dart';

//custom app bar
Widget customAppBar(BuildContext context, MediaQueryData mq, String image,
    String title, String totalVideos) {
  return Container(
    height: mq.size.height * 0.48,
    child: Column(
      children: <Widget>[
        Container(
          height: mq.size.height * 0.35,
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
                padding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.keyboard_backspace_sharp,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
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
                          decoration: InputDecoration(
                              border: InputBorder.none, hintText: 'Search'),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Helper.showFilterDilalog(context);
                      },
                      icon: Icon(
                        Icons.filter_list_outlined,
                        color: Colors.white,
                        size: 30,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
