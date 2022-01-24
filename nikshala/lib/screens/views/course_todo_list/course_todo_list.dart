import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nikshala/config/config.dart';
import 'package:nikshala/providers/todo_provider/todo_provider.dart';
import 'package:nikshala/screens/components/dialogs.dart';
import 'package:nikshala/screens/views/course_todo_list/add_notes.dart';
import 'package:nikshala/screens/views/course_todo_list/get_notes.dart';
import 'package:nikshala/screens/views/course_todo_list/todo_list_widget.dart';
import 'package:provider/provider.dart';

class CourseTodoList extends StatefulWidget {
  @override
  _CourseTodoListState createState() => _CourseTodoListState();
}

class _CourseTodoListState extends State<CourseTodoList> {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return Scaffold(
        backgroundColor: AppConfig.dashboardTopColor,
        body: FutureBuilder(
            future:
                Provider.of<TodoProvider>(context, listen: false).getTodoList(),
            builder: (_, snap) {
              if (snap.connectionState == ConnectionState.done &&
                  !snap.hasError) {
                print(snap.data['percentage']);
                return Container(
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
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Icon(Icons.keyboard_backspace_sharp,
                                        color: Colors.white),
                                  ),
                                  SizedBox(
                                    width: mq.size.width / 3.5,
                                  ),
                                  Center(
                                    child: Text(
                                      'Todo List',
                                      style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 25,
                                ),
                                SizedBox(
                                  height: 100.0,
                                  child: Stack(
                                    children: <Widget>[
                                      Center(
                                        child: Container(
                                          width: 80,
                                          height: 80,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 10,
                                            backgroundColor: Colors.lightBlue,
                                            valueColor:
                                                new AlwaysStoppedAnimation<
                                                    Color>(Colors.white),
                                            value: double.parse(
                                                snap.data['percentage']),
                                          ),
                                        ),
                                      ),
                                      snap.data['percentage'] == '0.0'
                                          ? Center(
                                              child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      30, 0, 20, 0),
                                              child: Text(
                                                  (double.parse(snap.data[
                                                                  'percentage']) *
                                                              100)
                                                          .toInt()
                                                          .toString() +
                                                      '%',
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 16,
                                                      color: Colors.white)),
                                            ))
                                          : Center(
                                              child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      22, 0, 20, 0),
                                              child: Text(
                                                  (double.parse(snap.data[
                                                                  'percentage']) *
                                                              100)
                                                          .toInt()
                                                          .toString() +
                                                      '%',
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 16,
                                                      color: Colors.white)),
                                            )),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 25,
                                ),
                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                      text: 'Hey! Check the below tasks.',
                                      style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600)),
                                ])),
                              ],
                            )
                          ],
                        ),
                      ),
                      //list of todos
                      Expanded(
                        child: Container(
                            height: mq.size.height * 0.80,
                            child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                padding: EdgeInsets.all(0),
                                itemCount: snap.data['todos'].length,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, i) {
                                  // print(snap.data['todos'].length - 1);
                                  return GestureDetector(
                                    onTap: () {
                                      if (i != 0 &&
                                          snap.data['todos'][i - 1]['status'] ==
                                              'Pending') {
                                        Dialogs.alert(context, Colors.red,
                                            'Please complete previous Todo sections first');
                                        return;
                                      }
                                      if (snap.data['todos'][i]['status'] ==
                                          'Pending') {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => Documentation(
                                                    snap.data['todos'][i]['id'],
                                                    snap.data['todos'][i]
                                                        ['type'],
                                                    snap.data['todos'][i]
                                                            ['description'] ??
                                                        '')));
                                      } else {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => GetNotes(
                                                    snap.data['todos'][i]['id'],
                                                    snap.data['todos'][i]
                                                        ['type'],
                                                    snap.data['todos'][i]
                                                            ['description'] ??
                                                        '')));
                                      }
                                    },
                                    child: todoListWidget(
                                        mq,
                                        snap.data['todos'][i]['type'],
                                        // 'Documentation',
                                        snap.data['todos'][i]['shortNote'] ??
                                            '',
                                        i + 1,
                                        i,
                                        snap.data['todos'][i]['preStatus'],
                                        snap.data['todos'].length - 1,
                                        snap.data['todos'][i]['status']),
                                  );
                                })),
                      ),
                    ]));
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
