import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nikshala/config/config.dart';
import 'package:nikshala/providers/filters/filter_provider.dart';
import 'package:nikshala/screens/views/filters/filter_widget.dart';
import 'package:nikshala/screens/views/search_videos/search_videos.dart';
import 'package:provider/provider.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = 'filter-screen';
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  var filterFuture;

  //save boolean value for general filter
  List checkBoxValue = [];
  //save list for general filter
  List checkBoxValues = [];
  //save boolean value for advanced filter
  List advancedValue = [];
  //save list for advanced filter
  List advancedValues = [];
  List filtervalues = [];
  bool loading = true;

  //api call
  void apiCall() async {
    filterFuture =
        await Provider.of<FilterProvider>(context, listen: false).getFilters();
    setState(() {
      loading = false;
      print(filterFuture['advanced']);
    });
  }

  @override
  void initState() {
    apiCall();
    super.initState();
  }

  //toggle button
  bool _hasBeenPressed = false;
  //handle back button
  Future<bool> _willPopCallback() async {
    filtervalues = checkBoxValues + advancedValues;
    return Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => SearchVideos(AppConfig.text, null),
        ),
        (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
          backgroundColor: AppConfig.dashboardTopColor,
          body: Container(
              color: AppConfig.dashboardTopColor,
              height: mq.size.height,
              width: double.infinity,
              child: Column(children: <Widget>[
                Container(
                  height: mq.size.height * 0.2,
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
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    _willPopCallback();
                                  },
                                  child: Icon(
                                    Icons.filter_list_outlined,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text('Filter',
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                    ))
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                              child: InkWell(
                                  onTap: () {
                                    _willPopCallback();
                                  },
                                  child:
                                      Icon(Icons.close, color: Colors.white)),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                //general and advanced filter buttons
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ButtonTheme(
                        minWidth: 161,
                        height: 50,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0))),
                          onPressed: () => {
                            setState(() {
                              _hasBeenPressed = !_hasBeenPressed;
                            })
                          },
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'General',
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: !_hasBeenPressed
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          color: !_hasBeenPressed
                              ? AppConfig.dashboardBottomColor
                              : Colors.white,
                          textColor: Colors.black,
                        ),
                      ),
                      ButtonTheme(
                        minWidth: 161,
                        height: 50,
                        child: RaisedButton(
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Advanced',
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: _hasBeenPressed
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0))),
                          onPressed: () => {
                            setState(() {
                              _hasBeenPressed = !_hasBeenPressed;
                            })
                          },
                          color: _hasBeenPressed
                              ? AppConfig.dashboardBottomColor
                              : Colors.white,
                          textColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                //list of filters
                loading
                    ? CircularProgressIndicator()
                    : Expanded(
                        child: ListView.builder(
                            itemCount: !_hasBeenPressed
                                ? filterFuture['general'].length
                                : filterFuture['advanced'].length,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, int index) {
                              if (!_hasBeenPressed) {
                                if (checkBoxValue.isEmpty) {
                                  for (var i = 0;
                                      i < filterFuture['general'].length;
                                      i++) {
                                    checkBoxValue.add(List.generate(
                                        filterFuture['general'][i]['values']
                                            .length,
                                        (i) => false));
                                  }
                                }
                              } else {
                                if (advancedValue.isEmpty) {
                                  for (var i = 0;
                                      i < filterFuture['advanced'].length;
                                      i++) {
                                    advancedValue.add(List.generate(
                                        filterFuture['advanced'][i]['values']
                                            .length,
                                        (i) => false));
                                  }
                                }
                              }
                              return !_hasBeenPressed
                                  ? toggleList(
                                      context,
                                      index,
                                      filterFuture['general'][index]['title'],
                                      filterFuture['general'][index]['values'],
                                    )
                                  : toggleList2(
                                      context,
                                      index,
                                      filterFuture['advanced'][index]['title'],
                                      filterFuture['advanced'][index]['values'],
                                    );
                            }),
                      ),

                //submit and reset buttons
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ButtonTheme(
                        minWidth: 161,
                        height: 50,
                        child: RaisedButton(
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Reset',
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0))),
                          onPressed: () {
                            if (checkBoxValues.isNotEmpty ||
                                advancedValues.isNotEmpty) {
                              filtervalues = checkBoxValues + advancedValues;
                              filtervalues.forEach((element) {
                                if (element['values'].isNotEmpty) {
                                  // checkBoxValue.length = 0;
                                  // advancedValue.length = 0;
                                  // checkBoxValues.length = 0;
                                  // advancedValues.length = 0;
                                  // filtervalues.length = 0;
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => FilterScreen()));
                                }
                              });
                            }
                          },
                          color: Colors.white,
                          textColor: Colors.black,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      ButtonTheme(
                        minWidth: 161,
                        height: 50,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0))),
                          //submit filters
                          onPressed: () {
                            filtervalues = checkBoxValues + advancedValues;
                            var finalFilter = [];
                            if (checkBoxValues.isNotEmpty ||
                                advancedValues.isNotEmpty) {
                              print("checkBoxValues");
                              print(checkBoxValues);
                              filtervalues.forEach((element) {
                                if (element['values'].isNotEmpty) {
                                  finalFilter.add(element);
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => SearchVideos(
                                            AppConfig.text, finalFilter),
                                      ),
                                      (_) => false);
                                  print("finalFilterrr");
                                  print(finalFilter);
                                }
                              });
                            }
                          },
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Done',
                                  style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          color:
                              // checkBoxValues.isEmpty && advancedValues.isEmpty
                              //     ? Colors.grey
                              //     :
                              AppConfig.dashboardBottomColor,
                          textColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ]))),
    );
  }

  //general filters list
  Widget toggleList(
    BuildContext context,
    int index,
    String name,
    List checkbox,
  ) {
    if (checkBoxValues.length < filterFuture['general'].length) {
      checkBoxValues.add({'title': name, 'values': []});
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          // toggleIndex == index ? toggleIndex = null :
          toggleIndex = index;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
            height: 45,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  style: BorderStyle.solid, width: 0.5, color: Colors.grey),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  //icons
                  name == 'Course Type'
                      ? Image.asset(
                          'assets/courseType.png',
                          width: 20,
                          height: 20,
                          color: toggleIndex == index
                              ? Colors.blue
                              : Colors.grey[600],
                        )
                      : name == 'Field of Study'
                          ? Image.asset(
                              'assets/fieldStudy.png',
                              width: 20,
                              height: 20,
                              color: toggleIndex == index
                                  ? Colors.blue
                                  : Colors.grey[600],
                            )
                          : name == 'Subjects'
                              ? Image.asset(
                                  'assets/subject.png',
                                  width: 20,
                                  height: 20,
                                  color: toggleIndex == index
                                      ? Colors.blue
                                      : Colors.grey[600],
                                )
                              : name == 'Course Language'
                                  ? Image.asset(
                                      'assets/languageFilter.png',
                                      width: 20,
                                      height: 20,
                                      color: toggleIndex == index
                                          ? Colors.blue
                                          : Colors.grey[600],
                                    )
                                  : name == 'Location'
                                      ? Image.asset(
                                          'assets/location.png',
                                          width: 20,
                                          height: 20,
                                          color: toggleIndex == index
                                              ? Colors.blue
                                              : Colors.grey[600],
                                        )
                                      : name == 'Type of Institution'
                                          ? Image.asset(
                                              'assets/school.png',
                                              width: 20,
                                              height: 20,
                                              color: toggleIndex == index
                                                  ? Colors.blue
                                                  : Colors.grey[600],
                                            )
                                          : name == 'Name of Institution'
                                              ? Image.asset(
                                                  'assets/nameInstitution.png',
                                                  width: 20,
                                                  height: 20,
                                                  color: toggleIndex == index
                                                      ? Colors.blue
                                                      : Colors.grey[600],
                                                )
                                              : Icon(Icons.book_sharp),
                  SizedBox(
                    width: 15,
                  ),
                  //title of checkbox list
                  Container(
                    child: Text(name,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: toggleIndex == index
                                ? Colors.blue
                                : Colors.black)),
                  ),
                  Spacer(),
                  //add and remove icon
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: toggleIndex == index ? Colors.blue[100] : null),
                    padding: EdgeInsets.all(3),
                    child: Icon(
                      toggleIndex == index ? Icons.remove : Icons.add,
                      color: toggleIndex == index ? Colors.blue : Colors.grey,
                    ),
                  )
                ],
              ),
            ),
          ),
          //checkbox list
          toggleIndex == index
              ? Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding: EdgeInsets.fromLTRB(30, 15, 0, 15),
                  decoration: BoxDecoration(
                      color: AppConfig.dashboardTopColor,
                      border: Border.all(style: BorderStyle.solid, width: 0.2)),
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: checkbox.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int ind) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              checkBoxValue[index][ind]
                                  ? checkBoxValue[index][ind] = false
                                  : checkBoxValue[index][ind] = true;

                              checkBoxValue[index][ind]
                                  ? checkBoxValues.forEach((element) {
                                      element['title'] == name
                                          ? element['values'].add(checkbox[ind])
                                          : null;
                                    })
                                  : checkBoxValues.forEach((element) {
                                      element['title'] == name
                                          ? element['values']
                                              .remove(checkbox[ind])
                                          : null;
                                    });
                            });
                          },
                          child: Container(
                              child: Row(
                            children: [
                              Transform.scale(
                                scale: 0.9,
                                child: SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: Checkbox(
                                      activeColor: Colors.black,
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      value: checkBoxValue[index][ind],
                                      onChanged: (value) {
                                        //checkbox select and unselect
                                        setState(() {
                                          checkBoxValue[index][ind] = value;

                                          checkBoxValue[index][ind]
                                              ? checkBoxValues
                                                  .forEach((element) {
                                                  element['title'] == name
                                                      ? element['values']
                                                          .add(checkbox[ind])
                                                      : null;
                                                })
                                              : checkBoxValues
                                                  .forEach((element) {
                                                  element['title'] == name
                                                      ? element['values']
                                                          .remove(checkbox[ind])
                                                      : null;
                                                });

                                          print("valueess");
                                          print(checkBoxValues);
                                        });
                                      }),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              //checkbox keys name
                              Text(
                                checkbox[ind],
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500, fontSize: 12),
                              ),
                            ],
                          )),
                        );
                      }),
                )
              : Container(),
        ],
      ),
    );
  }

