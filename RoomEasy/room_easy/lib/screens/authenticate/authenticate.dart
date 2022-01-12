import 'package:flutter/material.dart';
import 'sign_in.dart';
import 'register.dart';
import 'preregistration.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  static const int PRE_REGISTRATION = 0;
  static const int SIGN_IN = 1;
  static const int REGISTER = 2;
  int showSignIn = 0;
  void toggleView(int state) {
    setState(() {
      showSignIn = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (showSignIn)
    {
      case PRE_REGISTRATION:
        return PreRegistration(toggleView: toggleView,);
        break;
      case (SIGN_IN):
        return SignIn(toggleView: toggleView,);
        break;
      case (REGISTER):
        return Register(toggleView: toggleView,);
        break;
    }

  }
}
