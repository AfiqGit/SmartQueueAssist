import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_queue_assist/Model/PatientNumber.dart';

class TimeForeCastController{
  final DateTime time;
  TimeForeCastController({this.time});

  
  insertTime(){
    int weekday = time.weekday;
    int hour = time.hour;
    String pathName;
    String currentHour;
    int totalPatient;

    if(weekday == 1){
      pathName = 'time_forecast/Monday/time';
      if(hour == 8){
        currentHour = '0800';
      }
      else if(hour == 9){
        currentHour = '0900';
      }
      else if(hour == 10){
        currentHour = '1000';
      }
      else if(hour == 11){
        currentHour = '1100';
      }
      else if(hour == 12){
        currentHour = '1200';
      }
      else if(hour == 13){
        currentHour = '1300';
      }
      else if(hour == 14){
        currentHour = '1400';
      }
      else if(hour == 15){
        currentHour = '1500';
      }
      else if(hour == 16){
        currentHour = '1600';
      }
      else if(hour == 17){
        currentHour = '1700';
      }
      else{
        currentHour = '1800';
      }
    }
    else if(weekday == 2){
      pathName = 'time_forecast/Tuesday/time';
      if(hour == 8){
        currentHour = '0800';
      }
      else if(hour == 9){
        currentHour = '0900';
      }
      else if(hour == 10){
        currentHour = '1000';
      }
      else if(hour == 11){
        currentHour = '1100';
      }
      else if(hour == 12){
        currentHour = '1200';
      }
      else if(hour == 13){
        currentHour = '1300';
      }
      else if(hour == 14){
        currentHour = '1400';
      }
      else if(hour == 15){
        currentHour = '1500';
      }
      else if(hour == 16){
        currentHour = '1600';
      }
      else if(hour == 17){
        currentHour = '1700';
      }
      else{
        currentHour = '1800';
      }
    }
    else if(weekday == 3){
      pathName = 'time_forecast/Wednesday/time';
      if(hour == 8){
        currentHour = '0800';
      }
      else if(hour == 9){
        currentHour = '0900';
      }
      else if(hour == 10){
        currentHour = '1000';
      }
      else if(hour == 11){
        currentHour = '1100';
      }
      else if(hour == 12){
        currentHour = '1200';
      }
      else if(hour == 13){
        currentHour = '1300';
      }
      else if(hour == 14){
        currentHour = '1400';
      }
      else if(hour == 15){
        currentHour = '1500';
      }
      else if(hour == 16){
        currentHour = '1600';
      }
      else if(hour == 17){
        currentHour = '1700';
      }
      else{
        currentHour = '1800';
      }
    }
    else if(weekday == 4){
      pathName = 'time_forecast/Thursday/time';
      if(hour == 8){
        currentHour = '0800';
      }
      else if(hour == 9){
        currentHour = '0900';
      }
      else if(hour == 10){
        currentHour = '1000';
      }
      else if(hour == 11){
        currentHour = '1100';
      }
      else if(hour == 12){
        currentHour = '1200';
      }
      else if(hour == 13){
        currentHour = '1300';
      }
      else if(hour == 14){
        currentHour = '1400';
      }
      else if(hour == 15){
        currentHour = '1500';
      }
      else if(hour == 16){
        currentHour = '1600';
      }
      else if(hour == 17){
        currentHour = '1700';
      }
      else{
        currentHour = '1800';
      }
    }
    else if(weekday == 5){
      pathName = 'time_forecast/Friday/time';
      if(hour == 8){
        currentHour = '0800';
      }
      else if(hour == 9){
        currentHour = '0900';
      }
      else if(hour == 10){
        currentHour = '1000';
      }
      else if(hour == 11){
        currentHour = '1100';
      }
      else if(hour == 12){
        currentHour = '1200';
      }
      else if(hour == 13){
        currentHour = '1300';
      }
      else if(hour == 14){
        currentHour = '1400';
      }
      else if(hour == 15){
        currentHour = '1500';
      }
      else if(hour == 16){
        currentHour = '1600';
      }
      else if(hour == 17){
        currentHour = '1700';
      }
      else{
        currentHour = '1800';
      }
    }
    else if(weekday == 6){
      pathName = 'time_forecast/Saturday/time';
      if(hour == 8){
        currentHour = '0800';
      }
      else if(hour == 9){
        currentHour = '0900';
      }
      else if(hour == 10){
        currentHour = '1000';
      }
      else if(hour == 11){
        currentHour = '1100';
      }
      else if(hour == 12){
        currentHour = '1200';
      }
      else if(hour == 13){
        currentHour = '1300';
      }
      else if(hour == 14){
        currentHour = '1400';
      }
      else if(hour == 15){
        currentHour = '1500';
      }
      else if(hour == 16){
        currentHour = '1600';
      }
      else if(hour == 17){
        currentHour = '1700';
      }
      else{
        currentHour = '1800';
      }
    }
    else {
      pathName = 'time_forecast/Sunday/time';
      if(hour == 8){
        currentHour = '0800';
      }
      else if(hour == 9){
        currentHour = '0900';
      }
      else if(hour == 10){
        currentHour = '1000';
      }
      else if(hour == 11){
        currentHour = '1100';
      }
      else if(hour == 12){
        currentHour = '1200';
      }
      else if(hour == 13){
        currentHour = '1300';
      }
      else if(hour == 14){
        currentHour = '1400';
      }
      else if(hour == 15){
        currentHour = '1500';
      }
      else if(hour == 16){
        currentHour = '1600';
      }
      else if(hour == 17){
        currentHour = '1700';
      }
      else{
        currentHour = '1800';
      }
    }

    Firestore.instance.collection(pathName).document(currentHour).updateData({'totalPatient' : FieldValue.increment(1)});
    
    // Firestore.instance.collection(pathName).document(currentHour).get().then((DocumentSnapshot snapshot){
    //   totalPatient = snapshot.data['totalPatient'];
    //   totalPatient
    // });
    
  }
}
class TimeForecastController extends StatefulWidget {

