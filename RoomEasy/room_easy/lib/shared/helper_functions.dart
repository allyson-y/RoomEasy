import 'package:flutter/cupertino.dart';
import 'package:room_easy/models/user.dart';
import 'package:room_easy/screens/home/swipe/swipe_card.dart';

class HelperFunctions {
  String createChatRoomID(String uid_1, String uid_2) {
    if (uid_1.compareTo(uid_2) > 0) {
      return uid_1 + "_" + uid_2;
    } else {
      return uid_2 + "_" + uid_1;
    }
  }

  String sleepTimeFormat(int sleepTime) {
    String x = "";
    if (sleepTime >= 12) {
      if (sleepTime == 12) {
        x += sleepTime.toString();
      } else {
        x += (sleepTime % 12).toString();
      }
      x += " AM";
    } else {
      x += sleepTime.toString() + "PM";
    }
    return x;
  }

  /**
   * converts List<RmEasyUser> into the corresponding List<SwipeCard>
   * important part of swipe_screen.dart
   *
   *
   * NOTE: Probably want to get rid of this and directly put this in the swipe_screen.dart
   */
  List<Widget> mapRmEasyUserToWidget(List<RmEasyUser> userList) {
    return userList.map((user) {
      return SwipeCard(user);
    }).toList();
  }
}
