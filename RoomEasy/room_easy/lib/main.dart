import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:room_easy/models/chatProfiles.dart';
import 'package:room_easy/screens/authenticate/authenticate.dart';
import 'package:room_easy/screens/authenticate/register.dart';
import 'package:room_easy/screens/authenticate/sign_in.dart';
import 'package:room_easy/screens/survey/survey.dart';
import 'package:room_easy/services/auth.dart';
import 'package:room_easy/services/database.dart';
import 'screens/wrapper.dart';
import 'screens/authenticate/validate.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/authenticate/preregistration.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // read below
  await Firebase.initializeApp(
      /*options: FirebaseOptions(//to launch on web
      apiKey: "AIzaSyCTnzYIoOhiBX_nwsUJYOcvdgQWFZgIMT4", // Your apiKey
      appId: "1:667338333504:web:6422a7666b275248816ea5", // Your appId
      messagingSenderId: "667338333504", // Your messagingSenderId
      projectId: "roomeasy-6caf4", // Your projectId
    ),*/
      ); //have to do this to use firebase
  runApp(RoomEasy());
}

class RoomEasy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User>.value(
          value: AuthService().user,
        ),
        ChangeNotifierProvider(create: (context) => AuthService()),
        StreamProvider<List<RmEasyChatProfile>>.value(
          value: DatabaseService().chatProfiles,
        ),
      ],
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
