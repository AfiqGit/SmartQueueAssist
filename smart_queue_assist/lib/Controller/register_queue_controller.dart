import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:intl/intl.dart';


class QueueController{
  final String userId;
  QueueController({this.userId});

  final CollectionReference userCollection = Firestore.instance.collection('user');

  final CollectionReference registerQueueCollection = Firestore.instance.collection('/queue/registeredQueue/queue');
  final CollectionReference counterRegisterCollection = Firestore.instance.collection('/queue/registeredQueue/counter');

  final CollectionReference doctorAdmitCollection = Firestore.instance.collection('/queue/doctorInspection/admit');
  final CollectionReference counterDoctorCollection = Firestore.instance.collection('/queue/doctorInspection/counter');

  final CollectionReference medicationQueueCollection = Firestore.instance.collection('/queue/medication/queue');
  final CollectionReference medicationAdmitCollection = Firestore.instance.collection('/queue/medication/admit');
  final CollectionReference counterMedicationCollection = Firestore.instance.collection('/queue/medication/counter');

  final CollectionReference paymentQueueCollection = Firestore.instance.collection('/queue/payment/queue');
  final CollectionReference paymentAdmitCollection = Firestore.instance.collection('/queue/payment/admit');
  final CollectionReference counterPaymentCollection = Firestore.instance.collection('/queue/payment/counter'); 

  String patientName;
  String patientQueueNumber;
  int doctorInspectionCounter;

  //queue for registration
  registerQueueNumber(String userId, String queueNumber, DateTime timeRegister, int counter, String patientName) async{
    print('inside register queue controller');
    print(counter);
    int time = timeRegister.millisecondsSinceEpoch;
    updateCounterForRegistration(counter);
    updateUserQueueData(queueNumber, userId);
    return await registerQueueCollection.document(counter.toString()).setData({
      'queueNumber'       : queueNumber ,
      'timeRegistered'    : time,
      'userId'            : userId,
      'name'              : patientName
    });
  }

  updateUserQueueData(queueNumber, userId) async{
    return await userCollection.document(userId).updateData({'queueNumber' : queueNumber});
  }

  getRegistrationCounterFromFirebase(String userId, String queueNumber, DateTime timeRegister) async{
    int counter;
    counterRegisterCollection.document('patientCounter').get().then((DocumentSnapshot snapshot){
      counter = snapshot.data['counterValue'];
      getUserNameFromFirebase(userId, queueNumber, timeRegister, counter);
    });
  }

  getUserNameFromFirebase(String patientId, String queueNumber, DateTime timeRegister, int counter){
    String patientName;

    userCollection.document(patientId).get().then((DocumentSnapshot snapshot){
      patientName = snapshot.data['first_name'];
      print('insdide patient name');
      print(patientName);
      registerQueueNumber(patientId, queueNumber, timeRegister, counter, patientName);
    });

  }

  updateCounterForRegistration(int counter){
    counter = ++counter;
    counterRegisterCollection.document('patientCounter').updateData({'counterValue' : counter});
  }

  //delete registration queue
  deleteRegistrationQueue(){
    int counter;
    counterRegisterCollection.document('patientCounter').get().then((DocumentSnapshot snapshot){
      counter = snapshot.data['counterValue'];
      deleteRegistrationQueueInDB(counter);
    });
  }

  deleteRegistrationQueueInDB(int counter){
    for(int i = counter; i > 0; i--){
      registerQueueCollection.document(i.toString()).delete();
    }
    counterRegisterCollection.document('patientCounter').updateData({'counterValue' : 1});
    counterDoctorCollection.document('patientCounter').updateData({'counterValue' : 1});
    // Firestore.instance.collection('/queue/doctorInspection/averageWaitingQueue').document('average').updateData({'averageValue' : 0});
  }

  //delete doctor queue
  // deleteDoctorInspectionQueue(){
  //   int counter;
  //   counterDoctorCollection.document('patientCounter').get().then((DocumentSnapshot snapshot){
  //     counter = snapshot.data['counterValue'];
  //     deleteDoctorQueueInDB(counter);
  //   });
  // }

  //  deleteDoctorQueueInDB(int counter){
  //   for(int i = counter; i > 0; i--){
  //     doctorAdmitCollection.document(i.toString()).delete();
  //   }
  //   counterDoctorCollection.document('patientCounter').updateData({'counterValue' : 1});
  //   deleteMedicationQueue();
  //  }

