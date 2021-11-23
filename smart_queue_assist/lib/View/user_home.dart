import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:clip_shadow/clip_shadow.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smart_queue_assist/Animations/custom_clipper.dart';
import 'package:smart_queue_assist/Controller/home_controller.dart';
import 'package:smart_queue_assist/Controller/notification_controller.dart';
import 'package:smart_queue_assist/Model/User.dart';
import 'package:smart_queue_assist/Services/user_auth.dart';


class UserHome extends StatefulWidget {
  final FirebaseUser user;
  const UserHome({Key key, this.user}) : super(key: key);

  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  final UserAuth _auth = UserAuth();

  void initState(){
    super.initState();
    AwesomeNotifications().isNotificationAllowed().then((isAllowed){
      if(!isAllowed){
        showDialog(context: context, builder: (context) => AlertDialog(
          title: new Text("Allow Notifications", style: TextStyle(color: Color.fromRGBO(191, 122, 105, 1), fontSize: 15, fontWeight: FontWeight.bold)),
          content: new Text("Smart Queue would like to send notifications", style: TextStyle(color: Color.fromRGBO(191, 122, 105, 1), fontSize: 14, fontWeight: FontWeight.bold)),
          actions: <Widget>[
            FlatButton(
              child: new Text("Don't Allow", style: TextStyle(color: Color.fromRGBO(191, 122, 105, 1), fontSize: 15, fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: new Text("Allow", style: TextStyle(color: Color.fromRGBO(191, 122, 105, 1), fontSize: 15, fontWeight: FontWeight.bold)),
              onPressed: () {
                AwesomeNotifications().requestPermissionToSendNotifications();
                Navigator.pop(context);
              },
            ),
          ],
        ));
      }
    });
  }

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
    final userSession = Provider.of<User>(context);
    return Column(
          children: <Widget>[
            //SizedBox(height:MediaQuery.of(context).size.height*0.26),
            Text(
              'All you need is your smartphone' ,
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
                      NotificationController(userId: userSession.userId),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          HomeController(titleOne: 'Your Profile', titleTwo: 'Information', image: 'images/profile.png', iconColor: Colors.white, pageRoute: '/user_profile'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          HomeController(titleOne: 'Register Queue', titleTwo: 'Number', image: 'images/qr_code.png', iconColor: Colors.white, pageRoute: '/register_queue'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          HomeController(titleOne: 'View Queue', titleTwo: 'Number', image: 'images/queue_register.png', iconColor: Colors.white, pageRoute: '/view_queue'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          HomeController(titleOne: 'View Time', titleTwo: 'Forecast', image: 'images/time.png', iconColor: Colors.white, pageRoute: '/time_forecast'),
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