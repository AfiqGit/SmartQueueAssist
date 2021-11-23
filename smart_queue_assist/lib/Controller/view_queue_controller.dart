import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewQueueForUserController extends StatefulWidget {
  final int value;
  final String userId;
  ViewQueueForUserController({this.value, this.userId});
  @override
  ViewQueueForUserControllerState createState() => ViewQueueForUserControllerState();
}

class ViewQueueForUserControllerState extends State<ViewQueueForUserController> {

  final CollectionReference userCollection = Firestore.instance.collection('/user');

  final CollectionReference doctorAdmitCollection = Firestore.instance.collection('/queue/doctorInspection/admit');
  final CollectionReference counterDoctorCollection = Firestore.instance.collection('/queue/doctorInspection/counter');

  final CollectionReference medicationAdmitCollection = Firestore.instance.collection('/queue/medication/admit');
  final CollectionReference counterMedicationCollection = Firestore.instance.collection('/queue/medication/counter');

  final CollectionReference paymentAdmitCollection = Firestore.instance.collection('/queue/payment/admit');
  final CollectionReference counterPaymentCollection = Firestore.instance.collection('/queue/payment/counter'); 

  @override
  Widget build(BuildContext context) {
    int value = widget.value;
    String userId = widget.userId;
    if(value == 1) return buildDoctorInspection(context);
    else if(value == 2) return buildMedicationQueue(context);
    else if(value == 3) return buildPaymentQueue(context);
    else if(value ==5) return buildWaitingTime(context);
    else return buildPatientQueueNumber(context, userId);
    
  }

  buildDoctorInspection(BuildContext context){
    return StreamBuilder(
      stream: counterDoctorCollection.document('patientCounter').snapshots(),
      builder: (BuildContext context, snapshot) {
        int counter = snapshot.data['counterValue'];
        try{
          if(counter !=0){
                    return buildDoctorInspectionView(context, counter);
          }
          else {
            print('no data');
            return buildViewDoctorQueue(context, "No Data");
          }
        }
        catch(e){
          return buildViewDoctorQueue(context, "No Data");
        }
        
      }
    );
  }

  buildDoctorInspectionView(BuildContext context, counter){
    counter = counter -1;
    return StreamBuilder(
      stream: doctorAdmitCollection.document(counter.toString()).snapshots(),
      builder: (BuildContext context, snapshot) {
        try{
          if(snapshot.hasData){
            String queueNumber = snapshot.data['queueNumber'];
            return buildViewDoctorQueue(context, queueNumber);
            
          }
          else {
            print('no data');
            return buildViewDoctorQueue(context, "No Data");
          }
        }
        catch(e){
          return buildViewDoctorQueue(context, "No Data");
        }
        
      }
    );
  }

