import 'package:flutter/material.dart';
import 'package:room_easy/models/user.dart';
import 'package:room_easy/services/database.dart';
import 'package:room_easy/services/auth.dart';
import 'package:provider/provider.dart';

/**
 * Created by Kevin Kim kekim@hmc.edu on 2/26/22 at 1:58 AM
 */
class SwipeScreenBack extends StatefulWidget {
  SwipeScreenBack(this.user_);
  RmEasyUser user_;
  @override
  _SwipeScreenBackState createState() => _SwipeScreenBackState();
}

class _SwipeScreenBackState extends State<SwipeScreenBack> {
  String _profileText = "JERRY";
  String _noisePreference = "no";
  String _smokeSelf = "no";
  String _smokeRoommate = "yes";
  String _petsPreference = "no";
  int _friendlySliderVal = 100;
  int _selfCleanSliderVal = 3;
  int _roommateCleanSliderVal = 3;
  int _selfSleepStart = 10;
  int _selfSleepEnd = 12;
  int _selfMusicSliderVal = 100;
  int _friendsOver = 100;
  bool _noiseSwitch = false;
  bool _selfDrinkSwitch = false;
  bool _roommateDrinkSwitch = false;
  bool _petSlider = false;

  List<String> friendlyRating_ = [
    "keep to myself",
    "mostly keep to myself",
    "average",
    "enjoy socializing",
    "love socializing"
  ];
  List<String> musicRating_ = [
    "don't listen to music",
    "quietly with earphones",
    "loudly with earphones",
    "without earphones",
    "blast on speaker"
  ];
  List<String> friendsOverRating_ = [
    "never",
    "occasionally",
    "sometimes",
    "frequently",
    "all the time"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(4.0),
        physics: BouncingScrollPhysics(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          Text(
            "Profile",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          Text(
            _profileText,
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10.0,
          ),
          const Divider(
            height: 10,
            thickness: 1,
            color: Color(0x69272324),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 5.0),
            padding: const EdgeInsets.all(3.0),
            //child: Center(
            child: Text('Do you prefer socializing or keeping to yourself?',
                style: TextStyle(fontSize: 15.0)),
            //),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 5.0),
            padding: const EdgeInsets.all(3.0),
            //child: Center(
            child: Text(friendlyRating_[1], style: TextStyle(fontSize: 15.0)),
          ),
          SizedBox(
            height: 10.0,
          ),
          const Divider(
            height: 10,
            thickness: 1,
            color: Color(0x69272324),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 5.0),
            padding: const EdgeInsets.all(3.0),
            //child: Center(
            child: Text('How clean are you?', style: TextStyle(fontSize: 15.0)),
            //,
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 5.0),
            padding: const EdgeInsets.all(3.0),
            //child: Center(
            child: Text(_selfCleanSliderVal.toString(),
                style: TextStyle(fontSize: 15.0)),
            //,
          ),
          SizedBox(
            height: 10.0,
          ),
          const Divider(
            height: 10,
            thickness: 1,
            color: Color(0x69272324),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 5.0),
            padding: const EdgeInsets.all(3.0),
            child: Text('How clean do you want your roommate to be?',
                style: TextStyle(fontSize: 15.0)),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 5.0),
            padding: const EdgeInsets.all(3.0),
            child: Text(_roommateCleanSliderVal.toString(),
                style: TextStyle(fontSize: 15.0)),
          ),
          SizedBox(
            height: 10.0,
          ),
          const Divider(
            height: 10,
            thickness: 1,
            color: Color(0x69272324),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 5.0),
            padding: const EdgeInsets.all(3.0),
            child: Text('When do you sleep at night?',
                style: TextStyle(fontSize: 15.0)),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 5.0),
            padding: const EdgeInsets.all(3.0),
            //child: Center(
            child: Text(
                _selfSleepStart.toString() + " to " + _selfSleepEnd.toString(),
                style: TextStyle(fontSize: 15.0)),
            //),
          ),
          SizedBox(
            height: 10.0,
          ),
          const Divider(
            height: 10,
            thickness: 1,
            color: Color(0x69272324),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 5.0),
            padding: const EdgeInsets.all(3.0),
            child: Text('Are you sensitive to noise?',
                style: TextStyle(fontSize: 15.0)),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 5.0),
            padding: const EdgeInsets.all(3.0),
            child: Text(_noisePreference, style: TextStyle(fontSize: 15.0)),
          ),
          SizedBox(
            height: 10.0,
          ),
          const Divider(
            height: 10,
            thickness: 1,
            color: Color(0x69272324),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 5.0),
            padding: const EdgeInsets.all(3.0),
            //child: Center(
            child: Text('How loud do you listen to music/videos?',
                style: TextStyle(fontSize: 15.0)),
            //),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 5.0),
            padding: const EdgeInsets.all(3.0),
            //child: Center(
            child: Text(musicRating_[2], style: TextStyle(fontSize: 15.0)),
            //),
          ),
          SizedBox(
            height: 10.0,
          ),
          const Divider(
            height: 10,
            thickness: 1,
            color: Color(0x69272324),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 5.0),
            padding: const EdgeInsets.all(3.0),
            child:
                Text('Do you drink/smoke?', style: TextStyle(fontSize: 15.0)),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 5.0),
            padding: const EdgeInsets.all(3.0),
            child: Text(_smokeSelf, style: TextStyle(fontSize: 15.0)),
          ),
          SizedBox(
            height: 10.0,
          ),
          const Divider(
            height: 10,
            thickness: 1,
            color: Color(0x69272324),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 5.0),
            padding: const EdgeInsets.all(3.0),
            child: Text('Do you care if your roommate drinks/smokes?',
                style: TextStyle(fontSize: 14.0)),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 5.0),
            padding: const EdgeInsets.all(3.0),
            child: Text(_smokeRoommate, style: TextStyle(fontSize: 14.0)),
          ),
          SizedBox(
            height: 10.0,
          ),
          const Divider(
            height: 10,
            thickness: 1,
            color: Color(0x69272324),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 5.0),
            padding: const EdgeInsets.all(3.0),
            child: Text('Are you comfortable with pets?',
                style: TextStyle(fontSize: 14.0)),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 5.0),
            padding: const EdgeInsets.all(3.0),
            child: Text(_petsPreference, style: TextStyle(fontSize: 14.0)),
          ),
          SizedBox(
            height: 10.0,
          ),
          const Divider(
            height: 10,
            thickness: 1,
            color: Color(0x69272324),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 5.0),
            padding: const EdgeInsets.all(3.0),
            //child: Center(
            child: Text('How often do you have friends over?',
                style: TextStyle(fontSize: 15.0)),
            //),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 5.0),
            padding: const EdgeInsets.all(3.0),
            //child: Center(
            child:
                Text(friendsOverRating_[2], style: TextStyle(fontSize: 15.0)),
            //),
          ),
          SizedBox(
            height: 10.0,
          ),
          const Divider(
            height: 10,
            thickness: 1,
            color: Color(0x69272324),
          ),
        ]),
      ),
    );
  }
}
