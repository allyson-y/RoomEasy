import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:room_easy/models/chat.dart';
import 'package:room_easy/models/chatProfiles.dart';
import 'package:room_easy/models/user.dart';

class DatabaseService {
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference chatCollection =
      FirebaseFirestore.instance.collection('chatrooms');

  Future<void> addUserInfo(RmEasyUser user) async {
    print("USER IS BEING ADDED ");
    return userCollection
        .doc(user.uid_)
        .set({
          'name': user.name_,
          'grade': user.grade_,
          'gender': user.gender_,
          'matches': user.matchList_,
          'uid': user.uid_,
          'surveyComplete': user.surveyComplete_,
        })
        .then((value) => print("User ${user.name_} added!"))
        .catchError((error) =>
            print("Failed to add user ${user.name_} due to error $error"));
  }

  Future<void> updateUserSurveyCompley(String uid_) async {
    return userCollection
        .doc(uid_)
        .update({
          'surveyComplete': true,
        })
        .then((value) => print("$uid_ survey complete"))
        .catchError((error) => print(
            "Failed to add user $uid_ survey not complete due to error $error"))
        .whenComplete(() {
          print("DONE UPDATED");
        });
  }

  Future<void> updateMatchList(String uid_, String uid_add_) async {
    //NOTE: Do we want as a parameter String uid_add_ or List<String> matched_users_add ?
    List<String> l = [uid_add_];
    return userCollection
        .doc(uid_)
        .update({
          'matches': FieldValue.arrayUnion(l),
        })
        .then((value) => print("$uid_ survey complete"))
        .catchError((error) => print(
            "Failed to add user $uid_ survey not complete due to error $error"))
        .whenComplete(() {
          print("DONE UPDATED");
        });
  }

  RmEasyUser _userFromSnapshot(DocumentSnapshot snapshot) {
    return RmEasyUser(
        name_: snapshot.get('name'),
        uid_: snapshot.get('uid'),
        grade_: snapshot.get('grade'),
        gender_: snapshot.get('gender'),
        matchList_: snapshot.get('matches'),
        surveyComplete_: snapshot.get('surveyComplete'));
  }

  //stream that returns user whenever changed
  //NOTE: when would we need this?
  Stream<RmEasyUser> getUserStream(String uid) {
    return userCollection.doc(uid).snapshots().map(_userFromSnapshot);
  }

  /**
   * non stream user data access is below
   */
  Future<RmEasyUser> getUserSnapshot(String uid) {
    print("called usna");
    return userCollection.doc(uid).get().then((DocumentSnapshot snapshot) {
      return _userFromSnapshot(snapshot);
    }).catchError((error) => print(error.toString()));
  }

  /*Future<void> addChatRoomInfo(RmEasyChatRoom room) async{
    return chatCollection.doc(room.chatRoomID_).set({

    })
  }*/
  Future<void> addMessage(RmEasyChat chat) async {
    return chatCollection.doc(chat.chatRoomID_).collection('chats').add({
      'sentByUID': chat.sentByUID_,
      'text': chat.text_,
      'time_sent': chat.time_sent_,
      'ms_since_epoch': chat.ms_since_epoch_,
    }).catchError((error) =>
        print("failed to send message ${chat.text_} due to error $error"));
  }

  List<RmEasyChat> _chatFromSnapshot(
      QuerySnapshot snapshot, String chatRoomID) {
    return snapshot.docs.map((doc) {
      return RmEasyChat(
        chatRoomID_: chatRoomID,
        sentByUID_: doc.get('sentByUID'),
        text_: doc.get('text'),
        time_sent_: doc.get("time_sent"),
        ms_since_epoch_: doc.get("ms_since_epoch"),
      );
    }).toList();
  }

  Stream<List<RmEasyChat>> getChats(String chatRoomID) {
    return chatCollection
        .doc(chatRoomID)
        .collection('chats')
        .orderBy('ms_since_epoch')
        .snapshots()
        .map((QuerySnapshot snapshot) =>
            _chatFromSnapshot(snapshot, chatRoomID));
  }

  List<RmEasyChatProfile> _chatProfilesFromSnapshot(QuerySnapshot snapshot) {
    //print("translator method claled");
    //print(snapshot.docs.first.get('name'));
    return snapshot.docs.map((doc) {
      //print("hello");
      return RmEasyChatProfile(
        name: doc.get('name'),
        messageText: "PLACEMENT TEXT IN CLASS DATABASE",
        time: "PLACEMENT TIME",
        imageURL:
            "https://upload.wikimedia.org/wikipedia/en/thumb/a/a3/CMS_Stags_and_Athenas_logo.svg/1200px-CMS_Stags_and_Athenas_logo.svg.png",
        uid_: doc.get('uid'),
      );
    }).toList();
  }

  List<RmEasyUser> _rmEasyUsersFromSnapshot(QuerySnapshot snapshot) {
    //print("translator method claled");
    //print(snapshot.docs.first.get('name'));
    return snapshot.docs.map((doc) {
      //print("hello");
      print(doc.data());
      return RmEasyUser(
        uid_: doc.get('uid'),
        name_: doc.get('name'),
        matchList_: (doc.get('matches')),
      );
      //return _userFromSnapshot(doc);
    }).toList();
  }

  Stream<List<RmEasyChatProfile>> get chatProfiles {
    print("chatprofiles called");
    return userCollection.snapshots().map(_chatProfilesFromSnapshot);
  }

  Stream<List<RmEasyUser>> get allUsers {
    return userCollection.snapshots().map(_rmEasyUsersFromSnapshot);
  }

/**
 * returns whether uid_add_ is in the matches field of uid_
 *
 * will come in handy in swipe screen
 *
 *
 * hmm nvm we probably don't need this. Commented out for now
    Future<bool> inMatchList(String uid_, String uid_add_) {
    return userCollection.doc(uid_).get().then((DocumentSnapshot snapshot) {
    return (snapshot.get('matches') as List<String>).contains(uid_add_);
    });
    }
 */
}
