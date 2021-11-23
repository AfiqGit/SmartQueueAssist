import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_queue_assist/Model/User.dart';
import 'package:smart_queue_assist/Services/Wrapper.dart';
import 'package:smart_queue_assist/Services/user_auth.dart';
import 'package:smart_queue_assist/View/admin_home.dart';
import 'package:smart_queue_assist/View/doctor_inspection_queue.dart';
import 'package:smart_queue_assist/View/loading.dart';
import 'package:smart_queue_assist/View/medication_queue.dart';
import 'package:smart_queue_assist/View/payment_queue.dart';
import 'package:smart_queue_assist/View/qr_code_generator.dart';
import 'package:smart_queue_assist/View/register_queue.dart';
import 'package:smart_queue_assist/View/time_forecast.dart';
import 'package:smart_queue_assist/View/user_home.dart';
import 'package:smart_queue_assist/View/login.dart';
import 'package:smart_queue_assist/View/user_profile.dart';
import 'package:smart_queue_assist/View/user_registration.dart';
import 'package:smart_queue_assist/View/view_queue.dart';


void main() {
  AwesomeNotifications().initialize(
    null, 
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName : 'Smart Queue Notification',
        defaultColor: Colors.teal,
        importance: NotificationImportance.High,
        channelShowBadge: true,
      )
    ]
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: UserAuth().user,
      child: MaterialApp(
        // MaterialApp contains our top-level Navigator
        home: Wrapper(),
        routes: {
          '/time_forecast': (context) => TimePrediction(),
          '/qr_code': (context) =>QRGeneratorPage(),
          '/register_queue': (context) => RegisterQueue(),
          '/doctor_inspection': (context) => DoctorInspection(),
          '/medication': (context) => Medication(),
          '/payment': (context) => Payment(),
          '/loading':(context) => Loading(),
          '/user_register':(context) => UserRegistration(),
          '/user_home':(context) =>UserHome(),
          '/admin_home':(context) =>AdminHome(),
          '/login':(context) =>Login(),
          '/user_profile':(context) =>UserProfile(),
          '/view_queue':(context) =>ViewQueue(),
        },
      ),
    );
  }
}