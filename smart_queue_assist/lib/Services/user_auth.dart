import 'package:smart_queue_assist/Controller/user_controller.dart';
import 'package:smart_queue_assist/Model/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

class UserAuth{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFirebase(FirebaseUser user){
    return user != null? User(userId: user.uid) : null;
  }

  Stream<User> get user{
    return _auth.onAuthStateChanged.map(_userFromFirebase);
  }

  //sign in with email and password
  Future signIn (email, password) async {
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebase(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
  //register with email and password
  Future signUp(String email, String password, String fName, String lName, String idNum) async {
    try{
      AuthResult result = await  _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      await UserController(userId: user.uid).updateUserData(fName, lName, idNum, "0", "0");
      //return _userFromFirebase(user);
      return null;
    }
    catch(e){
      String errorMessage = "Email already exists";
      print(errorMessage);
      return errorMessage;
    }
  }

  Future signOut() async {
    try{
      return await _auth.signOut();
    }
    catch(e){
      print(e.toString());
    }
  }

}