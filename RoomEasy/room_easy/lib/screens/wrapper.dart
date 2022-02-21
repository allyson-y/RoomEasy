import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:room_easy/models/user.dart';
import 'package:room_easy/screens/authenticate/authenticate.dart';
import 'package:room_easy/screens/survey/survey.dart';
import 'package:room_easy/services/auth.dart';
import 'package:room_easy/services/database.dart';

import 'home/home_screen.dart';

class Wrapper extends StatefulWidget {
  final String
      registration; //true means deals with registration, false means deals with signon
  Wrapper({this.registration});

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  void initState() {
    print("STATE INIT");
    // TODO: implement initState
    if (AuthService().auth.currentUser != null) {
      AuthService().auth.currentUser.reload();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final _auth = context.watch<AuthService>().auth;

    if (user == null || !_auth.currentUser.emailVerified) {
      return Authenticate();
    } else {
      print("this is user: $user");
      return StreamBuilder<RmEasyUser>(
        stream: DatabaseService().getUserInfo(user.uid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data.surveyComplete_ ? Home() : Survey();
          } else {
            return SpinKitChasingDots(
              color: Colors.blue,
              size: 50,
            );
          }

          print(snapshot.data);
        },
      );
    }
  }
}
