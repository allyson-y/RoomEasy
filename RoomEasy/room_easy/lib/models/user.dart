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
 * Matches
 *
 */
class RmEasyUser {
  final String uid_; //firebase uid token
  String name_;
  String gender_;
  int grade_; // 1-4
  bool surveyComplete_;
  String messageText_;
  String time_;
  String imageURL_;
  String selfDescription_;
  var dob_;
  List<dynamic> matchList_; //list of uids_ that contain matches
  RmEasyUser(
      {this.uid_,
      this.name_,
      this.gender_,
      this.dob_,
      this.grade_,
      this.matchList_,
      this.surveyComplete_,
      this.messageText_,
      this.time_,
      this.imageURL_,
      this.selfDescription_});
}
