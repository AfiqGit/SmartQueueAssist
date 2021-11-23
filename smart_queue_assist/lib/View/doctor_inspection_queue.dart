import 'package:clip_shadow/clip_shadow.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smart_queue_assist/Animations/custom_clipper.dart';
import 'package:smart_queue_assist/Controller/register_queue_controller.dart';
import 'package:smart_queue_assist/Model/User.dart';

class DoctorInspection extends StatefulWidget {
  final String queue;
  DoctorInspection({this.queue});
  @override
  DoctorInspectionState createState() => DoctorInspectionState();
}

class DoctorInspectionState extends State<DoctorInspection> {
  DateTime date;
  String queueNumberText = 'No Data';
  // QueueController queue;

  

  getDate(){
    DateTime now = DateTime.now();
    date= now;
    // String formatDate = DateFormat('kk:mm:ss \n EEE d MMM').format(now);
    // textMessage2 = 'Time registered $formatDate';
  }

  // setQueueNumber(String queue){
  //   queueNumber = queue;
  // }

  // getQueueNumber(){
  //   return queueNumber;
  // }


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
              'Doctor Inspection Queue',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 23.5,
                color: Colors.white
              ),
            ),
          ),
          body: Center(
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height:30.0),
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
              ),
              Container(
                margin: EdgeInsets.only(top: 20.0, bottom: 15.0),
                width: MediaQuery.of(context).size.width*0.9,
                  decoration: BoxDecoration(
                  color:  Color(0xFFe17272),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    new BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      offset: new Offset(0.0, 5.0),
                      blurRadius: 6.0,            
                    )
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(height:8.0),
                    Text(
                      'Current Queue Number : ',
                      style: TextStyle(
                        fontFamily: 'Oxygen',
                        fontWeight: FontWeight.bold,
                        fontSize: 23.5,
                        color: Colors.white
                      ),
                    ),
                    SizedBox(height:30.0),
                    ViewQueueController(value: 1, date: getDate()),
                  ],
                ),
              ),
              
              SizedBox(
                width: MediaQuery.of(context).size.width*0.9,
                height:50,
                child: RaisedButton( 
                  onPressed: () {
                    showAlertDialog(context);
                  },
                  elevation: 5.0,
                  color: Color(0xFFe17272),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Call Next Queue Number',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'Oxygen',
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Icon(
                        MdiIcons.accountGroup,
                        color: Colors.white,
                        size: 25.0,
                      ),
                    ],
                  ),
                ),
              )
            ],
        ),
          )
        ),
      ],
    );
  }

showAlertDialog(BuildContext context) {
  String queue = widget.queue;
  final userSession = Provider.of<User>(context);
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Confirmation",
        style: TextStyle(
              fontFamily: 'Oxygen',
              color: Color.fromRGBO(191, 122, 105, 1),
            ),
      ),
      content: Text(
        "Confirm call next queue number ",
        style: TextStyle(
              fontFamily: 'Oxygen',
              color: Color.fromRGBO(191, 122, 105, 1),
            ),
      ),
      actions: [
        FlatButton(
          onPressed: () async{
            getDate();
            
            setState(() {
              ViewQueueController(value: 1, date: date);
            });
            
            Navigator.of(context).pop();
          }, 
          child: Text(
            'Yes',
             style: TextStyle(
              fontFamily: 'Oxygen',
              color: Color.fromRGBO(191, 122, 105, 1),
            ),
          )
        ),
        FlatButton(
          onPressed: (){
            Navigator.of(context).pop();
          }, 
          child: Text(
            'No',
              style: TextStyle(
                fontFamily: 'Oxygen',
                color: Color.fromRGBO(191, 122, 105, 1),
              ),
            )
          )
      ],
      elevation: 24.0,
      backgroundColor: Colors.white,
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}