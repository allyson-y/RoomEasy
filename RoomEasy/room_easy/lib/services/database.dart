import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:room_easy/models/user.dart';
import 'package:room_easy/models/chatProfiles.dart';
import 'package:room_easy/models/chat.dart';

class DatabaseService {
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference chatCollection = FirebaseFirestore.instance.collection('chatrooms');

  Future<void> addUserInfo(RmEasyUser user) async {
    return userCollection
        .doc(user.uid_)
        .set({
          'name': user.name_,
          'grade': user.grade_,
          'gender': user.gender_,
          'matches': user.matchList_,
          'uid': user.uid_,
        })
        .then((value) => print("User ${user.name_} added!"))
        .catchError((error) =>
            print("Failed to add user ${user.name_} due to error $error"));
  }
  /*Future<void> addChatRoomInfo(RmEasyChatRoom room) async{
    return chatCollection.doc(room.chatRoomID_).set({

    })
  }*/
  Future<void> addMessage(RmEasyChat chat) async{
    return chatCollection.doc(chat.chatRoomID_).collection('chats').add({
        'sentByUID': chat.sentByUID_,
        'text': chat.text_,
        'time_sent': chat.time_sent_,
        'ms_since_epoch': chat.ms_since_epoch_,
    }).catchError((error) => print("failed to send message ${chat.text_} due to error $error"));
  }
  List<RmEasyChat> _chatFromSnapshot(QuerySnapshot snapshot, String chatRoomID){
    return snapshot.docs.map((doc){
      return RmEasyChat(
        chatRoomID_: chatRoomID,
        sentByUID_: doc.get('sentByUID'),
        text_: doc.get('text'),
        time_sent_: doc.get("time_sent"),
        ms_since_epoch_: doc.get("ms_since_epoch"),
      );
    }).toList();
  }
  Stream<List<RmEasyChat>> getChats(String chatRoomID)
  {
    return chatCollection.doc(chatRoomID).collection('chats').orderBy('ms_since_epoch').snapshots().map((QuerySnapshot snapshot) => _chatFromSnapshot(snapshot, chatRoomID));
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
        uid_: doc.get('uid'),
      );
    }).toList();
  }

  Stream<List<RmEasyChatProfile>> get chatProfiles {
    print("chatprofiles called");
    return userCollection.snapshots().map(_chatProfilesFromSnapshot);
  }
}
