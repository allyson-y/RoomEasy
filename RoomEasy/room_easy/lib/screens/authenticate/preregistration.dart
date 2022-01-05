import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:room_easy/services/auth.dart';
import 'package:room_easy/screens/wrapper.dart';

class PreRegistration extends StatefulWidget {
  @override
  _PreRegistrationState createState() => _PreRegistrationState();
}

class _PreRegistrationState extends State<PreRegistration> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Image.asset(
            'assets/roomEasy.png',
            width: 200.0,
          ),
          SizedBox(
            height: 60.0,
          ),
          TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue[400],
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: Text(
                'Create new account',
                style: TextStyle(color: Colors.white),
              )),
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/sign_in');
                //return Wrapper(registration: false);
              },
              child: Text('Log in')),
        ],
      ),
    );
  }
}
