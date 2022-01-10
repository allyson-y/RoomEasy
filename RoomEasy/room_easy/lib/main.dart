import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:room_easy/screens/authenticate/authenticate.dart';
import 'package:room_easy/screens/authenticate/register.dart';
import 'package:room_easy/screens/authenticate/sign_in.dart';
import 'package:room_easy/screens/home/survey.dart';
import 'package:room_easy/services/auth.dart';
import 'screens/wrapper.dart';
import 'screens/authenticate/validate.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/authenticate/preregistration.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // read below
  await Firebase.initializeApp(); //have to do this to use firebase
  runApp(RoomEasy());
}

class RoomEasy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
        value: AuthService().user,
        child: MaterialApp(initialRoute: '/', routes: {
          '/': (context) => PreRegistration(),
          '/home': (context) => PreRegistration(),
          '/register': (context) => Wrapper(registration: 'register'),
          '/sign_in': (context) => Wrapper(registration: 'sign_in'),
          '/validate': (context) => Validate(),
          '/survey': (context) => Survey(),
        }));
  }
}
