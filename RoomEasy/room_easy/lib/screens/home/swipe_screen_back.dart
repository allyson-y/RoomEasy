import 'package:flutter/material.dart';
import 'package:room_easy/models/user.dart';
import 'package:room_easy/services/database.dart';
import 'package:room_easy/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:page_flip_builder/page_flip_builder.dart';

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
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
    );
  }
}
