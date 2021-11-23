import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_queue_assist/Services/notifications.dart';

class NotificationController extends StatefulWidget {
  final String userId;
  NotificationController({this.userId});

  @override
  _NotificationControllerState createState() => _NotificationControllerState();
}

class _NotificationControllerState extends State<NotificationController> {

  final CollectionReference userCollection = Firestore.instance.collection('/user');

  final CollectionReference doctorAdmitCollection = Firestore.instance.collection('/queue/doctorInspection/admit');
  final CollectionReference counterDoctorCollection = Firestore.instance.collection('/queue/doctorInspection/counter');

  @override
  Widget build(BuildContext context) {
    String userId = widget.userId;
    return FutureBuilder(
      future: counterDoctorCollection.document('patientCounter').get(),
      //stream : counterDoctorCollection.document('patientCounter').snapshots(),
      builder: (BuildContext context, snapshot) {
         int counter = snapshot.data['counterValue'];
         try{
           if(counter != 0){
          //return buildDoctorInspectionView(context, counter);
          return FutureBuilder(
            future: doctorAdmitCollection.document(counter.toString()).get(),
            //stream: doctorAdmitCollection.document(counter.toString()).snapshots(),
            builder: (BuildContext context, snapshotDoctor) {
              try{
                if(snapshot.data != null){
                String queueNumber = snapshotDoctor.data['queueNumber'];
                print('current queue:'+queueNumber);
                return FutureBuilder(
                  future: Firestore.instance.collection('/user').document(userId).get(),
                  //stream: Firestore.instance.collection('/user').document(userId).snapshots(),
                  builder: (BuildContext context, snapshotPatient) {
                    String patientQueue = snapshotPatient.data['queueNumber'];
                    try{
                      if(patientQueue == queueNumber && queueNumber == patientQueue){
                        print('patient queue: '+patientQueue);
                        createQueueReadyNotifications();
                      return Center();
                      }
                      else return Center();
                    }
                    catch(e){
                      return Center();
                    }
                      
                  },
                );
              }
              else {
                return Center();
              }
              }
              catch(e){
                return Center();
              }
            },
          );
        }
        else {
          //return buildViewDoctorQueue(context, "No Data");
          return Center();
        }
         }
         catch (e){
           return Center();
         }
        
      }
      );
  }
}
