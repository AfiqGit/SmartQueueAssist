
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

import 'package:smart_queue_assist/Controller/register_queue_controller.dart';

// final GlobalKey<_QRCodeControllerState> _QRCodeController= GlobalKey<_QRCodeControllerState>();

class QRCodeController extends StatefulWidget {
  final int value;
  QRCodeController({this.value});
  
  @override
  QRCodeControllerState createState() => QRCodeControllerState(); 
}

getQR() async{
  Firestore.instance.collection('queue').document('startingQueue').get(); 
  return QRCodeController();
}
resetQR() async{
  print('inside resetqr function');
  await Firestore.instance.collection('queue').document('startingQueue').updateData({'queueNumber': 1000});
}

  // updateQR() async {
  //   // var queue =getQR();
  //   // print(queue);
  //   // int queueNumber= int.parse(queue)+ 1;
  //   // await Firestore.instance.collection('queue').document('startingQueue').updateData({'queueNumber': queueNumber});
    
  //   // int queue= queueNumber;
  //  print('in update function');
  //   return FutureBuilder(
  //     future: getQR(),
  //     builder: (context, snapshot){
  //       if (snapshot.hasData) {
  //         // int queue= int.parse(snapshot.data['queueNumber']);
  //         // queue= ++queue;
  //         // print(queue);
  //         // Firestore.instance.collection('queue').document('startingQueue').updateData({'queueNumber': queue});

  //         int queueNumber = int.parse(snapshot.data['queueNumber'].toString());
  //           queueNumber = ++queueNumber;
  //           print(queueNumber);
  //           Firestore.instance.collection('queue').document('startingQueue').updateData({'queueNumber': queueNumber});
  //       }
  //       else{
  //         print('no data');
  //       }
  //       return QRCodeController();
  //     }
  //     );

  //   // QRCodeController();
  // }


class QRCodeControllerState extends State<QRCodeController> {

  

  @override
  // void initState(){
  //   super.initState();
  //   queueFuture= getQR();
  // }


  Widget build(BuildContext context) {
    return buildGenerateQR(context);
  }

  // Future<void> getStartingQueueNumber async() {
  //   startQueue= await Firestore.instance.collection('queue').document('startingQueue').get();

  //   return startQueue;
  // }

  Widget buildGenerateQR(BuildContext context){
    return FutureBuilder(
      future: Firestore.instance.collection('queue').document('startingQueue').get(),
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
          int value= widget.value;
          print(value);
          var queueNumberMap = snapshot.data;          
          int queueNumber = int.parse(queueNumberMap['queueNumber'].toString());

          //update the qr code
          if(value == 1){       
            print(queueNumber);
            Firestore.instance.collection('queue').document('startingQueue').updateData({'queueNumber': queueNumber+1});
            return buildShowQR(context, queueNumber);
          }
          //reset the qr code
          else if(value == 2){
            queueNumber= 1000;
            Firestore.instance.collection('queue').document('startingQueue').updateData({'queueNumber': queueNumber});
            QueueController().deleteRegistrationQueue();
            QueueController().deleteMedicationQueue();
            QueueController().deletePaymentQueue();
            return buildShowQR(context, queueNumber);
          }
          //display qr code
          else return buildShowQR(context, queueNumber);
       }
      }
    );
  }

  Widget buildShowQR(context,queueNumber){
    return Container(
      color: Colors.transparent,
      child: Column(
        children: <Widget>[
          Text(
            'Queue Number: ${queueNumber.toString()}',
            style: TextStyle(
              fontFamily: 'Oxygen',
              fontSize: 18.5,
              color: Colors.white,
            ),
          ),
          QrImage(
            data: queueNumber.toString(),
            foregroundColor: Colors.white,
            size: 230,
          ),
        ],
      ),
    );
  }






}


