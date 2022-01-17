import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:room_easy/models/chat.dart';
import 'package:room_easy/services/database.dart';

class MessageList extends StatefulWidget {
  String chatRoomID_;
  String uid_;
  MessageList({this.chatRoomID_, this.uid_});

  @override
  _MessageListState createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  ScrollController scrollController_ = new ScrollController();
  final messageTextController_ = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final messages = Provider.of<List<RmEasyChat>>(context) ?? [];
    return Stack(
      children: <Widget>[
        ListView.builder(
          controller: scrollController_,
          itemCount: messages.length,
          shrinkWrap: true,
          padding: EdgeInsets.only(
              top: 10, bottom: MediaQuery.of(context).size.height * .1),
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
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
            height: MediaQuery.of(context).size.height * .1,
            width: double.infinity,
            color: Colors.white,
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    //METHOD TO ADD IMAGE GOES HERE
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: Colors.lightBlue,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: TextField(
                    controller: messageTextController_,
                    decoration: InputDecoration(
                        hintText: "Write message...",
                        hintStyle: TextStyle(color: Colors.black54),
                        border: InputBorder.none),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                FloatingActionButton(
                  onPressed: () async {
                    setState(() {
                      DateTime dt = DateTime.now();
                      DatabaseService().addMessage(RmEasyChat(
                          text_: messageTextController_.text,
                          sentByUID_: widget.uid_,
                          chatRoomID_: widget.chatRoomID_,
                          time_sent_: dt.toString(),
                          ms_since_epoch_: dt.millisecondsSinceEpoch));
                    });
                    print("scrollthing");
                    scrollController_.animateTo(
                      scrollController_.position.maxScrollExtent,
                      curve: Curves.easeOut,
                      duration: const Duration(milliseconds: 300),
                    );
                  },
                  child: Icon(
                    Icons.send,
                    color: Colors.white,
                    size: 18,
                  ),
                  backgroundColor: Colors.blue,
                  elevation: 0,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