//advanced Filters list
  Widget toggleList2(
    BuildContext context,
    int index,
    String name,
    List checkbox,
  ) {
    if (advancedValues.length < filterFuture['advanced'].length) {
      advancedValues.add({'title': name, 'values': []});
    }
    return GestureDetector(
      onTap: () {
        setState(() {
          toggleIndex2 = index;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(5),
            height: 45,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  style: BorderStyle.solid, width: 0.5, color: Colors.grey),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
              child: Row(
                children: [
                  //icons
                  name == 'Tution Fee'
                      ? Image.asset(
                          'assets/tution_fee.png',
                          width: 20,
                          height: 20,
                          color: toggleIndex2 == index
                              ? Colors.blue
                              : Colors.grey[600],
                        )
                      : name == 'Beginning'
                          ? Image.asset(
                              'assets/beginning.png',
                              width: 20,
                              height: 20,
                              color: toggleIndex2 == index
                                  ? Colors.blue
                                  : Colors.grey[600],
                            )
                          : name == 'Deadline'
                              ? Image.asset(
                                  'assets/deadline.png',
                                  width: 20,
                                  height: 20,
                                  color: toggleIndex2 == index
                                      ? Colors.blue
                                      : Colors.grey[600],
                                )
                              : name == 'Duration'
                                  ? Image.asset(
                                      'assets/duration.png',
                                      width: 20,
                                      height: 20,
                                      color: toggleIndex2 == index
                                          ? Colors.blue
                                          : Colors.grey[600],
                                    )
                                  : name == 'Preperation of Subject Groups' ||
                                          name ==
                                              'Preperation of Degree Programs'
                                      ? Image.asset(
                                          'assets/preparation.png',
                                          width: 20,
                                          height: 20,
                                          // color: toggleIndex == index
                                          //     ? Colors.blue
                                          //     : Colors.white,
                                        )
                                      : name == 'Language Requirments'
                                          ? Image.asset(
                                              'assets/translation.png',
                                              width: 20,
                                              height: 20,
                                              color: toggleIndex2 == index
                                                  ? Colors.blue
                                                  : Colors.grey[600],
                                            )
                                          : name == 'Degree'
                                              ? Image.asset(
                                                  'assets/degree.png',
                                                  width: 20,
                                                  height: 20,
                                                  color: toggleIndex2 == index
                                                      ? Colors.blue
                                                      : Colors.grey[600],
                                                )
                                              : name == 'Special Requirement'
                                                  ? Image.asset(
                                                      'assets/requirement.png',
                                                      width: 20,
                                                      height: 20,
                                                      color: toggleIndex2 ==
                                                              index
                                                          ? Colors.blue
                                                          : Colors.grey[600],
                                                    )
                                                  : name ==
                                                          'Application Process'
                                                      ? Image.asset(
                                                          'assets/process.png',
                                                          width: 20,
                                                          height: 20,
                                                          color: toggleIndex2 ==
                                                                  index
                                                              ? Colors.blue
                                                              : Colors
                                                                  .grey[600],
                                                        )
                                                      : Icon(
                                                          Icons.book_sharp,
                                                          size: 20,
                                                        ),
                  SizedBox(
                    width: 15,
                  ),
                  //title of checkbox list
                  Text(name,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: toggleIndex2 == index
                              ? Colors.blue
                              : Colors.black)),
                  Spacer(),
                  //add and remove icon
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: toggleIndex2 == index ? Colors.blue[100] : null),
                    padding: EdgeInsets.all(3),
                    child: Icon(
                      toggleIndex2 == index ? Icons.remove : Icons.add,
                      color: toggleIndex2 == index ? Colors.blue : Colors.grey,
                    ),
                  )
                ],
              ),
            ),
          ),
          //checkbox list
          toggleIndex2 == index
              ? Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding: EdgeInsets.fromLTRB(30, 15, 0, 15),
                  decoration: BoxDecoration(
                      color: AppConfig.dashboardTopColor,
                      border: Border.all(style: BorderStyle.solid, width: 0.2)),
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: checkbox.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int ind) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              advancedValue[index][ind]
                                  ? advancedValue[index][ind] = false
                                  : advancedValue[index][ind] = true;
                              advancedValue[index][ind]
                                  ? advancedValues.forEach((element) {
                                      element['title'] == name
                                          ? element['values'].add(checkbox[ind])
                                          : null;
                                    })
                                  : advancedValues.forEach((element) {
                                      element['title'] == name
                                          ? element['values']
                                              .remove(checkbox[ind])
                                          : null;
                                    });

                              print("valueess");
                              print(advancedValues);
                            });
                          },
                          child: Container(
                            child: Row(
                              children: [
                                Transform.scale(
                                  scale: 0.9,
                                  child: SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: Checkbox(
                                        activeColor: Colors.black,
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        value: advancedValue[index][ind],
                                        //select and unselect checkbox
                                        onChanged: (value) {
                                          setState(() {
                                            advancedValue[index][ind] = value;
                                            advancedValue[index][ind]
                                                ? advancedValues
                                                    .forEach((element) {
                                                    element['title'] == name
                                                        ? element['values']
                                                            .add(checkbox[ind])
                                                        : null;
                                                  })
                                                : advancedValues
                                                    .forEach((element) {
                                                    element['title'] == name
                                                        ? element['values']
                                                            .remove(
                                                                checkbox[ind])
                                                        : null;
                                                  });
                                          });
                                        }),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                //checkbox keys name
                                Expanded(
                                  child: Text(
                                    checkbox[ind],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                )
              : Container(),
        ],
      ),
    );
  }
}
