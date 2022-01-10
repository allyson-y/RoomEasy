import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:room_easy/screens/authenticate/authenticate.dart';
import 'package:room_easy/screens/authenticate/preregistration.dart';
import 'package:room_easy/screens/authenticate/sign_in.dart';
import 'package:room_easy/screens/home/survey.dart';
import 'package:room_easy/services/auth.dart';
import 'package:room_easy/screens/authenticate/register.dart';

class Wrapper extends StatelessWidget {
  final bool registration;//true means deals with registration, false means deals with signon
  Wrapper({this.registration});
  @override
  Widget build(BuildContext context) {
    
    final user = Provider.of<User>(context);
    final _auth = AuthService().auth;
    //if (user == null || !_auth.currentUser.emailVerified) {
    if (user == null){
      print("USER NOT HERE");
      return registration ? Register() : SignIn();
    } else {
      print("USER IS HEREEE");
      return Survey();
    }
  }
}
