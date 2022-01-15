import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:room_easy/models/chat.dart';
class MessageList extends StatefulWidget {
  String chatRoomID_;
  String uid_;

  MessageList({this.chatRoomID_, this.uid_});


  @override
  _MessageListState createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  @override
  Widget build(BuildContext context) {
    final messages = Provider.of<List<RmEasyChat>>(context) ?? [];
    return Stack(
      children: <Widget>[
        ListView.builder(
          itemCount: messages.length,
          shrinkWrap: true,
          padding: EdgeInsets.only(top: 10, bottom: 10),
          itemBuilder: (context, index) {
            return Container(
              padding:
              EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
              child: Align(
                alignment: (messages[index].sentByUID_ != widget.uid_
                    ? Alignment.topLeft
                    : Alignment.topRight),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: (messages[index].sentByUID_ != widget.uid_
                        ? Colors.grey.shade200
                        : Colors.blue[200]),
                  ),
                  padding: EdgeInsets.all(16),
                  child: Text(
                    messages[index].text_,
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
            );
          },
        ),

      ],
    );
  }
}
