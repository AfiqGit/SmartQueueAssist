import 'package:clip_shadow/clip_shadow.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:smart_queue_assist/Animations/custom_clipper.dart';
import 'package:smart_queue_assist/Controller/suggestion_time_controller.dart';
import 'package:smart_queue_assist/Controller/time_forecast_controller.dart';



class TimePrediction extends StatefulWidget {
  @override
  _TimePredictionState createState() => _TimePredictionState();
}

List<String> day= ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];

class _TimePredictionState extends State<TimePrediction> {

  String dropdownValue= 'Monday';
  String days;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
        ),
        ClipShadow(
            clipper: CustomAppBar(),
            boxShadow: [
                  BoxShadow(
                    offset: Offset(0.0, 0.0),
                    blurRadius: 10.0,
                    spreadRadius: 15.0,
                    color: Color.fromRGBO(196, 196, 196, 1),
                  )
                ],
            child: Container(
              height: MediaQuery.of(context).size.height*.35,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFde6262),
                    Color(0xFFffb88c),
                  ]
                ),
              )
            )  
          ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            elevation: 0.0,
            title: Text(
              'Time Forecast',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 23.5,
                color: Colors.white
              ),
            ),
          ),
          body: Column(
              children: <Widget>[
                SizedBox(height:5.0),
                Text(
                  'See the best time to visit the place',
                  style: TextStyle(
                  //fontWeight: FontWeight.w200,
                  fontSize: 17.5,
                  color: Colors.white
                ),
                ),
                Divider(
                  color: Colors.white,
                  indent: 100.0,
                  endIndent: 100.0,
                  thickness: 2.5,
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Day : ',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'Oxygen',
                        color: Colors.white,
                      ),
                    ),
                    Column(
                      children:<Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 7, right: 7, bottom: 0),
                          decoration: BoxDecoration(
                            color: Color(0xFFe17272),
                            borderRadius: BorderRadius.circular(7),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 7.0, // soften the shadow
                                spreadRadius: 1.0, //extend the shadow
                                offset: Offset(
                                  2.0, // Move to right 10  horizontally
                                  2.0, // Move to bottom 10 Vertically
                                ),
                              )
                            ],
                          ),
                          child: Theme(
                            data: ThemeData(
                              canvasColor: Color(0xFFe17272),
                            ),
                            child: Row(
                              children: <Widget>[
                                DropdownButton<String>(
                                  value: dropdownValue,
                                  icon: Icon(
                                    MdiIcons.calendarMonth,
                                    color: Colors.white,
                                  ),
                                  iconSize: 18,
                                  elevation: 6,
                                  //dropdownColor: Colors.pink,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontFamily: 'Oxygen',
                                    color: Colors.white,
                                  ),
                                  onChanged: (String newValue) {
                                    setState(() {
                                      dropdownValue = newValue;
                                      days= dropdownValue;
                                    });
                                  },
                                  items: <String>['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']
                                    .map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    })
                                    .toList(),
                                )
                              ],
                            ),
                          ),
                          ),
                      ],
                    ),
                  ],
                ),
                  // ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Container(
                      padding: EdgeInsets.only(left: 7.0, right: 7.0),
                      margin: EdgeInsets.only(left: 15.0, right: 15.0),
                      height: MediaQuery.of(context).size.height*0.45,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xFFe17272),
                      boxShadow: [
                        new BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          offset: new Offset(5.0, 5.0),
                          blurRadius: 3.0,
                        )
                      ],
                    ),
                      child: Expanded(
                        child: TimeForecastController(days: days),
                      )
                    ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: Container(
                    margin: EdgeInsets.only(left: 15.0, right: 15.0),
                    height: MediaQuery.of(context).size.height*0.25,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xFFe17272),
                    boxShadow: [
                      new BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        offset: new Offset(5.0, 5.0),
                        blurRadius: 3.0,
                      )
                    ],
                  ),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 8),
                        Text(
                          'Suggested Visiting Time',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 17.0,
                            fontFamily: 'Oxygen',
                            color: Colors.white,
                          ),
                        ),
                        Divider(
                          color: Colors.white,
                          indent: 130.0,
                          endIndent: 130.0,
                          thickness: 2.0,
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                            'Time',
                            style: TextStyle(
                              fontSize: 17.0,
                              fontFamily: 'Oxygen',
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Patient(s)',
                            style: TextStyle(
                              fontSize: 17.0,
                              fontFamily: 'Oxygen',
                              color: Colors.white,
                            ),
                          ),
                          ],
                        ),
                        SuggestionTimeController(days: days),
                      ]
                    ),
                  ),
                ),
              ]
            ),
        )
      ]
    );
  }
}