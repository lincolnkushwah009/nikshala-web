import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nikshala/config/config.dart';
import 'package:nikshala/providers/todo_provider/todo_provider.dart';
import 'package:nikshala/services/todo_service.dart';
import 'package:provider/provider.dart';

class GetNotes extends StatefulWidget {
  //note id
  final String noteId;
  final String title;
  final String description;
  GetNotes(this.noteId, this.title, this.description, {Key key})
      : super(key: key);
  // rotue name
  static const routeName = 'get-notes';

  @override
  _GetNotesState createState() => _GetNotesState();
}

class _GetNotesState extends State<GetNotes> {
  //note textfield
  TextEditingController notes = TextEditingController();
  TodoServices todoServices = TodoServices();
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return Scaffold(
        backgroundColor: AppConfig.dashboardTopColor,
        body: SingleChildScrollView(
          child: Container(
              color: AppConfig.dashboardTopColor,
              // height: mq.size.height,
              width: double.infinity,
              child: Column(
                children: <Widget>[
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
                          padding: const EdgeInsets.fromLTRB(30, 20, 0, 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(Icons.keyboard_backspace_sharp,
                                    color: Colors.white),
                              ),
                              Center(
                                child: Container(
                                  width: mq.size.width * 0.55,
                                  child: Text(
                                    widget.title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                    style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              SizedBox(width: mq.size.width * 0.10)
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                          child: Text(widget.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                  fontSize: 14, color: Colors.white)),
                        )
                      ],
                    ),
                  ),
                  //notes textfield
                  FutureBuilder(
                      future: Provider.of<TodoProvider>(context, listen: false)
                          .getTodoDetails(widget.noteId),
                      builder: (_, snap) {
                        print(snap.data);
                        if (snap.connectionState == ConnectionState.done &&
                            !snap.hasError) {
                          return Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              height: mq.size.height * 0.60,
                              width: mq.size.width * 0.90,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SingleChildScrollView(
                                  child: Text(
                                    snap.data['notes'],
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                        if (snap.connectionState == ConnectionState.waiting) {
                          return Center(child: Image.asset(AppConfig.loader));
                        }
                        return Center(
                          child: Text('Try Again'),
                        );
                      }),
                ],
              )),
        ));
  }
}
