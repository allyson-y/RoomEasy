import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:room_easy/models/user.dart';
import 'package:room_easy/screens/home/swipe_screen_back.dart';
import 'package:room_easy/screens/home/swipe_screen_front.dart';
import 'package:room_easy/services/auth.dart';

/**
 * Created by Kevin Kim kekim@hmc.edu on 2/22/22 at 2:45 AM
 *
 *
 *
 */
//THIS IS CURRENTLY JUST A SKELETON TEMPLATE
class SwipeCard extends StatefulWidget {
  bool inMatchList_ = false;
  RmEasyUser user_;

  SwipeCard(@required this.user_);

  @override
  _SwipeCardState createState() => _SwipeCardState();
}

class _SwipeCardState extends State<SwipeCard> {
  @override
  /*void initState() async {
    // TODO: implement initState
    super.initState();
    widget.inMatchList_ = false;
    widget.inMatchList_ = await DatabaseService()
        .getUserSnapshot(AuthService().auth.currentUser.uid)
        .then((user) {
      return user.matchList_.contains(widget.user_.uid_);
    });
    8/
}
   */

  @override
  Widget build(BuildContext context) {
    final currUser = Provider.of<RmEasyUser>(context);
    final _auth = context.watch<AuthService>().auth;
    String buttonText = "";

    return (currUser == null)
        ? SpinKitDoubleBounce(
            color: Colors.pink,
            size: 50,
          )
        : Card(
            margin: EdgeInsets.all(20),
            child: FlipCard(
              direction: FlipDirection.HORIZONTAL,
              front: SwipeScreenFront(widget.user_),
              back: SwipeScreenBack(widget.user_),
            ),
          );
  }
}
