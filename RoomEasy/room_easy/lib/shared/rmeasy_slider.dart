import 'package:flutter/material.dart';

class RmEasySlider extends StatefulWidget {
  /**
   * Params:
   * value: int describing the value of the slider
   * divisions: int describing number of divisions in the slider
   * status_: List of strings (with implicit size of [divisions] describing the status the slider should display
   */
  dynamic value_;
  int divisions_;
  List<String> status_;
  RmEasySlider({this.value_,this.divisions_, this.status_});

  @override
  _RmEasySliderState createState() => _RmEasySliderState();
}

class _RmEasySliderState extends State<RmEasySlider> {
  @override
  Widget build(BuildContext context) {
    return Slider(value: value, onChanged: onChanged)
  }
}
