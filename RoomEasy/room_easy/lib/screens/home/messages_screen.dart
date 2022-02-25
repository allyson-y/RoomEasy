import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
    //NOTE:eventually restrict chat profiles to only those you "matched" with.
    List<RmEasyChatProfile> profileList_ = Provider.of<List<RmEasyChatProfile>>(
        context); //allows real-time refresh of chat profiles!
    print(profileList_);
    return (profileList_ == null)
        ? SpinKitDancingSquare(
            color: Colors.lightBlue,
            size: 50,
          )
        : Scaffold(
            backgroundColor: Color(0xffffefaf),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SafeArea(
                    child: Padding(
                      padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Conversations",
                            style: TextStyle(
                                fontSize: 32, fontWeight: FontWeight.bold),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                left: 8, right: 8, top: 2, bottom: 2),
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Color(0x50e24e3e),
                            ),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.add,
                                  color: Color(0xffe24e3e),
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  "Add New",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  ListView.builder(
                    itemCount: profileList_.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 16),
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ProfileCard(
                        name: profileList_[index].name,
                        messageText: profileList_[index].messageText,
                        imageUrl: profileList_[index].imageURL,
                        time: profileList_[index].time,
                        isMessageRead: (index == 0 || index == 3)
                            ? true
                            : false, //CHANGE THIS
                        uidReceiver_: profileList_[index].uid_,
                      );
                    },
                  ),
                ],
              ),
            ),
          );
  }
}
