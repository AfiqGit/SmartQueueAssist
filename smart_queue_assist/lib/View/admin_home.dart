import 'package:clip_shadow/clip_shadow.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:smart_queue_assist/Animations/custom_clipper.dart';
import 'package:smart_queue_assist/Controller/home_controller.dart';
import 'package:smart_queue_assist/Services/user_auth.dart';


class AdminHome extends StatefulWidget {
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
    final UserAuth _auth = UserAuth();
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
            automaticallyImplyLeading: false,
            centerTitle: true,
            elevation: 0.0,
            title: Text(
              'Welcome',
              style: TextStyle(
                fontFamily: 'Oxygen',
                fontWeight: FontWeight.bold,
                fontSize: 23.5,
                color: Colors.white
              ),
            ),
            actions: <Widget>[
              IconButton(
                onPressed: () async{
                  // Navigator.pushNamed(context, '/login');
                   await _auth.signOut();
                  //  Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
                },
                icon: Icon(Icons.exit_to_app),
              ),
            ],
          ),
          body: Builder(
            builder: (context) => HomePage(),
          )
      ),
      ],
    );
  }
}


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
          children: <Widget>[
            //SizedBox(height:MediaQuery.of(context).size.height*0.26),
            Text(
              'Manage queue from your smartphone' ,
              style: TextStyle(
              //fontWeight: FontWeight.w200,
              fontSize: 18.5,
              color: Colors.white
            ),
            ),
            Divider(
              color: Colors.white,
              indent: 100.0,
              endIndent: 100.0,
              thickness: 2.5,
              height: 17.0,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          HomeController(titleOne: 'Generate', titleTwo: 'QR Code', image: 'images/qr_code.png', iconColor: Colors.white, pageRoute: '/qr_code'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          HomeController(titleOne: 'Manage Doctor', titleTwo: 'Inspection', image: 'images/profile.png', iconColor: Colors.white, pageRoute: '/doctor_inspection'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          HomeController(titleOne: 'Manage', titleTwo: 'Medication', image: 'images/profile.png', iconColor: Colors.white, pageRoute: '/medication'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          HomeController(titleOne: 'Manage', titleTwo: 'Payment', image: 'images/profile.png', iconColor: Colors.white, pageRoute: '/payment'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
  }
}