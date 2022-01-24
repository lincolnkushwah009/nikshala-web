import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nikshala/config/config.dart';

int toggleIndex = 0;
int toggleIndex2 = 0;
//general Filters
Widget toggleList(BuildContext context, int index, String name, List checkbox,
    List checkBoxValue, List checkBoxValues) {
  return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
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
            padding: EdgeInsets.all(5),
            height: 45,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  style: BorderStyle.solid, width: 0.5, color: Colors.grey),
            ),
            child: Row(
              children: [
                //icons
                name == 'Course Type'
                    ? Image.asset(
                        'assets/courseType.png',
                        color: toggleIndex == index
                            ? Colors.blue
                            : Colors.grey[600],
                      )
                    : name == 'Field of Study'
                        ? Image.asset(
                            'assets/fieldStudy.png',
                            color: toggleIndex == index
                                ? Colors.blue
                                : Colors.grey[600],
                          )
                        : name == 'Subject'
                            ? Image.asset(
                                'assets/subject.png',
                                color: toggleIndex == index
                                    ? Colors.blue
                                    : Colors.grey[600],
                              )
                            : name == 'Course Language'
                                ? Image.asset(
                                    'assets/languageFilter.png',
                                    color: toggleIndex == index
                                        ? Colors.blue
                                        : Colors.grey[600],
                                  )
                                : name == 'Location'
                                    ? Image.asset(
                                        'assets/location.png',
                                        color: toggleIndex == index
                                            ? Colors.blue
                                            : Colors.grey[600],
                                      )
                                    : name == 'Type of Institution'
                                        ? Image.asset(
                                            'assets/school.png',
                                            color: toggleIndex == index
                                                ? Colors.blue
                                                : Colors.grey[600],
                                          )
                                        : name == 'Name of Institution'
                                            ? Image.asset(
                                                'assets/nameInstitution.png',
                                                color: toggleIndex == index
                                                    ? Colors.blue
                                                    : Colors.grey[600],
                                              )
                                            : Icon(Icons.book_sharp),
                SizedBox(
                  width: 5,
                ),
                //title of checkbox list
                Text(name,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color:
                            toggleIndex == index ? Colors.blue : Colors.black)),
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
                        return Container(
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
                                        print('hello');

                                        checkBoxValue[index][ind] = value;
                                        checkBoxValue[index][ind]
                                            ? checkBoxValues.add({
                                                'title': name,
                                                'values': [checkbox[ind]]
                                              })
                                            : checkBoxValues.removeWhere(
                                                (item) =>
                                                    item['values'][0] ==
                                                    checkbox[ind]);
                                        print([checkbox[ind]]);
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
                            )
                          ],
                        ));
                      }),
                )
              : Container(),
        ],
      ),
    );
  });
}

//advanced Filters
Widget toggleList2(BuildContext context, int index, String name, List checkbox,
    List advancedValue, List advancedValues) {
  return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
    return GestureDetector(
      onTap: () {
        setState(() {
          // toggleIndex2 == index ? toggleIndex2 = null :
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
            child: Row(
              children: [
                //icons
                Icon(
                  Icons.book_sharp,
                  size: 20,
                  color: toggleIndex2 == index ? Colors.blue : Colors.grey[600],
                ),
                SizedBox(
                  width: 5,
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
                        return Container(
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
                                        print('hello');

                                        advancedValue[index][ind] = value;
                                        advancedValue[index][ind]
                                            ? advancedValues.add({
                                                'title': name,
                                                'values': [checkbox[ind]]
                                              })
                                            : advancedValues.removeWhere(
                                                (item) =>
                                                    item['values'][0] ==
                                                    checkbox[ind]);
                                        print("valueess");
                                        print(advancedValues);
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
                            )
                          ],
                        ));
                      }),
                )
              : Container(),
        ],
      ),
    );
  });
}