  buildViewDoctorQueue(BuildContext context, queueNumber){
    return  Column(
      children: <Widget>[
        Text(
          'Queue for Doctor Inspection',
          style: TextStyle(
            fontFamily: 'Oxygen',
            fontWeight: FontWeight.bold,
            fontSize: 18.5,
            color: Colors.white
          ),
        ),
        SizedBox(height: 30.0),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Current Queue Number',
                  style: TextStyle(
                  fontFamily: 'Oxygen',
                  fontSize: 20.5,
                  color: Colors.white
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20.0),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '$queueNumber',
                  style: TextStyle(
                  fontFamily: 'Oxanium',
                  fontSize: 80.5,
                  color: Colors.white
                ),
              ),
            ],
          ),
        ),
      ],
      );
  }

  buildMedicationQueue(BuildContext context){
    return StreamBuilder(
      stream: counterMedicationCollection.document('patientCounter').snapshots(),
      builder: (BuildContext context, snapshot) {
        int counter = snapshot.data['counterValue'];
        try{
          if(counter !=0){
            return buildMedicationQueueInfo(context, counter);
          }
          else {
            print('no data');
            return buildMedicationView(context, "No Data");
          }
        }
        catch(e){
          return buildMedicationView(context, "No Data");
        }
        
      }
    );
  }

  buildMedicationQueueInfo(BuildContext context, counter){
    counter = counter -1;
    return StreamBuilder(
      stream: medicationAdmitCollection.document(counter.toString()).snapshots(),
      builder: (BuildContext context, snapshot) {
        try{
          if(snapshot.hasData){
            String queueNumber = snapshot.data['queueNumber'];
            return buildMedicationView(context, queueNumber);
          }
          else {
            print('no data');
            return buildMedicationView(context, "No Data");
          }
        }
        catch(e){
          return buildMedicationView(context, "No Data");
        }
        
      }
    );
  }

  buildMedicationView(BuildContext context, queueNumber){
    return Column(
      children: <Widget>[
        Text(
          'Queue for Medication',
          style: TextStyle(
            fontFamily: 'Oxygen',
            fontWeight: FontWeight.bold,
            fontSize: 18.5,
            color: Colors.white
          ),
        ),
        SizedBox(height: 30.0),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Current Queue Number',
                  style: TextStyle(
                  fontFamily: 'Oxygen',
                  fontSize: 20.5,
                  color: Colors.white
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20.0),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '$queueNumber',
                  style: TextStyle(
                  fontFamily: 'Oxanium',
                  fontSize: 80.5,
                  color: Colors.white
                ),
              ),
            ],
          ),
        ),
      ],
      );
  }

  buildPaymentQueue(BuildContext context){
    return StreamBuilder(
      stream: counterPaymentCollection.document('patientCounter').snapshots(),
      builder: (BuildContext context, snapshot) {
        int counter = snapshot.data['counterValue'];
        try{
          if(counter != 0){
            return buildPaymentQueueInfo(context, counter);
          }
          else {
            print('no data');
            return buildPaymentView(context, "No Data");
          }
        }
        catch(e){
          return buildPaymentView(context, "No Data");
        }
        
      }
    );
  }

  buildPaymentQueueInfo(BuildContext context, counter){
    counter = counter -1;
    return StreamBuilder(
      stream: paymentAdmitCollection.document(counter.toString()).snapshots(),
      builder: (BuildContext context, snapshot) {
        try{
          if(snapshot.hasData){
            String queueNumber = snapshot.data['queueNumber'];
            return buildPaymentView(context, queueNumber);
          }
          else {
            print('no data');
            return buildPaymentView(context, "No Data");
          }
        }
        catch(e){
          return buildPaymentView(context, "No Data");
        }
        
      }
    );
  }

  buildPaymentView(BuildContext context, queueNumber){
    return Column(
      children: <Widget>[
        Text(
          'Queue for Payment',
          style: TextStyle(
            fontFamily: 'Oxygen',
            fontWeight: FontWeight.bold,
            fontSize: 18.5,
            color: Colors.white
          ),
        ),
        SizedBox(height: 30.0),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Current Queue Number',
                  style: TextStyle(
                  fontFamily: 'Oxygen',
                  fontSize: 20.5,
                  color: Colors.white
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20.0),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '$queueNumber',
                  style: TextStyle(
                  fontFamily: 'Oxanium',
                  fontSize: 80.5,
                  color: Colors.white
                ),
              ),
            ],
          ),
        ),
      ],
      );
  }

  buildPatientQueueNumber(BuildContext context, userId){
    print(userId);
    return FutureBuilder(
      future: Firestore.instance.collection('/user').document(userId).get(),
      builder: (BuildContext context, snapshot) {
        if(snapshot.hasData){
          String patientQueue = snapshot.data['queueNumber'];
          return buildPatientQueueNumberView(context, patientQueue);
        }
        else {
          print('no data');
          return buildPatientQueueNumberView(context, "No Data");
        }
      }
    );
  }

  buildPatientQueueNumberView(BuildContext context, patientQueue){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          'Your Queue Number :',
          style: TextStyle(
            fontFamily: 'Oxygen',
            fontSize: 18.5,
            color: Colors.white
          ),
        ),
        Text(
          '$patientQueue',
          style: TextStyle(
            fontFamily: 'Oxanium',
            fontSize: 30.5,
            color: Colors.white
          ),
        ),
      ],
    );
  }

  buildWaitingTime(BuildContext context){
    return StreamBuilder(
      stream: Firestore.instance.collection('/queue/doctorInspection/averageWaitingQueue').document('average').snapshots(),
      builder: (BuildContext context, snapshot) {
        if(snapshot.hasData){
          var average = snapshot.data['averageValue'];
          average = average.round();
          return buildWaitingTimeView(context, average);
        }
        else {
          print('no data');
          return buildWaitingTimeView(context, "No Data");
        }
      }
    );
  }

  buildWaitingTimeView(BuildContext context, average){
    return Row(     
      mainAxisAlignment: MainAxisAlignment.center,           
      children: <Widget>[
        Text(
          'Estimated Waiting Time : ',
          style: TextStyle(
            fontFamily: 'Oxygen',
            fontSize: 14.5,
            color: Colors.white
          ),
        ),
        Text(
          '${average.toString()} ',
          style: TextStyle(
            fontFamily: 'Oxygen',
            fontSize: 14.5,
            color: Colors.white
          ),
        ),
        Text(
          'minute(s)',
          style: TextStyle(
            fontFamily: 'Oxygen',
            fontSize: 14.5,
            color: Colors.white
          ),
        ),
      ],
    );
  }
}