import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:room_easy/models/user.dart';
class DatabaseService
{
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
  Future<void> addUserInfo(RmEasyUser user) async
  {
    return userCollection.doc(user.uid_).set({
      'name': user.name_,
      'grade': user.grade_,
      'gender': user.gender_,
    }).then((value) => print("User ${user.name_} added!"))
    .catchError((error) => print("Failed to add user ${user.name_} due to error $error"));
  }
}