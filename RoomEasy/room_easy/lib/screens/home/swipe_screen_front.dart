import 'package:flutter/material.dart';
import 'package:room_easy/models/user.dart';
import 'package:room_easy/services/database.dart';
import 'package:room_easy/services/auth.dart';
import 'package:provider/provider.dart';

/**
 * Created by Kevin Kim kekim@hmc.edu on 2/26/22 at 1:58 AM
 */
class SwipeScreenFront extends StatefulWidget {
  SwipeScreenFront(this.user_);

  RmEasyUser user_;
  @override
  _SwipeScreenFrontState createState() => _SwipeScreenFrontState();
}

class _SwipeScreenFrontState extends State<SwipeScreenFront> {
  @override
  Widget build(BuildContext context) {
    final currUser = Provider.of<RmEasyUser>(context);
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    "https://i5.wal.co/asr/d90b3969-acb4-4ed1-ae23-2c505b7baf33.100242461d922915c2159e4b84e35366.jpeg?odnBg=ffffff&odnHeight=612&odnWidth=612",
                  ),
                  radius: 50.0,
                ),
                SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ),
          Container(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 30.0, horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    widget.user_.selfDescription_ ?? "NO DESC.",
                    style: TextStyle(
                      fontSize: 22.0,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                      letterSpacing: 2.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
              width: 300.00,
              //Match Button!
              child: ElevatedButton(
                onPressed: () async {
                  await DatabaseService().updateMatchList(
                      AuthService().auth.currentUser.uid, widget.user_.uid_);
                },
                child: Container(
                  constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                  alignment: Alignment.center,
                  child: Text(
                    //this logic could be made more readable.
                    (currUser.matchList_ == null ||
                            !currUser.matchList_.contains(widget.user_.uid_))
                        ? "match"
                        : "already sent",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 26.0,
                        fontWeight: FontWeight.w300),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
