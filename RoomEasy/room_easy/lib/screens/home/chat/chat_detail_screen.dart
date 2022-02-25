import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:room_easy/models/chat.dart';
import 'package:room_easy/models/chatProfiles.dart';
import 'package:room_easy/screens/home/chat/message_list.dart';
import 'package:room_easy/services/database.dart';
import 'package:room_easy/services/auth.dart';

class ChatDetailPage extends StatefulWidget {
  String chatRoomID_;
  String uid_ = FirebaseAuth.instance.currentUser.uid;
  RmEasyChatProfile chatProfile_;

  ChatDetailPage({this.chatProfile_, this.chatRoomID_});

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<RmEasyChat>>.value(
      value: DatabaseService().getChats(widget.chatRoomID_),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          flexibleSpace: SafeArea(
            child: Container(
              padding: EdgeInsets.only(right: 16),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.chatProfile_.imageURL),
                    maxRadius: 20,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          widget.chatProfile_.name,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          "Online",
                          style: TextStyle(
                              color: Colors.grey.shade600, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.settings,
                    color: Colors.black54,
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Stack(
          children: <Widget>[
            MessageList(
              chatRoomID_: widget.chatRoomID_,
              uid_: widget.uid_,
            ),
          ],
        ),
      ),
    );
  }
}