  //delete medication queue
  deleteMedicationQueue(){
    int counter;
    counterMedicationCollection.document('patientCounter').get().then((DocumentSnapshot snapshot){
      counter = snapshot.data['counterValue'];
      deleteMedicationQueueInDB(counter);
      print('inside medication');
      print(counter);
    });
  }

   deleteMedicationQueueInDB(int counter){
    for(int i = counter; i > 0; i--){
      medicationQueueCollection.document(i.toString()).delete();
    }
    counterMedicationCollection.document('patientCounter').updateData({'counterValue' : 1});
   }

  //delete payment queue
  deletePaymentQueue(){
    int counter;
    counterPaymentCollection.document('patientCounter').get().then((DocumentSnapshot snapshot){
      counter = snapshot.data['counterValue'];
      deletePaymentQueueInDB(counter);
      print('inside payment');
      print(counter);
    });
  }

   deletePaymentQueueInDB(int counter){
    for(int i = counter; i > 0; i--){
      paymentQueueCollection.document(i.toString()).delete();
    }
    counterPaymentCollection.document('patientCounter').updateData({'counterValue' : 1});
   }

  // queue for doctor inspection
  // Future doctorInspectionAdmit(String patientId, String queueNumber, DateTime timeRegister, int counter, int timeFromQueue, String patientName) async{
  //   int time1 = timeRegister.millisecondsSinceEpoch;
  //   updateCounterForDoctor(counter);
  //   Queue(userId: patientId, queueNumber: queueNumber, timeEnter: timeFromQueue, timeRegistered: time1, name: patientName );
  //   return await doctorAdmitCollection.document(counter.toString()).setData({
  //     'queueNumber'     : queueNumber,
  //     'timeEnter'       : time1,
  //     'userId'          : patientId,
  //     'timeRegistered'  : timeFromQueue,
  //     'name'            : patientName
  //   });
  // }

  // getDoctorCounterFromFirebase(DateTime timeRegister) async{
    
  //   counterDoctorCollection.document('patientCounter').get().then((DocumentSnapshot snapshot){
  //     doctorInspectionCounter = snapshot.data['counterValue'];
  //     getDoctorQueueFromFirebase(doctorInspectionCounter, timeRegister);
  //   });
  // }

  // getDoctorQueueFromFirebase(int counter, DateTime timeRegister) async{
  //   String queueNumber;
  //   String patientId;
  //   String patientName;
  //   int time;
  //   registerQueueCollection.document(counter.toString()).get().then((DocumentSnapshot snapshot) {
  //     queueNumber = snapshot.data['queueNumber'];
  //     patientId = snapshot.data['userId'];
  //     time = snapshot.data['timeRegistered'];
  //     patientName = snapshot.data['name'];
  //     doctorInspectionAdmit(patientId, queueNumber, timeRegister, counter, time, patientName);
  //     getPatientQueueNumber(queueNumber);
  //   });
  // }

  // getPatientQueueNumber(String queueNumber){
  //   return queueNumber;
  // }

  // updateCounterForDoctor(int counter){
  //   counter = ++counter;
  //   counterDoctorCollection.document('patientCounter').updateData({'counterValue' : counter});
  // }

  // Queue queueInfoFromSnapshot(DocumentSnapshot snapshot){
  //   return Queue(
  //     userId        : snapshot.data['userId'],
  //     queueNumber   : snapshot.data['name'],
  //     timeRegistered: snapshot.data['role'],
  //     timeEnter     : snapshot.data['timeEnter'],
  //     name          : snapshot.data['name'],
  //     );
  // }

  // getCounter(){
  //   int counter;
  //   counterDoctorCollection.document('patientCounter').get().then((DocumentSnapshot snapshot){
  //     counter = snapshot.data['counterValue'];
  //     counter = counter - 1;
  //     // getqueueData(counter);
  //   });
  // }

  // Stream<Queue> get queueData{
  //   print('doctor counter');
  //   print(doctorInspectionCounter);
  // return registerQueueCollection.document('1').snapshots().map(queueInfoFromSnapshot);
  // }

}

class ViewQueueController extends StatefulWidget {
  final DateTime date;
  final int value;

  ViewQueueController({this.date, this.value});
  @override
  ViewQueueControllerState createState() => ViewQueueControllerState();
}

