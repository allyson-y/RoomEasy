import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:room_easy/models/user.dart';
import 'package:room_easy/screens/home/chat/chat_profile_card.dart';

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
    RmEasyUser currUser = Provider.of<RmEasyUser>(context);
    /* List<RmEasyUser> profileList_ = Provider.of<List<RmEasyUser>>(context);*/ //NOTE: This is a stream that isn't filtered. Maybe use this when presenting?

    List<RmEasyUser> profileList_ = Provider.of<List<RmEasyUser>>(context)
        .where(
            (val) => ((currUser.matchList_ != null) & (val.matchList_ != null)))
        .toList();
    /*currUser.matchList_.contains(val.uid_) &
            val.matchList_.contains(currUser.uid_))*/
    //allows real-time refresh of chat profiles!

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
                        name: profileList_[index].name_,
                        messageText: profileList_[index].messageText_,
                        imageUrl: profileList_[index].imageURL_,
                        time: profileList_[index].time_,
                        isMessageRead:
                            (index == 0 || index == 3) ? true : false,
                        //CHANGE THIS
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
