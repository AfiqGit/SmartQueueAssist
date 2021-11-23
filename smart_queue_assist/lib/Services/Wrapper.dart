import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_queue_assist/Controller/user_controller.dart';
import 'package:smart_queue_assist/Model/User.dart';
import 'package:smart_queue_assist/View/admin_home.dart';
import 'package:smart_queue_assist/View/login.dart';
import 'package:smart_queue_assist/View/user_home.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final userSession = Provider.of<User>(context);
    if(userSession == null){
      return Login();
    }
    else return StreamBuilder<UserData>(
      stream: UserController(userId: userSession.userId).userData,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          UserData userData = snapshot.data;
          print(userData.role);
          if(userData.role == 'admin'){
            return AdminHome();
          }

          if(userData.role == 'user'){
            print('inside user home');
            return UserHome();
          }
        }
        return Login();
      });

  }
}