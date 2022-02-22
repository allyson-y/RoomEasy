import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:room_easy/models/user.dart';
import 'package:room_easy/services/auth.dart';
import 'package:room_easy/services/database.dart';
import 'package:room_easy/shared/helper_functions.dart';

class Survey extends StatefulWidget with ChangeNotifier {
  @override
  _SurveyState createState() => _SurveyState();
}

class _SurveyState extends State<Survey> {
  int _friendlySliderVal = 100;
  int _selfCleanSliderVal;
  int _roommateCleanSliderVal;
  int _selfSleepStart = 10;
  int _selfSleepEnd = 12;
  int _bedtimeSliderVal;
  int _oftenInRoomSliderVal;
  int _selfMusicSliderVal;
  int _roomateMusicSliderVal;
  int _drinkFreqSliderVal;
  List<String> friendlyRating_ = [
    "not friendly",
    "sort of friendly",
    "average roomie",
    "super friendly",
    "possesive"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: IntroductionScreen(
        onDone: () async {
          // When done button is press
          await DatabaseService()
              .updateUserSurveyCompley(AuthService().auth.currentUser.uid);
          print("DONEEEE");
          widget.notifyListeners();
        },
        skip: const Text("Skip"),
        done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
        showNextButton: true,
        showBackButton: true,
        next: const Icon(Icons.arrow_forward),
        back: const Icon(Icons.arrow_back),
        freeze: true,
        scrollPhysics: const BouncingScrollPhysics(),
        pages: [
          PageViewModel(
            title: "HE",
            bodyWidget: Form(
              child: Column(
                children: <Widget>[
                  //NOTE: Can we encapsulate the Slider-Text combination into a single custom class? A worry is that the variables we pass in not might get passed by reference.
                  Slider(
                      value: (_friendlySliderVal ?? 100.0).toDouble(),
                      min: 100,
                      max: 500,
                      divisions: 4,
                      onChanged: (val) {
                        setState(() {
                          _friendlySliderVal = val.round();
                        });
                      }),
                  Text(friendlyRating_[(_friendlySliderVal * .01).round() - 1]),
                  Slider(
                      value: (_selfCleanSliderVal ?? 100.0).toDouble(),
                      min: 100,
                      max: 500,
                      divisions: 4,
                      onChanged: (val) {
                        setState(() {
                          _selfCleanSliderVal = val.round();
                        });
                      }),
                  Text(friendlyRating_[(_friendlySliderVal * .01).round() - 1]),
                  Slider(
                      value: (_roommateCleanSliderVal ?? 100.0).toDouble(),
                      min: 100,
                      max: 500,
                      divisions: 4,
                      onChanged: (val) {
                        setState(() {
                          _roommateCleanSliderVal = val.round();
                        });
                      }),
                  Text(friendlyRating_[(_friendlySliderVal * .01).round() - 1]),
                ],
              ),
            ),
          ),
          PageViewModel(
            title: "A",
            bodyWidget: Column(
              children: <Widget>[
                RangeSlider(
                  min: 6.0,
                  max: 18.0,
                  divisions: 12,
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
                Text(friendlyRating_[(_friendlySliderVal * .01).round() - 1]),
              ],
            ),
          ),
        ], //pages contain the list of onboarding screens
      ),
    );
  }
}
