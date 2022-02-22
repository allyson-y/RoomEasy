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
    final SurveyScreen = Provider.of<Survey>(context);
    print("REBUILT");

    if (user == null || !_auth.currentUser.emailVerified) {
      return Authenticate();
    } else {
      return FutureBuilder(
          // we use a futurebuilder here since the user data only comes in a future<rmeasyuser> and the build method isn't asynchronous.
          future: DatabaseService().getUserSnapshot(user.uid),
          builder: (BuildContext context, AsyncSnapshot<RmEasyUser> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              print(snapshot.data.uid_);
              return snapshot.data.surveyComplete_ ? Home() : SurveyScreen;
            }
            return SpinKitChasingDots(color: Colors.teal, size: 50);
          });
    }
  }
}
