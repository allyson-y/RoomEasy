import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:room_easy/services/auth.dart';
import 'screens/wrapper.dart';
import 'screens/authenticate/validate.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // read below
  await Firebase.initializeApp(); //have to do this to use firebase
  runApp(MaterialApp(initialRoute: '/', routes: {
    '/': (context) => RoomEasy(),
    '/home': (context) => RoomEasy(),
    '/register': (context) => RoomEasy(),
    '/sign_in': (context) => RoomEasy(),
    '/validate': (context) => Validate(),
  }));
}

class RoomEasy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
        value: AuthService().user,
        child: MaterialApp(
          home: Wrapper(),
        ));
  }
}
