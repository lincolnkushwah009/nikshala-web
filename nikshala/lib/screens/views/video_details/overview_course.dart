import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OverViewCourse extends StatefulWidget {
  final String title;
  final dynamic data;
  OverViewCourse(this.title, this.data, {Key key}) : super(key: key);
  @override
  _OverViewCourseState createState() => _OverViewCourseState();
}

class _OverViewCourseState extends State<OverViewCourse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: widget.title ?? '',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Degree',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold, fontSize: 12),
              ),
              Text(
                widget.data['degree'],
                style: GoogleFonts.poppins(fontSize: 12),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Course Language',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold, fontSize: 12),
              ),
              Text(
                widget.data['courseLanguage'],
                style: GoogleFonts.poppins(fontSize: 12),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Duration',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold, fontSize: 12),
              ),
              Text(
                widget.data['semesterDuration'] ?? '' + ' Semester',
                style: GoogleFonts.poppins(fontSize: 12),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Starting of semester',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold, fontSize: 12),
              ),
              Text(
                widget.data['beginning'] ?? '',
                style: GoogleFonts.poppins(fontSize: 12),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Deadline',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold, fontSize: 12),
              ),
              Text(
                widget.data['deadline'],
                style: GoogleFonts.poppins(fontSize: 12),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Semester Fee',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold, fontSize: 12),
              ),
              Text(
                widget.data['feeAlong'].toString(),
                style: GoogleFonts.poppins(fontSize: 12),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'City',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold, fontSize: 12),
              ),
              Text(
                widget.data['city'],
                style: GoogleFonts.poppins(fontSize: 12),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Application Via',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold, fontSize: 12),
              ),
              Text(
                widget.data['applicationThrough'],
                style: GoogleFonts.poppins(fontSize: 12),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Course Curriculum',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold, fontSize: 12),
              ),
              Text(
                widget.data['applicationThrough'] == 'null'
                    ? ''
                    : widget.data['applicationThrough'],
                style: GoogleFonts.poppins(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Requirements extends StatefulWidget {
  final String title;
  final dynamic data;
  Requirements(this.title, this.data, {Key key}) : super(key: key);
  @override
  _RequirementsState createState() => _RequirementsState();
}

class _RequirementsState extends State<Requirements> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: widget.title,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Documents Required',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold, fontSize: 12),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                widget.data['documentsRequired'],
                style: GoogleFonts.poppins(fontSize: 12),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Academic admission requirements',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold, fontSize: 12),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                widget.data['academicAdmissionRequirements'],
                style: GoogleFonts.poppins(fontSize: 12),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Language requirements',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold, fontSize: 12),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                widget.data['languageRequirements'],
                style: GoogleFonts.poppins(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Contact extends StatefulWidget {
  final String title;
  final dynamic data;
  Contact(this.title, this.data, {Key key}) : super(key: key);
  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: widget.title,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
