import 'package:flutter/material.dart';
import 'package:room_easy/models/chatProfiles.dart';
import 'package:room_easy/screens/home/chat/chat_profile_card.dart';
import 'package:room_easy/services/database.dart';
import 'package:provider/provider.dart';

class MessageScreen extends StatefulWidget {

  @override
  _MessageScreenState createState() => _MessageScreenState();
}


class _MessageScreenState extends State<MessageScreen> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    print("MESSAGES SCREEN BUILT");
    List<RmEasyChatProfile> profileList_ = Provider.of<List<RmEasyChatProfile>>(context);
    print(profileList_);
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 16,right: 16,top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Conversations",style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold),),
                    Container(
                      padding: EdgeInsets.only(left: 8,right: 8,top: 2,bottom: 2),
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.pink[50],
                      ),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.add,color: Colors.pink,size: 20,),
                          SizedBox(width: 2,),
                          Text("Add New",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            ListView.builder(
              itemCount: profileList_.A length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 16),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index){
                return ProfileCard(
                  name: profileList_[index].name,
                  messageText: profileList_[index].messageText,
                  imageUrl: profileList_[index].imageURL,
                  time: profileList_[index].time,
                  isMessageRead: (index == 0 || index == 3)?true:false, //CHANGE THIS
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
