import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:room_easy/models/chatProfiles.dart';
import 'package:room_easy/screens/home/chat/chat_detail_screen.dart';
import 'package:room_easy/shared/helper_functions.dart';
/**
 * this widget describes the card elements when user swipes to the messages page to see the list of direct messages
 */

class ProfileCard extends StatefulWidget{
  String name;
  String messageText;
  String imageUrl;
  String time;
  bool isMessageRead;
  String uid_ = FirebaseAuth.instance.currentUser.uid;
  String uidReceiver_;
  ProfileCard({@required this.name,@required this.messageText,@required this.imageUrl,@required this.time,@required this.isMessageRead, this.uidReceiver_});
  @override
  _ProfileCardState createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context){
            String chatRoomId = HelperFunctions().createChatRoomID(widget.uid_, widget.uidReceiver_);
            return ChatDetailPage(chatRoomID_: chatRoomId,chatProfile_: RmEasyChatProfile(name: widget.name,messageText: widget.messageText,imageURL: widget.imageUrl,time: widget.time,uid_: widget.uidReceiver_),);
          }
        ));
        //on tap profile thing
      },
      child: Container(
        padding: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.imageUrl),
                    maxRadius: 30,
                  ),
                  SizedBox(width: 16,),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(widget.name, style: TextStyle(fontSize: 16),),
                          SizedBox(height: 6,),
                          Text(widget.messageText,style: TextStyle(fontSize: 13,color: Colors.grey.shade600, fontWeight: widget.isMessageRead?FontWeight.bold:FontWeight.normal),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(widget.time,style: TextStyle(fontSize: 12,fontWeight: widget.isMessageRead?FontWeight.bold:FontWeight.normal),),
          ],
        ),
      ),
    );
  }
}
