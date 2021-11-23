import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:smart_queue_assist/Model/User.dart';

class UserController{

  final String userId;
  UserController({this.userId});
  final CollectionReference userCollection = Firestore.instance.collection('user');

  Future updateUserData(String fName, String lName, String idNum, String queue, String phone) async{
    return await userCollection.document(userId).setData({
      'first_name'  : fName,
      'last_name'   : lName,
      'id_number'   : idNum,
      'role'        : 'user',
      'queueNumber' : queue,
      'PhoneNum'    : phone
    });
  }

  UserData _userFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      userId: userId,
      fName: snapshot.data['first_name'],
      lName: snapshot.data['last_name'],
      idNum: snapshot.data['id_number'],
      role: snapshot.data['role'],
      queueNumber: snapshot.data['queueNumber'],
      phoneNumber: snapshot.data['PhoneNum'],
      );
  }

  Stream<UserData> get userData{
  return userCollection.document(userId).snapshots().map(_userFromSnapshot);
  }

  // List<UserList> _userListFromSnapshot(QuerySnapshot snapshot){
  //   return snapshot.documents.map((doc){
  //     return UserList(
  //       name: doc.data['name'],
  //       role: doc.data['role']
  //     );
  //   }).toList();
  // }

  // Stream<List<UserList>> get userList{
  //   return userCollection.snapshots().map(_userListFromSnapshot);
  // }

}

