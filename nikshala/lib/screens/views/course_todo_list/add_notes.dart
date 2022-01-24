import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nikshala/config/config.dart';
import 'package:nikshala/services/todo_service.dart';

class Documentation extends StatefulWidget {
  //note id
  final String noteId;
  //note title
  final String title;
  final String description;
  Documentation(this.noteId, this.title, this.description, {Key key})
      : super(key: key);
  // rotue name
  static const routeName = 'documentation';

  @override
  _DocumentationState createState() => _DocumentationState();
}

class _DocumentationState extends State<Documentation> {
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
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Card(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextField(
                          controller: notes,
                          maxLines: 20,
                          decoration:
                              InputDecoration.collapsed(hintText: "Type here"),
                        ),
                      ),
                    ),
                  ),

                  //submit button
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                    child: Container(
                      width: mq.size.width / 1.5,
                      child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          )),
                          child: Text(
                            'Done',
                            style: GoogleFonts.poppins(fontSize: 14),
                          ),
                          textColor: Colors.white,
                          padding: EdgeInsets.all(16),
                          onPressed: () async {
                            //add notes
                            await todoServices.addTodoNotes(
                                context, widget.noteId, notes.text);
                          },
                          color: AppConfig.dashboardBottomColor),
                    ),
                  ),
                ],
              )),
        ));
  }
}
