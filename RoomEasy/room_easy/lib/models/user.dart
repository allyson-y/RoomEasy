import 'package:flutter/material.dart';

/**
 * Class User
 * Describes a single user in the RoomEasy app
 *
 */
class RmEasyUser {
  final String uid_; //firebase uid token
  RmEasyUser({this.uid_});
}

class RmEasyUserData {
  final String uid_;
  final String name_;
  final String profile_pic_url_;

  RmEasyUserData({this.uid_, this.name_, this.profile_pic_url_});
}
