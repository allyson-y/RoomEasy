import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:room_easy/screens/authenticate/authenticate.dart';
import 'package:room_easy/screens/authenticate/preregistration.dart';
import 'package:room_easy/screens/authenticate/sign_in.dart';
import 'package:room_easy/screens/home/survey.dart';
import 'package:room_easy/services/auth.dart';
import 'package:room_easy/screens/authenticate/register.dart';
class Wrapper extends StatefulWidget {

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (AuthService().auth.currentUser != null) {
      AuthService().auth.currentUser.reload();
    }

  }
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final _auth = AuthService().auth;

    if (user == null || !_auth.currentUser.emailVerified){
      print("USER NOT HERE");
      return PreRegistration();
    } else {
      print(_auth.currentUser.emailVerified);
      print("USER IS HEREEE");
      return Survey();
    }
    return Container();
  }
}

