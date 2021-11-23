import 'package:clip_shadow/clip_shadow.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:smart_queue_assist/Animations/custom_clipper.dart';
import 'package:smart_queue_assist/Controller/qr_code_generator_controller.dart';


final GlobalKey<QRCodeControllerState> _qrGenerator= GlobalKey<QRCodeControllerState>();

class QRGeneratorPage extends StatefulWidget {
  @override
  _QRGeneratorPageState createState() => _QRGeneratorPageState();
}
  int value=0;
  int getValue(){
    return value;
  }

  void setValue(val){
    value=val;
  }

class _QRGeneratorPageState extends State<QRGeneratorPage> {

final _formKey = GlobalKey<FormState>();

  
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
          body: Form(
            key: _formKey,
              child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
               SizedBox(height: 30),
                Text(
                  'Press the QR Code to generate new one',
                  style: TextStyle(
                    fontFamily: 'Oxygen',
                    fontSize: 18.5,
                    color: Colors.white
                  ),
                ),
                SizedBox(height: 30),
                Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 20.0, bottom: 15.0),
                      width: MediaQuery.of(context).size.width*0.9,
                      height: MediaQuery.of(context).size.height*.40,
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
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            QRCodeController(value: getValue()),
                          ]
                        ),
                      )
                    ),
              ),
                  SizedBox(height: 30),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.9,
                    height:50,
                    child: RaisedButton( 
                      onPressed: () {
                        setState(() {
                          setValue(1);
                          QRCodeController(value: getValue());
                        });                     
                        print('clicking update');
                      },
                      elevation: 5.0,
                      color: Color(0xFFe17272),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Update QR Code',
                            style: TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'Oxygen',
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Icon(
                            MdiIcons.qrcodePlus,
                            color: Colors.white,
                            size: 25.0,
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 15),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.9,
                    height:50,
                    child: RaisedButton( 
                      onPressed: () {
                        showAlertDialog(context);
                        print('clicking reset');
                      },
                      elevation: 5.0,
                      color: Color(0xFFe17272),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Reset QR Code',
                            style: TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'Oxygen',
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Icon(
                            MdiIcons.qrcodePlus,
                            color: Colors.white,
                            size: 25.0,
                          ),
                        ],
                      ),
                    ),
                  )

              ],
            ),
          ),
        )
      ]
    );
  }

  showAlertDialog(BuildContext context) {

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
        "Confirm reset queue number? ",
        style: TextStyle(
              fontFamily: 'Oxygen',
              color: Color.fromRGBO(191, 122, 105, 1),
            ),
      ),
      actions: [
        FlatButton(
          onPressed: (){
           
            setState(() {
              setValue(2);
              QRCodeController(value: getValue());
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