  final String days;

  TimeForecastController({this.days});

  @override
  _TimeForecastControllerState createState() => _TimeForecastControllerState();
}

class _TimeForecastControllerState extends State<TimeForecastController> {

  List<charts.Series<PatientNumber, String>> _seriesBarData;
  List<PatientNumber> myData;
  _generateData(myData){
    _seriesBarData = List<charts.Series<PatientNumber, String>>();
    _seriesBarData.add(
      charts.Series(
        domainFn: (PatientNumber time,_) => time.currentTime.toString(),
        measureFn: (PatientNumber patient,_) => patient.totalPatient,
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.white),
        data: myData,
        id: 'TimeForecast',
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    String day;
    day=widget.days;
    return _buildBody(context, day);
  }

  Widget _buildBody(context, day){
    String pathName;

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
          List<PatientNumber> patients= snapshot.data.documents.map((documentSnapshot)=> PatientNumber.fromMap(documentSnapshot.data)).toList();
          return _buildChart(context, patients);
        }
      }
    );
  }

  Widget _buildChart(BuildContext context, List<PatientNumber> patients){
    myData= patients;
    _generateData(myData);
    return charts.BarChart(
      _seriesBarData,
      animate: true,
      animationDuration: Duration(seconds: 1),
      vertical: true,

      domainAxis: new charts.OrdinalAxisSpec(
        renderSpec: new charts.SmallTickRendererSpec(
          minimumPaddingBetweenLabelsPx: 0,
            // Tick and Label styling here.
            labelStyle: new charts.TextStyleSpec(
              fontSize: 10, // size in Pts.
              color: charts.MaterialPalette.white),

            // Change the line colors to match text color.
            lineStyle: new charts.LineStyleSpec(
              color: charts.MaterialPalette.white))),

      /// Assign a custom style for the measure axis.
      primaryMeasureAxis: new charts.NumericAxisSpec(
        renderSpec: new charts.GridlineRendererSpec(

          // Tick and Label styling here.
          labelStyle: new charts.TextStyleSpec(
            fontSize: 10, // size in Pts.
            color: charts.MaterialPalette.white),

          // Change the line colors to match text color.
          lineStyle: new charts.LineStyleSpec(
            color: charts.MaterialPalette.white))),

      behaviors: [
        
        new charts.ChartTitle('Number of Patient(s)',
            behaviorPosition: charts.BehaviorPosition.top,
            titleOutsideJustification: charts.OutsideJustification.middleDrawArea,
            titleStyleSpec: new charts.TextStyleSpec(
              fontSize: 17, // size in Pts.
              color: charts.MaterialPalette.white
            ),
        ),

        new charts.ChartTitle('Time',
            behaviorPosition: charts.BehaviorPosition.end,
            titleOutsideJustification: charts.OutsideJustification.middleDrawArea,
            titleStyleSpec: new charts.TextStyleSpec(
              fontSize: 17, // size in Pts.
              color: charts.MaterialPalette.white
            ),
        ),
      ],
    );
  }
}