import 'package:flutter/material.dart';

/**
 * Class User
 * Describes a single user in the RoomEasy app
 * Properties
 * ----------------------------------------------------------
 * UID
 * Name
 * Gender
 * Date of birth
 *
 *
 */
class RmEasyUser {
  final String uid_; //firebase uid token
  String name_;
  String gender_;
  int grade_; // 1-4
  var dob_;
  RmEasyUser({this.uid_, this.name_, this.gender_, this.dob_, this.grade_});
}