class ViewQueueControllerState extends State<ViewQueueController> {

  final CollectionReference registerQueueCollection = Firestore.instance.collection('/queue/registeredQueue/queue');

  final CollectionReference doctorAdmitCollection = Firestore.instance.collection('/queue/doctorInspection/admit');
  final CollectionReference counterDoctorCollection = Firestore.instance.collection('/queue/doctorInspection/counter');

  final CollectionReference medicationQueueCollection = Firestore.instance.collection('/queue/medication/queue');
  final CollectionReference medicationAdmitCollection = Firestore.instance.collection('/queue/medication/admit');
  final CollectionReference counterMedicationCollection = Firestore.instance.collection('/queue/medication/counter');

  final CollectionReference paymentQueueCollection = Firestore.instance.collection('/queue/payment/queue');
  final CollectionReference paymentAdmitCollection = Firestore.instance.collection('/queue/payment/admit');
  final CollectionReference counterPaymentCollection = Firestore.instance.collection('/queue/payment/counter'); 

  bool verifyDoctorQueue = false;
  bool verifyMedicationQueue = false;
  bool verifyPaymentQueue = false;

  Future doctorInspection(int counter) async{
    return await registerQueueCollection.document(counter.toString()).get().then((doc) {
        if (doc.exists)
          verifyDoctorQueue = true;
        else
          verifyDoctorQueue = false;
      });
  }

  @override
  Widget build(BuildContext context) {
  DateTime timeRegister =DateTime.now();
    int value = widget.value;
  print(timeRegister);
  if(value == 1) return doctorInspectionQueue(context, timeRegister);
  else if(value == 2) return medicationQueue(context, timeRegister);
  else return paymentQueue(context, timeRegister);
  }

  Widget doctorInspectionQueue(BuildContext context, timeRegister){
    return FutureBuilder(
      future: counterDoctorCollection.document('patientCounter').get(),
      builder: (BuildContext context, snapshot) {
        int counter = snapshot.data['counterValue'];
        if(counter == 0){
          print(counter);
          return buildQueue(context, "No Data", "No Data");
          
        }
        else {
          print('inside doctor inspection');
          return buildDoctorQUeueInfo(context, counter, timeRegister);
        }
        // else{
        //   //int counter = snapshot.data['counterValue'];
        //   print('inside doctor inspection');
        //   return buildQueue(context, "No Data", "No Data");
        //   //return buildDoctorQUeueInfo(context, counter, timeRegister);
        // }
      }
    );
  }

