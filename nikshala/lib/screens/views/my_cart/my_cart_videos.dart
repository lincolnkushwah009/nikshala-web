import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nikshala/config/config.dart';
import 'package:nikshala/screens/components/navigation_bar/navigation_bar.dart';

class MyCartVideos extends StatefulWidget {
  @override
  _MyCartVideosState createState() => _MyCartVideosState();
}

class _MyCartVideosState extends State<MyCartVideos> {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return Scaffold(
        backgroundColor: AppConfig.dashboardTopColor,
        body: Container(
            color: AppConfig.dashboardTopColor,
            height: mq.size.height,
            width: double.infinity,
            child: Column(children: <Widget>[
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
                      padding: const EdgeInsets.fromLTRB(30, 20, 0, 20),
                      child: Row(
                        children: [
                          Icon(Icons.keyboard_backspace_sharp,
                              color: Colors.white),
                          SizedBox(
                            width: mq.size.width / 3.5,
                          ),
                          Center(
                            child: Text(
                              'My Cart',
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        //search bar
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          height: 50,
                          width: mq.size.width * 0.9,
                          child: ListTile(
                            trailing: Icon(Icons.search),
                            title: TextField(
                              decoration: InputDecoration(
                                  border: InputBorder.none, hintText: 'Search'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              //courses colletion list in gridview
              Expanded(
                child: GridView.builder(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 5 / 6,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 20,
                  ),
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    //courses colletion list widget
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => NavigationBar(7, null)));
                      },
                      // child: mycartVideosList()
                    );
                  },
                ),
              )
            ])));
  }
}
