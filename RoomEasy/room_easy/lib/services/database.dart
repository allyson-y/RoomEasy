import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:room_easy/models/user.dart';
import 'package:room_easy/models/chatProfiles.dart';

class DatabaseService {
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> addUserInfo(RmEasyUser user) async {
    return userCollection
        .doc(user.uid_)
        .set({
          'name': user.name_,
          'grade': user.grade_,
          'gender': user.gender_,
          'matches': user.matchList_,
        })
        .then((value) => print("User ${user.name_} added!"))
        .catchError((error) =>
            print("Failed to add user ${user.name_} due to error $error"));
  }

  List<RmEasyChatProfile> _chatProfilesFromSnapshot(QuerySnapshot snapshot) {
    print("translator method claled");
    print(snapshot.docs.first.get('name'));
    return snapshot.docs.map((doc) {
      print("hello");
      return RmEasyChatProfile(
        name: doc.get('name'),
        messageText: "PLACEMENT TEXT IN CLASS DATABASE",
        time: "PLACEMENT TIME",
        imageURL:
            "https://static.wikia.nocookie.net/sml/images/3/35/5FF627B3-ADEB-47ED-BC0E-29908332F74C.webp/revision/latest?cb=20210422030240",
      );
    }).toList();
  }

  Stream<List<RmEasyChatProfile>> get chatProfiles {
    print("chatprofiles called");
    return userCollection.snapshots().map(_chatProfilesFromSnapshot);
  }
}