  Widget buildDoctorQUeueInfo(BuildContext context, counter, timeRegister){
    return FutureBuilder(
      future: registerQueueCollection.document(counter.toString()).get(),
      builder: (BuildContext context, snapshot) {
        try{
          if(snapshot.hasData){
          print(snapshot.data);
          String queueNumber = snapshot.data['queueNumber'] ?? "No Data";
          String patientId = snapshot.data['userId'] ?? "No Data";
          int time = snapshot.data['timeRegistered'] ?? "No Data";
          String patientName = snapshot.data['name'] ?? "No Data";

          updateCounterForDoctor(int counter){
            counter = ++counter;
            counterDoctorCollection.document('patientCounter').updateData({'counterValue' : counter});
          }

          doctorRelease(String queueNumber,int time1,String patientId,int timeFromQueue,String patientName, int counter) async{
              return await medicationQueueCollection.document(counter.toString()).setData({
                'queueNumber'   : queueNumber,
                'timeEnter'     : 0,
                'userId'        : patientId,
                'timeRegistered': time1,
                'name'          : patientName
              });
          }

          doctorInspectionRelease(int counter) async{
            int time1 ;
            int timeFromQueue;
            String queueNumber;
            String patientId;
            String patientName;
            counter = counter -1;
            if(counter == 0){
              return null;
            }
            else {
              await doctorAdmitCollection.document(counter.toString()).get().then((DocumentSnapshot snapshot){
              queueNumber     = snapshot.data['queueNumber'];
              time1           = snapshot.data['timeEnter'];
              patientId       = snapshot.data['userId'];
              timeFromQueue   = snapshot.data['timeRegistered'];
              patientName     = snapshot.data['name'];

              doctorRelease(queueNumber, time1, patientId, timeFromQueue, patientName, counter);
              // doctorAdmitCollection.document(counter.toString()).delete();

            });

            
            }
          }

            calculateAverageWaitingTime(average, difference, counter) async{
              average = (average + difference)/counter;
              print('inside average calculation');
              print(average);
              await Firestore.instance.collection('/queue/doctorInspection/averageWaitingQueue').document('average').updateData({'averageValue' : average});
            }

            getAverageWaitingTime(int counter, int time1, int timeFromQueue) async{
              
              DateTime date1 = new DateTime.fromMillisecondsSinceEpoch(time1);
              DateTime date2 = new DateTime.fromMillisecondsSinceEpoch(timeFromQueue);

              var difference = date1.difference(date2).inMinutes;
              print('time difference');
              print(difference);
              Firestore.instance.collection('/queue/doctorInspection/averageWaitingQueue').document('average').get().then((DocumentSnapshot snapshot){
                var average = snapshot.data['averageValue'];
                // average = (average + difference)/counter;
                // print(average);
                // print(counter);
                // int result = int.parse(average);
                calculateAverageWaitingTime(average, difference, counter);
                
              });
            }

          doctorInspectionAdmit(String patientId, String queueNumber, DateTime timeRegister, int counter, int timeFromQueue, String patientName) async{
            int time1 = timeRegister.millisecondsSinceEpoch;
            updateCounterForDoctor(counter);
            await doctorAdmitCollection.document(counter.toString()).setData({
              'queueNumber'     : queueNumber,
              'timeEnter'       : time1,
              'userId'          : patientId,
              'timeRegistered'  : timeFromQueue,
              'name'            : patientName
            });
            getAverageWaitingTime(counter, time1, timeFromQueue);
            await doctorInspectionRelease(counter);
          }

          doctorInspectionAdmit(patientId, queueNumber, timeRegister, counter, time, patientName);
          
          return buildQueue(context, patientName, queueNumber);
        }
        
        }
        catch (e){
          print('no data to be displayed');
          return buildQueue(context, "No Data", "No Data");
        }
        
      }
    );
  }

  Widget medicationQueue(BuildContext context, timeRegister){
    return FutureBuilder(
      future: counterMedicationCollection.document('patientCounter').get(),
      builder: (BuildContext context, snapshot) {
        int counter = snapshot.data['counterValue'];
        if(counter == 0){
          print(counter);
          return buildQueue(context, "No Data", "No Data");
        }
        else{
          return buildMedicationQueueInfo(context, counter, timeRegister);
        }

      }
    );
  }

  Widget buildMedicationQueueInfo(BuildContext context, counter, timeRegister){

    return FutureBuilder(
      future: medicationQueueCollection.document(counter.toString()).get(),
      builder: (BuildContext context, snapshot) {
        try{
          if(snapshot.hasData){
          String queueNumber = snapshot.data['queueNumber'] ?? "No Data";
          String patientId = snapshot.data['userId'] ?? "No Data";
          int time = snapshot.data['timeRegistered'] ?? "No Data";
          String patientName = snapshot.data['name'] ?? "No Data";

          updateCounterForMedication(int counter){
            counter = ++counter;
            counterMedicationCollection.document('patientCounter').updateData({'counterValue' : counter});
          }

          medicationRelease(String queueNumber,int time1,String patientId,int timeFromQueue,String patientName, int counter) async{
              return await paymentQueueCollection.document(counter.toString()).setData({
                'queueNumber'   : queueNumber,
                'timeEnter'     : 0,
                'userId'        : patientId,
                'timeRegistered': time1,
                'name'          : patientName
              });
          }

          medicationQueueRelease(int counter) async{
            int time1 ;
            int timeFromQueue;
            String queueNumber;
            String patientId;
            String patientName;
            counter = counter -1;
            if(counter == 0){
              return null;
            }
            else {
              await medicationAdmitCollection.document(counter.toString()).get().then((DocumentSnapshot snapshot){
              queueNumber     = snapshot.data['queueNumber'];
              time1           = snapshot.data['timeEnter'];
              patientId       = snapshot.data['userId'];
              timeFromQueue   = snapshot.data['timeRegistered'];
              patientName     = snapshot.data['name'];

              medicationRelease(queueNumber, time1, patientId, timeFromQueue, patientName, counter);

            });

            medicationAdmitCollection.document(counter.toString()).delete();
            }
          }

          medicationAdmit(String patientId, String queueNumber, DateTime timeRegister, int counter, int timeFromQueue, String patientName) async{
            int time1 = timeRegister.millisecondsSinceEpoch;
            updateCounterForMedication(counter);
            await medicationAdmitCollection.document(counter.toString()).setData({
              'queueNumber'     : queueNumber,
              'timeEnter'       : time1,
              'userId'          : patientId,
              'timeRegistered'  : timeFromQueue,
              'name'            : patientName
            });
            medicationQueueRelease(counter);
          }

          medicationAdmit(patientId, queueNumber, timeRegister, counter, time, patientName);
          
          return buildQueue(context, patientName, queueNumber);
        }
        else return buildQueue(context, "No Data", "No Data");
        }
        catch (e){
          return buildQueue(context, "No Data", "No Data");
        }
        
      }
    );
  }
  Widget paymentQueue(BuildContext context, timeRegister){
    return FutureBuilder(
      future: counterPaymentCollection.document('patientCounter').get(),
      builder: (BuildContext context, snapshot) {
        int counter = snapshot.data['counterValue'];
        if(counter == 0){
          print(counter);
          return buildQueue(context, "No Data", "No Data");
          
        }
        else{
          counter = snapshot.data['counterValue'];
          return buildPaymentQueueInfo(context, counter, timeRegister);
        }

      }
    );
  }

