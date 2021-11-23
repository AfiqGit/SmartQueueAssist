import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SuggestionTimeController extends StatefulWidget {

  String days;
  SuggestionTimeController({this.days});

  @override
  _SuggestionTimeControllerState createState() => _SuggestionTimeControllerState();
}

class _SuggestionTimeControllerState extends State<SuggestionTimeController> {


  @override
  Widget build(BuildContext context) {
    String day;
    day=widget.days;

    return buildBody(context, day);
  }

  // void getData() {
    
  // }

  Widget buildBody(BuildContext context, day) {

    String pathName;
    List<String> totalTime= [];
    final timeMap= totalTime.asMap();
    String currentTime;
    List<int> numOfPatient= [];
    final patientMap= numOfPatient.asMap();
    int totalPatient;

    if(day == 'Sunday'){
      pathName='time_forecast/Sunday/time';
    }
    else if(day == 'Tuesday'){
      pathName='time_forecast/Tuesday/time';
    }
    else if(day == 'Wednesday'){
      pathName='time_forecast/Wednesday/time';
    }
    else if(day == 'Thursday'){
      pathName='time_forecast/Thursday/time';
    }
    else if(day == 'Friday'){
      pathName='time_forecast/Friday/time';
    }
    else if(day == 'Saturday'){
      pathName='time_forecast/Saturday/time';
    }
    else{
      pathName='time_forecast/Monday/time';
    }

    // Firestore.instance
    //     .collection(pathName)
    //     .getDocuments()
    //     .then((QuerySnapshot snapshot) {
    //   snapshot.documents.forEach((f) => print('${f.data}}'));
    // });
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection(pathName).snapshots(),
      builder: (context, snapshot){
        if(!snapshot.hasData){
          return Container(
                  height: 10,
                  width: 10,
                  padding: EdgeInsets.all(100),
                  child: CircularProgressIndicator(
                    strokeWidth: 10.0,
                    valueColor : AlwaysStoppedAnimation(Colors.pink[900]),
                  ),
                );
        }
        else{
          totalTime.clear();
          numOfPatient.clear();
          for(int i= 0; i < 11; i++) {
            currentTime = snapshot.data.documents[i].data['currentTime'];
            totalPatient = snapshot.data.documents[i].data['totalPatient'];
            totalTime.add(currentTime);
            numOfPatient.add(totalPatient);
          }
          // totalPatient = snapshot.data.documents[2].data['totalPatient'];
          // print(numOfPatient);
          return buildSuggestionTime(context, totalTime, numOfPatient, timeMap.length, patientMap.length);
       }
      }
    );
  }

  Widget buildSuggestionTime(context, timeMap, patientMap, lengthTime, lengthPatient){

    int i, min, j, temp;
    String temp2;
    for (i = 0; i < lengthPatient; i++) {
      min = i;
      for (j = i + 1; j < lengthPatient; j++){
        if (patientMap[j] < patientMap[min])
          min = j;
      }
      temp = patientMap[i];
      patientMap[i]= patientMap[min];
      patientMap[min] = temp;

      temp2= timeMap[i];
      timeMap[i]= timeMap[min];
      timeMap[min]= temp2;
   }

    return Column(
      children: <Widget>[
      Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          timeMap[0],
          style: TextStyle(
            fontSize: 20.0,
            fontFamily: 'Oxygen',
            color: Colors.white,
          ),
        ),
        Text(
          patientMap[0].toString(),
          style: TextStyle(
            fontSize: 20.0,
            fontFamily: 'Oxygen',
            color: Colors.white,
          ),
        ),
      ],
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
           timeMap[1],
          style: TextStyle(
            fontSize: 20.0,
            fontFamily: 'Oxygen',
            color: Colors.white,
          ),
        ),
        Text(
          patientMap[1].toString(),
          style: TextStyle(
            fontSize: 20.0,
            fontFamily: 'Oxygen',
            color: Colors.white,
          ),
        ),
      ],
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
           timeMap[2],
          style: TextStyle(
            fontSize: 20.0,
            fontFamily: 'Oxygen',
            color: Colors.white,
          ),
        ),
        Text(
          patientMap[2].toString(),
          style: TextStyle(
            fontSize: 20.0,
            fontFamily: 'Oxygen',
            color: Colors.white,
          ),
        ),
      ],
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
           timeMap[3],
          style: TextStyle(
            fontSize: 20.0,
            fontFamily: 'Oxygen',
            color: Colors.white,
          ),
        ),
        Text(
          patientMap[3].toString(),
          style: TextStyle(
            fontSize: 20.0,
            fontFamily: 'Oxygen',
            color: Colors.white,
          ),
        ),
      ],
    )
      ],
    );
  }
}