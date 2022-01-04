import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:room_easy/screens/authenticate/authenticate.dart';
import 'package:room_easy/screens/home/survey.dart';
import 'package:room_easy/services/auth.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final _auth = AuthService().auth;
    if (user == null || !_auth.currentUser.emailVerified) {
      return Authenticate();
    } else {
      return Survey();
    }
  }
}
