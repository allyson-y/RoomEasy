import 'package:flutter/material.dart';
import 'package:room_easy/services/auth.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:room_easy/models/user.dart';
import 'package:room_easy/services/database.dart';
import 'package:room_easy/shared/helper_functions.dart';

String _profileText = 'Hi! I am Abby. I am a rising freshman. I love knitting.';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      "Profile",
                      style:
                      TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: () async {
                        await AuthService().signOut();
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 8, right: 8, top: 2, bottom: 2),
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color(0xffe24e3e),
                        ),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.exit_to_app,
                              color: Colors.black,
                              size: 20,
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Text(
                              "Sign Out",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 10.0),
                  child: new Image.asset(
                    'assets/profile.png',
                    width: 200.0,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(40.0),
                  padding: const EdgeInsets.all(3.0),
                  child: Center(
                    child: Text(_profileText,
                        style: TextStyle(fontSize: 15.0)),
                  ),
                ),
                TextButton(
                    style: TextButton.styleFrom(
                      primary: Color(0xffe24e3e),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditProfileScreen()),
                      );
                    },
                    child: Text('Edit Profile')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class EditProfileScreen extends StatefulWidget {
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  //const helpScreen({Key? key}) : super(key: key);

  int _friendlySliderVal = 100;
  int _selfCleanSliderVal;
  int _roommateCleanSliderVal;
  int _selfSleepStart = 10;
  int _selfSleepEnd = 12;
  int _selfMusicSliderVal = 100;
  int _noiseSensitive = 100;
  int _drinkFreqSliderVal;
  int _roommateDrinkFreqSliderVal;
  int _friendsOverSliderVal = 100;
  int _petsSensitive;

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
        appBar: AppBar(
          title: const Text('Edit Profile'),
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(4.0),
            physics: BouncingScrollPhysics(),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextField(
                      controller: TextEditingController(text: _profileText),
                      onChanged: (text) {
                        _profileText = text;
                      }
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 5.0),
                    padding: const EdgeInsets.all(3.0),
                    child: Center(
                      child: Text(
                          'Do you prefer socializing or keeping to yourself?',
                          style: TextStyle(fontSize: 15.0)),
                    ),
                  ),
                  Slider(
                      label: friendlyRating_[(_friendlySliderVal * .01)
                          .round() - 1],
                      value: (_friendlySliderVal ?? 100.0).toDouble(),
                      min: 100,
                      max: 500,
                      divisions: 4,
                      onChanged: (val) {
                        setState(() {
                          _friendlySliderVal = val.round();
                        });
                      }),
                  Container(
                    margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 5.0),
                    padding: const EdgeInsets.all(3.0),
                    child: Center(
                      child: Text('How clean are you?',
                          style: TextStyle(fontSize: 15.0)),
                    ),
                  ),
                  Slider(
                      label: "${(_selfCleanSliderVal ?? 100.0).toInt() ~/ 100}",
                      value: (_selfCleanSliderVal ?? 100.0).toDouble(),
                      min: 100,
                      max: 500,
                      divisions: 4,
                      onChanged: (val) {
                        setState(() {
                          _selfCleanSliderVal = val.round();
                        });
                      }),
                  Container(
                    margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 5.0),
                    padding: const EdgeInsets.all(3.0),
                    child: Center(
                      child: Text('How clean do you want your roommate to be?',
                          style: TextStyle(fontSize: 15.0)),
                    ),
                  ),
                  Slider(
                      label: "${(_roommateCleanSliderVal ?? 100.0).toInt() ~/
                          100}",
                      value: (_roommateCleanSliderVal ?? 100.0).toDouble(),
                      min: 100,
                      max: 500,
                      divisions: 4,
                      onChanged: (val) {
                        setState(() {
                          _roommateCleanSliderVal = val.round();
                        });
                      }),
                  Container(
                    margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 5.0),
                    padding: const EdgeInsets.all(3.0),
                    child: Center(
                      child: Text('When do sleep at night?',
                          style: TextStyle(fontSize: 15.0)),
                    ),
                  ),
                  RangeSlider(
                    min: 6.0,
                    max: 18.0,
                    divisions: 12,
                    values: RangeValues((_selfSleepStart ?? 10).toDouble(),
                        (_selfSleepEnd ?? 12).toDouble()),
                    labels: RangeLabels(
                        HelperFunctions()
                            .sleepTimeFormat(_selfSleepStart.round()),
                        HelperFunctions()
                            .sleepTimeFormat(_selfSleepEnd.round())),
                    onChanged: (values) {
                      setState(() {
                        _selfSleepStart = values.start.round();
                        _selfSleepEnd = values.end.round();
                      });
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 5.0),
                    padding: const EdgeInsets.all(3.0),
                    child: Center(
                      child: Text(
                          'How loud do you listen to music/videos?',
                          style: TextStyle(fontSize: 15.0)),
                    ),
                  ),
                  Slider(
                      label: musicRating_[(_selfMusicSliderVal * .01).round() -
                          1],
                      value: (_selfMusicSliderVal ?? 100.0).toDouble(),
                      min: 100,
                      max: 500,
                      divisions: 4,
                      onChanged: (val) {
                        setState(() {
                          _selfMusicSliderVal = val.round();
                        });
                      }),
                  Container(
                    margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 5.0),
                    padding: const EdgeInsets.all(3.0),
                    child: Center(
                      child: Text('Are you sensitive to noise?',
                          style: TextStyle(fontSize: 15.0)),
                    ),
                  ),
                  Slider(
                      label: (_noiseSensitive ?? 100.0).toDouble() == 100.0
                          ? "no"
                          : "yes",
                      value: (_noiseSensitive ?? 100.0).toDouble(),
                      min: 100,
                      max: 200,
                      divisions: 1,
                      onChanged: (val) {
                        setState(() {
                          _noiseSensitive = val.round();
                        });
                      }),
                  Container(
                    margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 5.0),
                    padding: const EdgeInsets.all(3.0),
                    child: Center(
                      child: Text('Do you drink/smoke?',
                          style: TextStyle(fontSize: 15.0)),
                    ),
                  ),
                  Slider(
                      label: (_drinkFreqSliderVal ?? 100.0).toDouble() == 100.0
                          ? "no"
                          : "yes",
                      value: (_drinkFreqSliderVal ?? 100.0).toDouble(),
                      min: 100,
                      max: 200,
                      divisions: 1,
                      onChanged: (val) {
                        setState(() {
                          _drinkFreqSliderVal = val.round();
                        });
                      }),
                  Container(
                    margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 5.0),
                    padding: const EdgeInsets.all(3.0),
                    child: Center(
                      child: Text('Do you care if your roommate drinks/smokes?',
                          style: TextStyle(fontSize: 15.0)),
                    ),
                  ),
                  Slider(
                      label: (_roommateDrinkFreqSliderVal ?? 100.0)
                          .toDouble() == 100.0 ? "no" : "yes",
                      value: (_roommateDrinkFreqSliderVal ?? 100.0).toDouble(),
                      min: 100,
                      max: 200,
                      divisions: 1,
                      onChanged: (val) {
                        setState(() {
                          _roommateDrinkFreqSliderVal = val.round();
                        });
                      }),
                  Container(
                    margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 5.0),
                    padding: const EdgeInsets.all(3.0),
                    child: Center(
                      child: Text('Are you comfortable with pets',
                          style: TextStyle(fontSize: 15.0)),
                    ),
                  ),
                  Slider(
                      label: friendsOverRating_[(_friendsOverSliderVal * .01)
                          .round() - 1],
                      value: (_friendsOverSliderVal ?? 100.0).toDouble(),
                      min: 100,
                      max: 500,
                      divisions: 4,
                      onChanged: (val) {
                        setState(() {
                          _friendsOverSliderVal = val.round();
                        });
                      }),
                  Container(
                    margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 5.0),
                    padding: const EdgeInsets.all(3.0),
                    child: Center(
                      child: Text(
                          'How loud do you listen to music/videos?',
                          style: TextStyle(fontSize: 15.0)),
                    ),
                  ),
                  Slider(
                      label: (_petsSensitive ?? 100.0).toDouble() == 100.0
                          ? "no"
                          : "yes",
                      value: (_petsSensitive ?? 100.0).toDouble(),
                      min: 100,
                      max: 200,
                      divisions: 1,
                      onChanged: (val) {
                        setState(() {
                          _petsSensitive = val.round();
                        });
                      }),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Done'),
                    ),
                  ),
                ])));
  }
}
