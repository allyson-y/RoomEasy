import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:room_easy/services/auth.dart';
import 'package:room_easy/services/database.dart';
import 'package:room_easy/shared/helper_functions.dart';

class Survey extends StatefulWidget with ChangeNotifier {
  @override
  _SurveyState createState() => _SurveyState();
}

class _SurveyState extends State<Survey> {
  bool _showNextButton = true;
  bool _showDoneButton = true;
  int _friendlySliderVal = 100;
  int _selfCleanSliderVal;
  int _roommateCleanSliderVal;
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
      body: IntroductionScreen(
        globalBackgroundColor: Color(0xffffefaf),
        onDone: () async {
          // When done button is press
          await DatabaseService()
              .updateUserSurveyCompley(AuthService().auth.currentUser.uid);
          print("DONEEEE");
          widget.notifyListeners();
        },
        skip: const Text("Skip"),
        done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
        showNextButton: _showNextButton,
        showBackButton: true,
        next: const Icon(Icons.arrow_forward),
        back: const Icon(Icons.arrow_back),
        freeze: true,
        scrollPhysics: const BouncingScrollPhysics(),
        pages: [
          PageViewModel(
            title: "Customize your preferences",
            bodyWidget: Form(
              child: Column(children: <Widget>[
                //NOTE: Can we encapsulate the Slider-Text combination into a single custom class? A worry is that the variables we pass in not might get passed by reference.
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
                    label:
                        friendlyRating_[(_friendlySliderVal * .01).round() - 1],
                    value: (_friendlySliderVal ?? 100.0).toDouble(),
                    min: 100,
                    max: 500,
                    divisions: 4,
                    activeColor: Color(0xff201cbb),
                    inactiveColor: Color(0x88201cbb),
                    onChanged: (val) {
                      setState(() {
                        _friendlySliderVal = val.round();
                      });
                    }),
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
                    activeColor: Color(0xff201cbb),
                    inactiveColor: Color(0x88201cbb),
                    onChanged: (val) {
                      setState(() {
                        _selfCleanSliderVal = val.round();
                      });
                    }),
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
                  child: Center(
                    child: Text('How clean do you want your roommate to be?',
                        style: TextStyle(fontSize: 15.0)),
                  ),
                ),
                Slider(
                    label:
                        "${(_roommateCleanSliderVal ?? 100.0).toInt() ~/ 100}",
                    value: (_roommateCleanSliderVal ?? 100.0).toDouble(),
                    min: 100,
                    max: 500,
                    divisions: 4,
                    activeColor: Color(0xff201cbb),
                    inactiveColor: Color(0x88201cbb),
                    onChanged: (val) {
                      setState(() {
                        _roommateCleanSliderVal = val.round();
                      });
                    }),
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
                  child: Center(
                    child: Text('When do sleep at night?',
                        style: TextStyle(fontSize: 15.0)),
                  ),
                ),
                RangeSlider(
                  min: 6.0,
                  max: 18.0,
                  divisions: 12,
                  activeColor: Color(0xff201cbb),
                  inactiveColor: Color(0x88201cbb),
                  values: RangeValues((_selfSleepStart ?? 10).toDouble(),
                      (_selfSleepEnd ?? 12).toDouble()),
                  labels: RangeLabels(
                      HelperFunctions()
                          .sleepTimeFormat(_selfSleepStart.round()),
                      HelperFunctions().sleepTimeFormat(_selfSleepEnd.round())),
                  onChanged: (values) {
                    setState(() {
                      _selfSleepStart = values.start.round();
                      _selfSleepEnd = values.end.round();
                    });
                  },
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
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Are you sensitive to noise?',
                            style: TextStyle(fontSize: 15.0)),
                        Switch(
                          value: _noiseSwitch,
                          onChanged: (val) {
                            setState(() {
                              _noiseSwitch = val;
                            });
                          },
                          activeColor: Color(0xff201cbb),
                          inactiveTrackColor: Color(0x88201cbb),
                        ),
                      ]),
                ),
              ]),
            ),
          ),
          PageViewModel(
            title: "Customize your preferences",
            bodyWidget: Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 5.0),
                  padding: const EdgeInsets.all(3.0),
                  child: Center(
                    child: Text('How loud do you listen to music/videos?',
                        style: TextStyle(fontSize: 15.0)),
                  ),
                ),
                Slider(
                    label:
                        musicRating_[(_selfMusicSliderVal * .01).round() - 1],
                    value: (_selfMusicSliderVal ?? 100.0).toDouble(),
                    min: 100,
                    max: 500,
                    divisions: 4,
                    activeColor: Color(0xff201cbb),
                    inactiveColor: Color(0x88201cbb),
                    onChanged: (val) {
                      setState(() {
                        _selfMusicSliderVal = val.round();
                      });
                    }),
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
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Do you drink/smoke?',
                            style: TextStyle(fontSize: 15.0)),
                        Switch(
                          value: _selfDrinkSwitch,
                          onChanged: (val) {
                            setState(() {
                              _selfDrinkSwitch = val;
                            });
                          },
                          activeColor: Color(0xff201cbb),
                          inactiveThumbColor: Color(0x88201cbb),
                        ),
                      ]),
                ),
                SizedBox(
                  height: 10.0,
                ),
                const Divider(
                  height: 10,
                  thickness: 1,
                  color: Color(0x69272324),
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
                  child: Center(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Are you comfortable with pets?',
                              style: TextStyle(fontSize: 14.0)),
                          Switch(
                            value: _petSlider,
                            onChanged: (val) {
                              setState(() {
                                _petSlider = val;
                              });
                            },
                            activeColor: Color(0xff201cbb),
                            inactiveTrackColor: Color(0x88201cbb),
                          ),
                        ]),
                  ),
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
                  child: Center(
                    child: Text('How often do you have friends over?',
                        style: TextStyle(fontSize: 15.0)),
                  ),
                ),
                Slider(
                    label: friendsOverRating_[(_friendsOver * .01).round() - 1],
                    value: (_friendsOver ?? 100.0).toDouble(),
                    min: 100,
                    max: 500,
                    divisions: 4,
                    activeColor: Color(0xff201cbb),
                    inactiveColor: Color(0x88201cbb),
                    onChanged: (val) {
                      setState(() {
                        _friendsOver = val.round();
                      });
                    }),
                SizedBox(
                  height: 10.0,
                ),
                const Divider(
                  height: 10,
                  thickness: 1,
                  color: Color(0x69272324),
                ),
              ],
            ),
          ),
          /**
           * Third Survey Page
           */
          PageViewModel(
            title: "Open Response",
            bodyWidget: Column(
              children: <Widget>[
                Text(
                  "Thought provoking question here?",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 50,
                ),
                TextFormField(
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(labelText: 'Answer here!'),
                  onChanged: (value) {
                    if (value.trim().isNotEmpty) {
                      _showNextButton = true;
                    }
                  },
                )
              ],
            ),
          ),
          PageViewModel(
            title: "Open Response",
            bodyWidget: Column(
              children: <Widget>[
                Text(
                  "Thought provoking question number 2 here?",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 50,
                ),
                TextFormField(
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(labelText: 'Answer here!'),
                )
              ],
            ),
          ),
        ], //pages contain the list of onboarding screens
      ),
    );
  }
}
