import 'package:barcode_scan/barcode_scan.dart';
import 'package:clip_shadow/clip_shadow.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smart_queue_assist/Animations/custom_clipper.dart';
import 'package:smart_queue_assist/Controller/register_queue_controller.dart';
import 'package:smart_queue_assist/Controller/time_forecast_controller.dart';
import 'package:smart_queue_assist/Model/User.dart';

class RegisterQueue extends StatefulWidget {
  
    static Future scanQR() async{
      String qrResult= await BarcodeScanner.scan();
      
    }
    RegisterQueue({Key key}): super(key: key);

  @override
  RegisterQueueState createState() => RegisterQueueState();
}

class RegisterQueueState extends State<RegisterQueue> {

  String result;
  String textMessage1= 'Please Scan';
  String textMessage2= 'QR Code';
  DateTime date;

  Future scanQR() async{
    String qrResult = await BarcodeScanner.scan();
    setState(() {
      result = qrResult;
      textMessage1 = 'Your Queue Number is $result';
    });
  }

  getDate(){
    DateTime now = DateTime.now();
    date= now;
    print(date);
    String formatDate = DateFormat('kk:mm:ss \n EEE d MMM').format(now);
    textMessage2 = 'Time registered $formatDate';
  }

  @override
  Widget build(BuildContext context) {
    final userSession = Provider.of<User>(context);
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
              'Register Queue',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 23.5,
                color: Colors.white
              ),
            ),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  textMessage1,
                  style: TextStyle(
                    fontFamily: 'Oxygen',
                    fontWeight: FontWeight.bold,
                    fontSize: 23.5,
                    color: Colors.black
                  ),
                ),
                Text(
                  textMessage2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Oxygen',
                    fontWeight: FontWeight.bold,
                    fontSize: 23.5,
                    color: Colors.black
                  ),
                ),        
              ]
            )
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () async{
              await scanQR();
              getDate();
              print(userSession.userId);
              await QueueController(userId: userSession.userId).getRegistrationCounterFromFirebase(userSession.userId, result, date);
              TimeForeCastController(time: date).insertTime();
                setState(() {
                  
                  getDate();
                });
            },
            label: Text('Scan QR'),
            backgroundColor: Color(0xFFe17272),
          ),
        )
      ]
    );
  }
}