  Widget buildPaymentQueueInfo(BuildContext context, counter, timeRegister){
    return FutureBuilder(
      future: paymentQueueCollection.document(counter.toString()).get(),
      builder: (BuildContext context, snapshot) {
        try{
          if(snapshot.hasData){
          String queueNumber = snapshot.data['queueNumber'] ?? "No Data";
          String patientId = snapshot.data['userId'] ?? "No Data";
          int time = snapshot.data['timeRegistered'] ?? "No Data";
          String patientName = snapshot.data['name'] ?? "No Data";

          updateCounterForPayment(int counter){
            counter = ++counter;
            counterPaymentCollection.document('patientCounter').updateData({'counterValue' : counter});
          }

          // medicationRelease(String queueNumber,int time1,String patientId,int timeFromQueue,String patientName, int counter) async{
          //     return await paymentQueueCollection.document(counter.toString()).setData({
          //       'queueNumber'   : queueNumber,
          //       'timeEnter'     : 0,
          //       'userId'        : patientId,
          //       'timeRegistered': time1,
          //       'name'          : patientName
          //     });
          // }

          paymentQueueRelease(int counter) async{
            counter = counter -1;
            if(counter == 0){
              return null;
            }
            else {
              paymentAdmitCollection.document(counter.toString()).delete();
            }
          }

          paymentAdmit(String patientId, String queueNumber, DateTime timeRegister, int counter, int timeFromQueue, String patientName) async{
            int time1 = timeRegister.millisecondsSinceEpoch;
            updateCounterForPayment(counter);
            await paymentAdmitCollection.document(counter.toString()).setData({
              'queueNumber'     : queueNumber,
              'timeEnter'       : time1,
              'userId'          : patientId,
              'timeRegistered'  : timeFromQueue,
              'name'            : patientName
            });
            paymentQueueRelease(counter);
          }

          paymentAdmit(patientId, queueNumber, timeRegister, counter, time, patientName);
          
          return buildQueue(context, patientName, queueNumber);
        }
        else return buildQueue(context, "No Data", "No Data");
        }
        catch(e){
          return buildQueue(context, "No Data", "No Data");
        }
        
      }
    );
  }

  Widget buildQueue(BuildContext context, patientName, queueNumber){
    return Center(
      child: Column(
        children: <Widget>[
          Text(
            '$queueNumber',
            style: TextStyle(
              fontFamily: 'Oxanium',
              fontWeight: FontWeight.bold,
              fontSize: 80.5,
              color: Colors.white
            ),
          ),
          SizedBox(height:30.0),
          Text(
            'Patient Name :',
            style: TextStyle(
              fontFamily: 'Oxanium',
              fontWeight: FontWeight.bold,
              fontSize: 23.5,
              color: Colors.white
            ),
          ),
          SizedBox(height:30.0),
          Text(
            '$patientName',
            style: TextStyle(
              fontFamily: 'Oxanium',
              fontWeight: FontWeight.bold,
              fontSize: 23.5,
              color: Colors.white
            ),
          ),
          SizedBox(height:30.0),
        ],
        ),
      );
  }
}